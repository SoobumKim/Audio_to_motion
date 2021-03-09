clc
close all
clear
%kick 1865:1888:1927

range_min = 1865;
intv2mid = 1888-1865;
range_max = 1927;
Marker_1 = cell2mat(struct2cell(load('kick_point1.mat'))); Marker_1 = Marker_1(range_min:range_max,:)*1000;
Marker_2 = cell2mat(struct2cell(load('kick_point2.mat'))); Marker_2 = Marker_2(range_min:range_max,:)*1000;
Marker_3 = cell2mat(struct2cell(load('kick_point3.mat'))); Marker_3 = Marker_3(range_min:range_max,:)*1000;
Marker_4 = cell2mat(struct2cell(load('kick_point4.mat'))); Marker_4 = Marker_4(range_min:range_max,:)*1000;
Marker_5 = cell2mat(struct2cell(load('kick_point5.mat'))); Marker_5 = Marker_5(range_min:range_max,:)*1000;
Marker_6 = cell2mat(struct2cell(load('kick_point6.mat'))); Marker_6 = Marker_6(range_min:range_max,:)*1000;
Marker_7 = cell2mat(struct2cell(load('kick_point7.mat'))); Marker_7 = Marker_7(range_min:range_max,:)*1000;
Marker_8 = cell2mat(struct2cell(load('kick_point8.mat'))); Marker_8 = Marker_8(range_min:range_max,:)*1000;
i = 0.9;

marker = [Marker_1; Marker_2; Marker_3; Marker_4; Marker_5; Marker_6; Marker_7; Marker_8];
marker_max = max(marker);
marker_min = min(marker);

mag = zeros(length(Marker_1),1);

markers_x = [Marker_1(:,1), Marker_3(:,1), Marker_5(:,1), Marker_6(:,1), Marker_4(:,1), Marker_2(:,1)];
markers_y = [Marker_1(:,2), Marker_3(:,2), Marker_5(:,2), Marker_6(:,2), Marker_4(:,2), Marker_2(:,2)];
markers_z = [Marker_1(:,3), Marker_3(:,3), Marker_5(:,3), Marker_6(:,3), Marker_4(:,3), Marker_2(:,3)];

mid_x = median(rot90(markers_x));
mid_y = median(rot90(markers_y));
mid_z = median(rot90(markers_z));

%figure, plot3(mid_x, -mid_z, mid_y, 'k-o', 'LineWidth', 2)
%hold on
figure

mid_x = [];
mid_y = [];
mid_z = [];

v = VideoWriter('C:\Users\ADmin\Desktop\front_view_kick');

open(v);

scl = 100; %frame Á¶Àı

for k = 1:length(Marker_1)
  
     markers_x = [Marker_1(k,1), Marker_3(k,1), Marker_5(k,1), Marker_6(k,1), Marker_4(k,1), Marker_2(k,1)];
     markers_y = [Marker_1(k,2), Marker_3(k,2), Marker_5(k,2), Marker_6(k,2), Marker_4(k,2), Marker_2(k,2)];
     markers_z = [Marker_1(k,3), Marker_3(k,3), Marker_5(k,3), Marker_6(k,3), Marker_4(k,3), Marker_2(k,3)];
 
     leaf_x_rot = rot90(markers_x);
     leaf_y_rot = rot90(markers_y);
     leaf_z_rot = rot90(markers_z);
 
     mid_mar_x = median(leaf_x_rot);
     mid_mar_y = median(leaf_y_rot);
     mid_mar_z = median(leaf_z_rot);
        
     if k < intv2mid
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [1 i-0.4 i-0.4],'MarkerFaceColor',[1 i-0.4 i-0.4]); 
        hold on
     else
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [i-0.4 i-0.4 1],'MarkerFaceColor',[i-0.4 i-0.4 1]); 
        hold on
     end
     
     intv = 0.9/numel(range_min:range_max)/2; %intv = 0.9/numel(range_min:range_max);
     i = i-intv;
     
     mid_x(k,:) = mid_mar_x;
     mid_y(k,:) = mid_mar_y;
     mid_z(k,:) = mid_mar_z;

   %view(120, 10) %left view
    %view(180, 10) %front view
    %view(240, 10) %right view
    view(360, 90) %top view

    %axis([marker_min(1)-0.0005 marker_max(1)+0.0005 -marker_min(3)-0.075 -marker_max(3)+0.1 marker_min(2)-0.05 marker_max(2)+0.05]);
      
    axis equal;
    axis([120 220 -1220 -1150 110 140]) 
    xlabel("[mm]"), ylabel("[mm]"), zlabel("[mm]")
    
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);

