clc
close all
clear

Marker_1 = cell2mat(struct2cell(load('sin_wav_8_T_L.mat')));
Marker_2 = cell2mat(struct2cell(load('sin_wav_8_T_R.mat')));
Marker_3 = cell2mat(struct2cell(load('sin_wav_8_B_L.mat')));
Marker_4 = cell2mat(struct2cell(load('sin_wav_8_B_R.mat')));

Marker_1_2 = (Marker_2 + Marker_1)./2;
Marker_3_4 = (Marker_3 + Marker_4)./2;

marker = [Marker_1; Marker_2; Marker_3; Marker_4];
marker_max = max(marker);
marker_min = min(marker);


len_x_ro = Marker_1(:,1) - Marker_2(:,1);
len_y_ro = -(Marker_1(:,3) - Marker_2(:,3));

angle_ro = atand(len_y_ro./len_x_ro);

time_duration = 0:0.0083333:0.0083333*(length(Marker_1)-1);

len_x_re = Marker_1_2(:,1) - Marker_3_4(:,1);
len_y_re = -(Marker_1_2(:,3) - Marker_3_4(:,3));

angle_re = atand(len_y_re./len_x_re);
%angle_re = atan2d(len_x_re,len_y_re);
for i= 1:numel(angle_re)
    if angle_re(i) < 0
        angle_re(i) = angle_re(i) + 180;
    end
end

len_x_b = Marker_3(:,1) - Marker_4(:,1);
len_y_b = -(Marker_3(:,3) - Marker_4(:,3));

angle_b = atand(len_y_b./len_x_b);

diff = angle_b(1) - angle_ro(1);

figure,plot(time_duration,angle_b, 'r','LineWidth',2)
hold on

plot(time_duration,angle_ro+diff, 'g','LineWidth',2)
xlabel("Time [s]",'fontweight','bold','fontsize',13)
ylabel("Angle [degree]",'fontweight','bold','fontsize',13)
xlim([0 time_duration(end)])
ylim([-20 135])
hold on

plot(time_duration,angle_re-70, 'b','LineWidth',2)
hold off

legend('D','L','S')

x0=500;
y0=500;
width=800;
height=350;
set(gcf,'position',[x0,y0,width,height])

L = numel(time_duration);

fft_angle_ro = fft(angle_ro);
ro2 = abs(fft_angle_ro/L);
fft_angle_ro = ro2(1:L/2+1);
fft_angle_ro(2:end-1) = 2*fft_angle_ro(2:end-1);

fft_angle_re = fft(angle_re);
re2 = abs(fft_angle_re/L);
fft_angle_re = re2(1:L/2+1);
fft_angle_re(2:end-1) = 2*fft_angle_re(2:end-1);

fft_angle_b = fft(angle_b);
b2 = abs(fft_angle_b/L);
fft_angle_b = b2(1:L/2+1);
fft_angle_b(2:end-1) = 2*fft_angle_b(2:end-1);

fs = 120.0005; %(0:L-1)./time_duration;
f = fs.*(0:(L/2))/L;


figure,plot(f, fft_angle_b,'r','LineWidth',2)
xlabel("Frequency [Hz]",'fontweight','bold','fontsize',13)
ylabel("Magnitude [a.u.]",'fontweight','bold','fontsize',13)
xlim([0 0.7])
hold on

plot(f, fft_angle_ro,'g','LineWidth',2)
hold on

plot(f, fft_angle_re,'b','LineWidth',2)
hold off

legend('D','L','S')

x0=500;
y0=500;
width=450;
height=350;
set(gcf,'position',[x0,y0,width,height])

Marker_1 = cell2mat(struct2cell(load('sin_wav_4_T_L.mat')));
Marker_2 = cell2mat(struct2cell(load('sin_wav_4_T_R.mat')));
Marker_3 = cell2mat(struct2cell(load('sin_wav_4_B_L.mat')));
Marker_4 = cell2mat(struct2cell(load('sin_wav_4_B_R.mat')));

Marker_1_2 = (Marker_2 + Marker_1)./2;
Marker_3_4 = (Marker_3 + Marker_4)./2;

marker = [Marker_1; Marker_2; Marker_3; Marker_4];
marker_max = max(marker);
marker_min = min(marker);


len_x_ro = Marker_1(:,1) - Marker_2(:,1);
len_y_ro = -(Marker_1(:,3) - Marker_2(:,3));

angle_ro = atand(len_y_ro./len_x_ro);

time_duration = 0:0.0083333:0.0083333*(length(Marker_1)-1);

len_x_re = Marker_1_2(:,1) - Marker_3_4(:,1);
len_y_re = -(Marker_1_2(:,3) - Marker_3_4(:,3));

