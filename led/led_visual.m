clc
%close all
clear 

fileID = fopen('固赤客具荐_16_led.txt');
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

info_sum = audioinfo('固赤客具荐_16_harmonic.wav');
str_ch_profile = imresize(ch_profile, [1 info_sum.TotalSamples], 'nearest');

n_sampling = 441*2;

time_duration = floor(info_sum.TotalSamples / n_sampling);
data_smp = zeros(1,time_duration);
time_smp = zeros(1,time_duration);

for i = 1:time_duration
    data_smp(1,i) = str_ch_profile(1, i * n_sampling); 
    time_smp(1,i) = i * n_sampling / info_sum.SampleRate; % Second    
end

v = VideoWriter('C:\Users\ADmin\Desktop\test');

open(v);

scl = 10;

for k = 1:length(data_smp)
  
     leaf_x = [1, cosd(30), cosd(60), 0, -cosd(60), -cosd(30), -1, -cosd(30), -cosd(60), 0, cosd(60), cosd(30)];   
     leaf_y = [0, sind(30), sind(60), 1, sind(60), sind(30), 0, -sind(30), -sind(60), -1, -sind(60), -sind(30)];   
     leaf_z = [0,0,0,0,0,0,0,0,0,0,0,0]; 
     
     if data_smp(1,k) == 1
         color = [1 1 1];
     elseif data_smp(1,k) == 2
         color = [1/6*5 1/6*5 1/6*5];
     elseif data_smp(1,k) == 3
         color = [1/6*4 1/6*4 1/6*4];
     elseif data_smp(1,k) == 4
         color = [1/6*3 1/6*3 1/6*3];
     elseif data_smp(1,k) == 5
         color = [1/6*2 1/6*2 1/6*2];
     elseif data_smp(1,k) == 6
         color = [1/6*1 1/6*1 1/6*1];
     else
         color = [1/6*0 1/6*0 1/6*0];
     end
     
     plot3(leaf_x, leaf_y,leaf_z,'o','Color', color, 'MarkerFaceColor', color); hold off;   
    
     axis([-3 3 -3 3 -3 3]);

     frame = getframe(gcf);
     writeVideo(v,frame);
end
close(v);