%snare 675:725:772
range_min = 675;
intv2mid = 725-675;
range_mid = 725;
range_max = 772;
Marker_1 = cell2mat(struct2cell(load('snare_point1.mat'))); Marker_1 = Marker_1(range_min:range_max,:)*1000;
Marker_2 = cell2mat(struct2cell(load('snare_point2.mat'))); Marker_2 = Marker_2(range_min:range_max,:)*1000;
Marker_3 = cell2mat(struct2cell(load('snare_point3.mat'))); Marker_3 = Marker_3(range_min:range_max,:)*1000;
Marker_4 = cell2mat(struct2cell(load('snare_point4.mat'))); Marker_4 = Marker_4(range_min:range_max,:)*1000;
Marker_5 = cell2mat(struct2cell(load('snare_point5.mat'))); Marker_5 = Marker_5(range_min:range_max,:)*1000;
Marker_6 = cell2mat(struct2cell(load('snare_point6.mat'))); Marker_6 = Marker_6(range_min:range_max,:)*1000;
Marker_7 = cell2mat(struct2cell(load('snare_point7.mat'))); Marker_7 = Marker_7(range_min:range_max,:)*1000;
Marker_8 = cell2mat(struct2cell(load('snare_point8.mat')));  Marker_8 = Marker_8(range_min:range_max,:)*1000;
i = 0.9;


markers_x = [Marker_1(:,1), Marker_3(:,1), Marker_5(:,1), Marker_8(:,1), Marker_4(:,1), Marker_2(:,1)];
markers_y = [Marker_1(:,2), Marker_3(:,2), Marker_5(:,2), Marker_8(:,2), Marker_4(:,2), Marker_2(:,2)];
markers_z = [Marker_1(:,3), Marker_3(:,3), Marker_5(:,3), Marker_8(:,3), Marker_4(:,3), Marker_2(:,3)];

mid_x = median(rot90(markers_x));
mid_y = median(rot90(markers_y));
mid_z = median(rot90(markers_z));

% figure, plot3(mid_x, -mid_z, mid_y, 'k-o', 'LineWidth', 2)
% hold on
figure

mid_x = [];
mid_y = [];
mid_z = [];

v = VideoWriter('C:\Users\ADmin\Desktop\front_view_snare');

open(v);

scl = 10;

for k = 1:length(Marker_1)

     markers_x = [Marker_1(k,1), Marker_3(k,1), Marker_5(k,1), Marker_8(k,1), Marker_4(k,1), Marker_2(k,1)];
     markers_y = [Marker_1(k,2), Marker_3(k,2), Marker_5(k,2), Marker_8(k,2), Marker_4(k,2), Marker_2(k,2)];
     markers_z = [Marker_1(k,3), Marker_3(k,3), Marker_5(k,3), Marker_8(k,3), Marker_4(k,3), Marker_2(k,3)];
 
     leaf_x_rot = rot90(markers_x);
     leaf_y_rot = rot90(markers_y);
     leaf_z_rot = rot90(markers_z);
 
     mid_mar_x = median(leaf_x_rot);
     mid_mar_y = median(leaf_y_rot);
     mid_mar_z = median(leaf_z_rot);

     if k < intv2mid
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [1 i-0.4 i-0.4],'MarkerFaceColor',[1 i-0.4 i-0.4]); 
        hold on
     else
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [i-0.4 i-0.4 1],'MarkerFaceColor',[i-0.4 i-0.4 1]); 
        hold on
     end
     intv = 0.9/numel(range_min:range_max)/2;
     i = i-intv;
     
     mid_x(k,:) = mid_mar_x;
     mid_y(k,:) = mid_mar_y;
     mid_z(k,:) = mid_mar_z;

   %view(120, 10) %left view
    %view(180, 10) %front view
    %view(240, 10) %right view
    view(360, 90) %top view

    %axis([marker_min(1)-0.0005 marker_max(1)+0.0005 -marker_min(3)-0.065  -marker_max(3)+0.11 marker_min(2)-0.05 marker_max(2)+0.05]);

    axis equal;
    axis([120 220 -1220 -1150 110 140]) 
    xlabel("[mm]"), ylabel("[mm]"), zlabel("[mm]")
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);