angle_re = atand(len_y_re./len_x_re);
%angle_re = atan2d(len_x_re,len_y_re);
for i= 1:numel(angle_re)
    if angle_re(i) < 0
        angle_re(i) = angle_re(i) + 180;
    end
end

len_x_b = Marker_3(:,1) - Marker_4(:,1);
len_y_b = -(Marker_3(:,3) - Marker_4(:,3));

angle_b = atand(len_y_b./len_x_b);

diff = angle_b(1) - angle_ro(1);

figure,plot(time_duration,angle_b, 'r','LineWidth',2)
hold on

plot(time_duration,angle_ro+diff, 'g','LineWidth',2)
xlabel("Time [s]",'fontweight','bold','fontsize',13)
ylabel("Angle [degree]",'fontweight','bold','fontsize',13)
xlim([0 time_duration(end)])
ylim([-45 115])
hold on

plot(time_duration,angle_re-100, 'b','LineWidth',2)
hold off

legend('D','L','S')

x0=500;
y0=500;
width=800;
height=350;
set(gcf,'position',[x0,y0,width,height])

L = numel(time_duration);

fft_angle_ro = fft(angle_ro);
ro2 = abs(fft_angle_ro/L);
fft_angle_ro = ro2(1:L/2+1);
fft_angle_ro(2:end-1) = 2*fft_angle_ro(2:end-1);

fft_angle_re = fft(angle_re);
re2 = abs(fft_angle_re/L);
fft_angle_re = re2(1:L/2+1);
fft_angle_re(2:end-1) = 2*fft_angle_re(2:end-1);

fft_angle_b = fft(angle_b);
b2 = abs(fft_angle_b/L);
fft_angle_b = b2(1:L/2+1);
fft_angle_b(2:end-1) = 2*fft_angle_b(2:end-1);

fs = 120.0005; %(0:L-1)./time_duration;
f = fs.*(0:(L/2))/L;


figure,plot(f, fft_angle_b,'r','LineWidth',2)
xlabel("Frequency [Hz]",'fontweight','bold','fontsize',13)
ylabel("Magnitude [a.u.]",'fontweight','bold','fontsize',13)
xlim([0 1])
hold on

plot(f, fft_angle_ro,'g','LineWidth',2)
hold on

plot(f, fft_angle_re,'b','LineWidth',2)
hold off

legend('D','L','S')

x0=500;
y0=500;
width=450;
height=350;
set(gcf,'position',[x0,y0,width,height])

Marker_1 = cell2mat(struct2cell(load('sin_wav_2_T_L.mat')));
Marker_2 = cell2mat(struct2cell(load('sin_wav_2_T_R.mat')));
Marker_3 = cell2mat(struct2cell(load('sin_wav_2_B_L.mat')));
Marker_4 = cell2mat(struct2cell(load('sin_wav_2_B_R.mat')));

Marker_1_2 = (Marker_2 + Marker_1)./2;
Marker_3_4 = (Marker_3 + Marker_4)./2;

marker = [Marker_1; Marker_2; Marker_3; Marker_4];
marker_max = max(marker);
marker_min = min(marker);


len_x_ro = Marker_1(:,1) - Marker_2(:,1);
len_y_ro = -(Marker_1(:,3) - Marker_2(:,3));

angle_ro = atand(len_y_ro./len_x_ro);

time_duration = 0:0.0083333:0.0083333*(length(Marker_1)-1);

len_x_re = Marker_1_2(:,1) - Marker_3_4(:,1);
len_y_re = -(Marker_1_2(:,3) - Marker_3_4(:,3));

angle_re = atand(len_y_re./len_x_re);
%angle_re = atan2d(len_x_re,len_y_re);
for i= 1:numel(angle_re)
    if angle_re(i) < 0
        angle_re(i) = angle_re(i) + 180;
    end
end

len_x_b = Marker_3(:,1) - Marker_4(:,1);
len_y_b = -(Marker_3(:,3) - Marker_4(:,3));

angle_b = atand(len_y_b./len_x_b);

diff = angle_b(1) - angle_ro(1);

figure,plot(time_duration,angle_b, 'r','LineWidth',2)
hold on

plot(time_duration,angle_ro+diff, 'g','LineWidth',2)
xlabel("Time [s]",'fontweight','bold','fontsize',13)
ylabel("Angle [degree]",'fontweight','bold','fontsize',13)
xlim([0 time_duration(end)])
ylim([-55 140])
hold on

plot(time_duration,angle_re-100, 'b','LineWidth',2)
hold off

legend('D','L','S')

x0=500;
y0=500;
width=800;
height=350;
set(gcf,'position',[x0,y0,width,height])

L = numel(time_duration);

fft_angle_ro = fft(angle_ro);
ro2 = abs(fft_angle_ro/L);
fft_angle_ro = ro2(1:L/2+1);
fft_angle_ro(2:end-1) = 2*fft_angle_ro(2:end-1);

