clc
close all
clear

Marker_1 = cell2mat(struct2cell(load('snare_point1.mat')));
Marker_2 = cell2mat(struct2cell(load('snare_point2.mat')));
Marker_3 = cell2mat(struct2cell(load('snare_point3.mat')));
Marker_4 = cell2mat(struct2cell(load('snare_point4.mat')));
Marker_5 = cell2mat(struct2cell(load('snare_point5.mat')));
Marker_6 = cell2mat(struct2cell(load('snare_point6.mat')));
Marker_7 = cell2mat(struct2cell(load('snare_point7.mat')));
Marker_8 = cell2mat(struct2cell(load('snare_point8.mat'))); 


marker = [Marker_1; Marker_2; Marker_3; Marker_4; Marker_5; Marker_6; Marker_7; Marker_8];
marker_max = max(marker);
marker_min = min(marker);

mag = zeros(length(Marker_1),1);

mid_x = [];
mid_y = [];
mid_z = [];

v = VideoWriter('C:\Users\ADmin\Desktop\front_view_mid');

open(v);

scl = 10;

for k = 1:length(Marker_1)

     leaf_x = [Marker_1(k,1), Marker_3(k,1), Marker_5(k,1), Marker_8(k,1), Marker_4(k,1), Marker_2(k,1), Marker_1(k,1)];   
     leaf_y = [Marker_1(k,2), Marker_3(k,2), Marker_5(k,2), Marker_8(k,2), Marker_4(k,2), Marker_2(k,2), Marker_1(k,2)];   
     leaf_z = [Marker_1(k,3), Marker_3(k,3), Marker_5(k,3), Marker_8(k,3), Marker_4(k,3), Marker_2(k,3), Marker_1(k,3)];  
     
     plot3(leaf_x,-leaf_z, leaf_y,'-o','Color', 'g'); hold on;   
     plot3(leaf_x,-leaf_z, leaf_y,'o','Color', 'k'); hold on; 
     
     branch_x = [Marker_6(k,1), Marker_7(k,1), Marker_8(k,1)];   
     branch_y = [Marker_6(k,2), Marker_7(k,2), Marker_8(k,2)];   
     branch_z = [Marker_6(k,3), Marker_7(k,3), Marker_8(k,3)];   
     plot3(branch_x, -branch_z, branch_y,'-o','Color', 'g'); hold on;  
     plot3(branch_x, -branch_z, branch_y,'o','Color', 'k'); hold on;

     ref_x = [Marker_1(k,1), Marker_8(k,1)];
     ref_y = [Marker_1(k,2), Marker_8(k,2)];
     ref_z = [Marker_1(k,3), Marker_8(k,3)];
     plot3(ref_x, -ref_z, ref_y,'-o','Color', 'g'); hold on;  
     plot3(ref_x, -ref_z, ref_y,'o','Color', 'k'); hold on;
     
     markers_x = [Marker_1(k,1), Marker_3(k,1), Marker_5(k,1), Marker_8(k,1), Marker_4(k,1), Marker_2(k,1)];
     markers_y = [Marker_1(k,2), Marker_3(k,2), Marker_5(k,2), Marker_8(k,2), Marker_4(k,2), Marker_2(k,2)];
     markers_z = [Marker_1(k,3), Marker_3(k,3), Marker_5(k,3), Marker_8(k,3), Marker_4(k,3), Marker_2(k,3)];
 
     leaf_x_rot = rot90(markers_x);
     leaf_y_rot = rot90(markers_y);
     leaf_z_rot = rot90(markers_z);
 
     mid_mar_x = median(leaf_x_rot);
     mid_mar_y = median(leaf_y_rot);
     mid_mar_z = median(leaf_z_rot);

     plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', 'r'); hold off;
     
     mid_x(k,:) = mid_mar_x;
     mid_y(k,:) = mid_mar_y;
     mid_z(k,:) = mid_mar_z;
     

   %view(100, 100)
   %view(90, 30)
   %view(120, 10) %left view
    view(180, 10) %front view
    %view(240, 10) %right view
    %view(360, 90) %top view
    %view(250, 180)
    
   %axis([0 0.5 -0.5 0.5 -1 2]);
    %axis([-0.5 0.5 1.4 1.8 -0.5 0.5]);
    axis([marker_min(1)-0.3 marker_max(1)+0.3 -marker_min(3)-0.3 -marker_max(3)+0.3 marker_min(2)-0.3 marker_max(2)+0.3]);
    
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);

% MV_motion = movmean(mag,30);
% plot(MV_motion)
% f = gradient(mag);
% plot(f)
%mid_x = mid_x - mid_x(1); mid_y = mid_y - mid_y(1); mid_z = mid_z - mid_z(1);

for i = 1:numel(mid_x)-1
    mag(i,:) = sqrt((mid_x(i+1)-mid_x(1)).^2 + (mid_y(i+1)-mid_y(1)).^2 + (mid_z(i+1)-mid_z(1)).^2);
end
mag = [0; mag];
mag_scal = mag*100;

T = readtable("G:\09.16 ½ÇÇè\snare.csv");
duration = table2array(T(end,3));

mag_time = 0:duration/numel(mag):duration;
mag_time = mag_time(1:end-1);
mag_time = reshape(mag_time ,length(mag_time),1);

plot(mag_time,mag_scal, 'LineWidth', 1, 'Color', 'k')

set(gca,'FontSize',13,'FontWeight','bold')
xlabel('Time [s]')
ylabel('Position movement [cm]')

xlim([3.831 mag_time(end)])

%%
info_sum = audioinfo('F:\2020\KIST\2. code\Matlab\sound\original sound\SOS_16.wav');
[music_sum,fs_sum] = audioread('F:\2020\KIST\2. code\Matlab\sound\original sound\SOS_16.wav');
xlab_sum = 0:1/info_sum.SampleRate:info_sum.Duration;
xlab_sum = xlab_sum(1:even(numel(xlab_sum))); % Time Term

f = gradient(mag);
plot(movmean(f,100))

subplot(411), plot(xlab_sum,con_array_sound, 'LineWidth', 1, 'Color', 'k')
set(gca,'FontSize',10,'FontWeight','bold')
ylabel("Amplitude")
xlabel("Time [s]") 

nor_motion = round(data_smp/max(data_smp)*125);

subplot(412), plot(time_smp,nor_motion, 'LineWidth', 1, 'Color', 'k')
set(gca,'FontSize',10,'FontWeight','bold')
xlabel('Time [s]')
ylabel('Amplitude')

mag_time = 0:15.575/1870:15.575;
mag_time = mag_time(1:end-1);
mag_time = reshape(mag_time ,length(mag_time),1);

subplot(413), plot(mag_time,mag, 'LineWidth', 1, 'Color', 'k')
set(gca,'FontSize',10,'FontWeight','bold')
xlabel('Time [s]')
ylabel('Magnitude')

subplot(414), plot(mag_time,f, 'LineWidth', 1, 'Color', 'k')
set(gca,'FontSize',10,'FontWeight','bold')
xlabel('Time [s]')
ylabel('Velocity')