%crash 756:810:859
range_min = 756;
intv2mid = 810-756;
range_max = 859;

Marker_1 = cell2mat(struct2cell(load('crash_point1.mat'))); Marker_1 = Marker_1(range_min:range_max,:)*1000;
Marker_2 = cell2mat(struct2cell(load('crash_point2.mat'))); Marker_2 = Marker_2(range_min:range_max,:)*1000;
Marker_3 = cell2mat(struct2cell(load('crash_point3.mat'))); Marker_3 = Marker_3(range_min:range_max,:)*1000;
Marker_4 = cell2mat(struct2cell(load('crash_point4.mat'))); Marker_4 = Marker_4(range_min:range_max,:)*1000;
Marker_5 = cell2mat(struct2cell(load('crash_point5.mat'))); Marker_5 = Marker_5(range_min:range_max,:)*1000;
Marker_6 = cell2mat(struct2cell(load('crash_point6.mat'))); Marker_6 = Marker_6(range_min:range_max,:)*1000;
Marker_7 = cell2mat(struct2cell(load('crash_point7.mat'))); Marker_7 = Marker_7(range_min:range_max,:)*1000;
Marker_8 = cell2mat(struct2cell(load('crash_point8.mat'))); Marker_8 = Marker_8(range_min:range_max,:)*1000;
i = 0.9;

markers_x = [Marker_1(:,1), Marker_3(:,1), Marker_5(:,1), Marker_6(:,1), Marker_4(:,1), Marker_2(:,1)];
markers_y = [Marker_1(:,2), Marker_3(:,2), Marker_5(:,2), Marker_6(:,2), Marker_4(:,2), Marker_2(:,2)];
markers_z = [Marker_1(:,3), Marker_3(:,3), Marker_5(:,3), Marker_6(:,3), Marker_4(:,3), Marker_2(:,3)];

mid_x = median(rot90(markers_x));
mid_y = median(rot90(markers_y));
mid_z = median(rot90(markers_z));

% figure, plot3(mid_x, -mid_z, mid_y, 'k-o', 'LineWidth', 2)
% hold on
figure

mid_x = [];
mid_y = [];
mid_z = [];

v = VideoWriter('C:\Users\ADmin\Desktop\front_view_crash');

open(v);

scl = 10;

for k = 1:length(Marker_1)
     
     markers_x = [Marker_1(k,1), Marker_3(k,1), Marker_5(k,1), Marker_6(k,1), Marker_4(k,1), Marker_2(k,1)];
     markers_y = [Marker_1(k,2), Marker_3(k,2), Marker_5(k,2), Marker_6(k,2), Marker_4(k,2), Marker_2(k,2)];
     markers_z = [Marker_1(k,3), Marker_3(k,3), Marker_5(k,3), Marker_6(k,3), Marker_4(k,3), Marker_2(k,3)];
 
     leaf_x_rot = rot90(markers_x);
     leaf_y_rot = rot90(markers_y);
     leaf_z_rot = rot90(markers_z);
 
     mid_mar_x = median(leaf_x_rot);
     mid_mar_y = median(leaf_y_rot);
     mid_mar_z = median(leaf_z_rot);

     if k < intv2mid
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [1 i-0.4 i-0.4],'MarkerFaceColor',[1 i-0.4 i-0.4]); 
        hold on
     else
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [i-0.4 i-0.4 1],'MarkerFaceColor',[i-0.4 i-0.4 1]); 
        hold on
     end
     intv = 0.9/numel(range_min:range_max)/2;
     i = i-intv;
     
     mid_x(k,:) = mid_mar_x;
     mid_y(k,:) = mid_mar_y;
     mid_z(k,:) = mid_mar_z;

   %view(120, 10) %left view
    %view(180, 10) %front view
    %view(240, 10) %right view
    view(360, 90) %top view
    
    %axis([marker_min(1)-0.0005 marker_max(1)+0.0005 -marker_min(3)-0.064  -marker_max(3)+0.111 marker_min(2)-0.05 marker_max(2)+0.05]);
    axis equal;
    axis([120 220 -1220 -1150 110 140]) 
    xlabel("[mm]"), ylabel("[mm]"), zlabel("[mm]")
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);