fft_angle_re = fft(angle_re);
re2 = abs(fft_angle_re/L);
fft_angle_re = re2(1:L/2+1);
fft_angle_re(2:end-1) = 2*fft_angle_re(2:end-1);

fft_angle_b = fft(angle_b);
b2 = abs(fft_angle_b/L);
fft_angle_b = b2(1:L/2+1);
fft_angle_b(2:end-1) = 2*fft_angle_b(2:end-1);

fs = 120.0005; %(0:L-1)./time_duration;
f = fs.*(0:(L/2))/L;


figure,plot(f, fft_angle_b,'r','LineWidth',2)
xlabel("Frequency [Hz]",'fontweight','bold','fontsize',13)
ylabel("Magnitude [a.u.]",'fontweight','bold','fontsize',13)
xlim([0 3])
hold on

plot(f, fft_angle_ro,'g','LineWidth',2)
hold on

plot(f, fft_angle_re,'b','LineWidth',2)
hold off

legend('D','L','S')

x0=500;
y0=500;
width=450;
height=350;
set(gcf,'position',[x0,y0,width,height])


Marker_1 = cell2mat(struct2cell(load('sin_wav_1_T_L.mat')));
Marker_2 = cell2mat(struct2cell(load('sin_wav_1_T_R.mat')));
Marker_3 = cell2mat(struct2cell(load('sin_wav_1_B_L.mat')));
Marker_4 = cell2mat(struct2cell(load('sin_wav_1_B_R.mat')));

Marker_1_2 = (Marker_2 + Marker_1)./2;
Marker_3_4 = (Marker_3 + Marker_4)./2;

marker = [Marker_1; Marker_2; Marker_3; Marker_4];
marker_max = max(marker);
marker_min = min(marker);


len_x_ro = Marker_1(:,1) - Marker_2(:,1);
len_y_ro = -(Marker_1(:,3) - Marker_2(:,3));

angle_ro = atand(len_y_ro./len_x_ro);

time_duration = 0:0.0083333:0.0083333*(length(Marker_1)-1);

len_x_re = Marker_1_2(:,1) - Marker_3_4(:,1);
len_y_re = -(Marker_1_2(:,3) - Marker_3_4(:,3));

angle_re = atand(len_y_re./len_x_re);
%angle_re = atan2d(len_x_re,len_y_re);
% for i= 1:numel(angle_re)
%     if angle_re(i) < 0
%         angle_re(i) = angle_re(i) + 180;
%     end
% end

len_x_b = Marker_3(:,1) - Marker_4(:,1);
len_y_b = -(Marker_3(:,3) - Marker_4(:,3));

angle_b = atand(len_y_b./len_x_b);

diff = angle_b(1) - angle_ro(1);

figure,plot(time_duration,angle_b, 'r','LineWidth',2)
hold on

plot(time_duration,angle_ro+diff, 'g','LineWidth',2)
xlabel("Time [s]",'fontweight','bold','fontsize',13)
ylabel("Angle [degree]",'fontweight','bold','fontsize',13)
xlim([0 time_duration(end)])
ylim([-55 140])
hold on

plot(time_duration,angle_re, 'b','LineWidth',2) %100
hold off

legend('D','L','S')

x0=500;
y0=500;
width=800;
height=350;
set(gcf,'position',[x0,y0,width,height])

L = numel(time_duration);

fft_angle_ro = fft(angle_ro);
ro2 = abs(fft_angle_ro/L);
fft_angle_ro = ro2(1:L/2+1);
fft_angle_ro(2:end-1) = 2*fft_angle_ro(2:end-1);

fft_angle_re = fft(angle_re);
re2 = abs(fft_angle_re/L);
fft_angle_re = re2(1:L/2+1);
fft_angle_re(2:end-1) = 2*fft_angle_re(2:end-1);

fft_angle_b = fft(angle_b);
b2 = abs(fft_angle_b/L);
fft_angle_b = b2(1:L/2+1);
fft_angle_b(2:end-1) = 2*fft_angle_b(2:end-1);

fs = 120.0005; %(0:L-1)./time_duration;
f = fs.*(0:(L/2))/L;


figure,plot(f, fft_angle_b,'r','LineWidth',2)
xlabel("Frequency [Hz]",'fontweight','bold','fontsize',13)
ylabel("Magnitude [a.u.]",'fontweight','bold','fontsize',13)
xlim([0 3])
hold on

plot(f, fft_angle_ro,'g','LineWidth',2)
hold on

plot(f, fft_angle_re,'b','LineWidth',2)
hold off

legend('D','L','S')

x0=500;
y0=500;
width=450;
height=350;
set(gcf,'position',[x0,y0,width,height])


