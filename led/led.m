clc
%close all
clear 

fileID = fopen('SOS_16_led.txt');
cell = textscan(fileID,'%s');
arrays = cell{1};
arrays = arrays{1};

ch_num = 7;
len = (numel(arrays)/ch_num);
ch = double.empty;

for i = 1:ch_num
    ch(i,:) = arrays((i-1)*len+1: i*len)-48;
end

index = double.empty();
ch_array = zeros(7,690);
num = 1;

for i = 1:7
    index = find(ch(i,:) == 1);
    for j = 1:len
        if find(j == index(1,:))
            ch_array(i,j) = i;
        else
            ch_array(i,j) = 0;
        end
    end
    num = num + 1;
end

ch_profile = zeros(1,len);

for j = 1:len
    ch_profile(j) = max(ch_array(:,j));
end

info_sum = audioinfo('SOS_16_harmonic.wav');
str_ch_profile = imresize(ch_profile, [1 info_sum.TotalSamples], 'nearest');

n_sampling = 441*2;

time_duration = floor(info_sum.TotalSamples / n_sampling);
data_smp = zeros(1,time_duration);
time_smp = zeros(1,time_duration);

for i = 1:time_duration
    data_smp(1,i) = str_ch_profile(1, i * n_sampling); 
    time_smp(1,i) = i * n_sampling / info_sum.SampleRate; % Second    
end

stem(time_smp, data_smp,'k','LineWidth',2);
xlim([0 2])
ylim([0 8])

fileID = fopen('SOS_16_led.txt','w');
fprintf(fileID,'%d\r\n',data_smp);
fclose(fileID);