%hihat 1895:1966:2027
range_min = 1895;
intv2mid = 1966-1895;
range_max = 2027;
Marker_1 = cell2mat(struct2cell(load('hihat_point1.mat'))); Marker_1 = Marker_1(range_min:range_max,:)*1000;
Marker_2 = cell2mat(struct2cell(load('hihat_point2.mat'))); Marker_2 = Marker_2(range_min:range_max,:)*1000;
Marker_3 = cell2mat(struct2cell(load('hihat_point3.mat'))); Marker_3 = Marker_3(range_min:range_max,:)*1000;
Marker_4 = cell2mat(struct2cell(load('hihat_point4.mat'))); Marker_4 = Marker_4(range_min:range_max,:)*1000;
Marker_5 = cell2mat(struct2cell(load('hihat_point5.mat'))); Marker_5 = Marker_5(range_min:range_max,:)*1000;
Marker_6 = cell2mat(struct2cell(load('hihat_point6.mat'))); Marker_6 = Marker_6(range_min:range_max,:)*1000;
Marker_7 = cell2mat(struct2cell(load('hihat_point7.mat'))); Marker_7 = Marker_7(range_min:range_max,:)*1000;
Marker_8 = cell2mat(struct2cell(load('hihat_point8.mat'))); Marker_8 = Marker_8(range_min:range_max,:)*1000;
i=0.9;

marker = [Marker_1; Marker_2; Marker_3; Marker_4; Marker_5; Marker_6; Marker_7; Marker_8];
marker_max = max(marker);
marker_min = min(marker);

mag = zeros(length(Marker_1),1);


markers_x = [Marker_1(:,1), Marker_3(:,1), Marker_5(:,1), Marker_6(:,1), Marker_4(:,1), Marker_2(:,1)];
markers_y = [Marker_1(:,2), Marker_3(:,2), Marker_5(:,2), Marker_6(:,2), Marker_4(:,2), Marker_2(:,2)];
markers_z = [Marker_1(:,3), Marker_3(:,3), Marker_5(:,3), Marker_6(:,3), Marker_4(:,3), Marker_2(:,3)];

mid_x = median(rot90(markers_x));
mid_y = median(rot90(markers_y));
mid_z = median(rot90(markers_z));

% figure, plot3(mid_x, -mid_z, mid_y, 'k-o', 'LineWidth', 2)
% hold on
figure

mid_x = [];
mid_y = [];
mid_z = [];

v = VideoWriter('C:\Users\ADmin\Desktop\front_view_hihat');

open(v);

scl = 10;

for k = 1:length(Marker_1)

     markers_x = [Marker_1(k,1), Marker_3(k,1), Marker_5(k,1), Marker_6(k,1), Marker_4(k,1), Marker_2(k,1)];
     markers_y = [Marker_1(k,2), Marker_3(k,2), Marker_5(k,2), Marker_6(k,2), Marker_4(k,2), Marker_2(k,2)];
     markers_z = [Marker_1(k,3), Marker_3(k,3), Marker_5(k,3), Marker_6(k,3), Marker_4(k,3), Marker_2(k,3)];
 
     leaf_x_rot = rot90(markers_x);
     leaf_y_rot = rot90(markers_y);
     leaf_z_rot = rot90(markers_z);
 
     mid_mar_x = median(leaf_x_rot);
     mid_mar_y = median(leaf_y_rot);
     mid_mar_z = median(leaf_z_rot);

     if k < intv2mid
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [1 i-0.4 i-0.4],'MarkerFaceColor',[1 i-0.4 i-0.4]); 
        hold on
     else
        plot3(mid_mar_x, -mid_mar_z, mid_mar_y, 'o','Color', [i-0.4 i-0.4 1],'MarkerFaceColor',[i-0.4 i-0.4 1]); 
        hold on
     end
     intv = 0.9/numel(range_min:range_max)/2;
     i = i-intv;
     
     mid_x(k,:) = mid_mar_x;
     mid_y(k,:) = mid_mar_y;
     mid_z(k,:) = mid_mar_z;
     
    %view(120, 10) %left view
    %view(180, 10) %front view
    %view(240, 10) %right view
    view(360, 90) %top view
    
    %axis([marker_min(1)-0.0005 marker_max(1)+0.0005 -marker_min(3)-0.08  -marker_max(3)+0.128 marker_min(2)-0.05 marker_max(2)+0.05]);
    axis equal;
    axis([120 220 -1220 -1150 110 140]) 
    xlabel("[mm]"), ylabel("[mm]"), zlabel("[mm]")
    
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);



