close all
clear
clc

% Reference Music
info_sum = audioinfo('송골매_60_percussive.wav');
[music_sum,~] = audioread('송골매_60_percussive.wav');

sound_L_sum = music_sum(:,1);
sound_L_sum = sound_L_sum/max(abs(sound_L_sum))*1; % Normalization 0 to 1 (Reference Music)
xlab_sum = 0:1/info_sum.SampleRate:info_sum.Duration;
xlab_sum = xlab_sum(1:even(numel(xlab_sum))); % Time Term

beat_arrays = double.empty;

list_instrument = dir('Data\data_augment\*'); %crash, hihat, kick, snare
% new_samples 폴더 내의 모든 음악 processing 진행
for i = 1:numel(list_instrument)-2
    
    list_audio = dir([list_instrument(i+2).folder '\' list_instrument(i+2).name]); % 악기 폴더
    
    for j = 1:numel(list_audio)-2 % 악기 폴더 내 샘플 폴더
        
        info = audioinfo([list_audio(j+2).folder '\' list_audio(j+2).name]); 
        [music,fs] = audioread([list_audio(j+2).folder '\' list_audio(j+2).name]);

        sound_L = music(:,1);
        sound_L = sound_L/max(abs(sound_L))*1; % Normalization 0 to 1 (Drum Sample)

        [beat] = find_optimal_sample(sound_L_sum,sound_L); % xcorr -> islocalmax

        beat_arrays(:,i,j) = beat;
    end
end

class_con_arrays = logical.empty;
max_index = double.empty;

for i = 1:4
    max_corr = max(max(beat_arrays(:,i,:))); 
    class_beat_arrays_0_1(:,i,:) = beat_arrays(:,i,:) == max_corr;
    max_index(i) = find(max(class_beat_arrays_0_1(:,i,:)) == 1); % 각 악기에서 높은 값을 갖는 index
    beats_opt(:,i) = abs(beat_arrays(:,i,max_index(i))/max(max(max(beat_arrays)))); % index를 사용하여 beat를 1개씩 select
end

% crash_beat = beats_opt(:,1);
% hihat_beat = beats_opt(:,2);
% kick_beat = beats_opt(:,3);
% snare_beat = beats_opt(:,4);

samp_opt = double.empty;
n_mav = 441*5;

for i = 1:4
    if i == 1 % crash
        j = max_index(i);
        list_audio = dir([list_instrument(i+2).folder '\' list_instrument(i+2).name]);
        samp_opt{i} = audioread([list_audio(j+2).folder '\' list_audio(j+2).name]);
    elseif i == 2 % hihat
        j = max_index(i);
        list_audio = dir([list_instrument(i+2).folder '\' list_instrument(i+2).name]);
        samp_opt{i} = audioread([list_audio(j+2).folder '\' list_audio(j+2).name]);
    elseif i == 3 % kick
        j = max_index(i);
        list_audio = dir([list_instrument(i+2).folder '\' list_instrument(i+2).name]);
        samp_opt{i} = audioread([list_audio(j+2).folder '\' list_audio(j+2).name]);
    elseif i == 4 % snare
        j = max_index(i);
        list_audio = dir([list_instrument(i+2).folder '\' list_instrument(i+2).name]);
        samp_opt{i} = audioread([list_audio(j+2).folder '\' list_audio(j+2).name]);
    end
    
    samp_opt{i} = movmean(abs(samp_opt{i}),n_mav); % moving average
    samp_opt{i} = samp_opt{i}/max(samp_opt{i}); % norm
end

info_sum = audioinfo('송골매_60.wav');
[music_sum,fs_sum] = audioread('송골매_60.wav');

sound_L_sum = music_sum(:,1);
sound_L_sum = sound_L_sum/max(sound_L_sum)*1; % Normalization 0 to 1 (Reference Music)
xlab_sum = 0:1/info_sum.SampleRate:info_sum.Duration;
xlab_sum = xlab_sum(1:even(numel(xlab_sum))); % Time Term

plot(xlab_sum,beats_opt(:,3), 'LineWidth', 1, 'Color', 'k');
set(gca,'FontSize',15,'FontWeight','bold')
ylabel("Xcorr [a.u.]")
xlabel("Time [s]") 

plot(xlab_sum,beats_opt(:,4), 'LineWidth', 1, 'Color', 'k');
set(gca,'FontSize',15,'FontWeight','bold')
ylabel("Xcorr [a.u.]")
xlabel("Time [s]") 

plot(xlab_sum,beats_opt(:,1), 'LineWidth', 1, 'Color', 'k'); 
set(gca,'FontSize',15,'FontWeight','bold')
ylabel("Xcorr [a.u.]")
xlabel("Time [s]") 

plot(xlab_sum,beats_opt(:,2), 'LineWidth', 1, 'Color', 'k'); 
set(gca,'FontSize',15,'FontWeight','bold')
ylabel("Xcorr [a.u.]")
xlabel("Time [s]") 

kick_motion = conv(beats_opt(:,3),samp_opt{3},'same');
snare_motion = conv(beats_opt(:,4),samp_opt{4},'same');
crash_motion = conv(beats_opt(:,1),samp_opt{1},'same');
hihat_motion = conv(beats_opt(:,2),samp_opt{2},'same');

plot(kick_motion); hold on
plot(snare_motion); hold on
plot(crash_motion); hold on
plot(hihat_motion); 

n_sampling = 441*2;

time_duration = floor(info_sum.TotalSamples / n_sampling);
kick_motion_smp = zeros(time_duration,1);snare_motion_smp = zeros(time_duration,1);
crash_motion_smp = zeros(time_duration,1);hihat_motion_smp = zeros(time_duration,1);
time_smp = zeros(time_duration,1);

for i = 1:time_duration
    kick_motion_smp(i,1) = kick_motion(i * n_sampling, 1); 
    snare_motion_smp(i,1) = snare_motion(i * n_sampling, 1); 
    crash_motion_smp(i,1) = crash_motion(i * n_sampling, 1);
    hihat_motion_smp(i,1) = hihat_motion(i * n_sampling, 1);
    
    time_smp(i,1) = i * n_sampling / info_sum.SampleRate; % Second 
end
%%
nor_kick_motion_smp = round(kick_motion_smp/max(kick_motion_smp)*125);
nor_snare_motion_smp = round(snare_motion_smp/max(snare_motion_smp)*125);
nor_crash_motion_smp = round(crash_motion_smp/max(crash_motion_smp)*125);
nor_hihat_motion_smp = round(hihat_motion_smp/max(hihat_motion_smp)*125);

samples = zeros(numel(nor_kick_motion_smp)*4,1);
for i = 1:numel(nor_kick_motion_smp)
    samples(i*4-3,1) = nor_kick_motion_smp(i,1);
    samples(i*4-2,1) = nor_snare_motion_smp(i,1);
    samples(i*4-1,1) = nor_crash_motion_smp(i,1);
    samples(i*4-0,1) = nor_hihat_motion_smp(i,1);
end

fileID = fopen('그대에게_50_leaves.txt','w'); %그대에게_16, 투팍_16
fprintf(fileID,'%d\r\n',samples);
fclose(fileID);
 subplot(2,2,1), plot(kick_motion_smp)
 subplot(2,2,2), plot(snare_motion_smp)
 subplot(2,2,3), plot(crash_motion_smp)
 subplot(2,2,4), plot(hihat_motion_smp)
