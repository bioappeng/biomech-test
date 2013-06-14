
% This script plots all of the single axis load curves, vert and
% fore/aft load curves, and accel (vert and fore/aft) curves.  One figure per
% track if there is a series of tracks being compared.  Each figure
% has overlapping curves representing one drop per curve.

close all

Samp_rate = 1/2000;
n = 1000;
t2 = (0: Samp_rate: (n-1)*Samp_rate)';


for j = 1:size(load,2)
    figure(j)
for i = 1:size(load{1,j},1)

    
subplot 211
grid on
hold on
plot(t2,load{1,j}(i,:)./3500,'g')
plot(t2,zload{1,j}(i,:),'b')
plot(t2,yload{1,j}(i,:),'r')
%xlim([0 0.05])
ylim([-2 5])


subplot 212
grid on
hold on

plot(t2,smooth(vert_accel{1,j}(i,:)))
plot(t2,smooth(for_accel{1,j}(i,:)),'r')
xlim([0 0.05])
ylim([-20 100])

% subplot 313
% plot(t2,atan((for_accel{1,j}(i,:))./(vert_accel{1,j}(i,:))))
% ylim([0  10.0])
% xlim([0 0.05])
% grid on
% hold on
% [for_max, for_loc] = max(for_accel{1,j}(i,:));
% [vert_max, vert_loc] = max(vert_accel{1,j}(i,:));
% 
% dynangle = atan(for_max/vert_max);
% scatter(for_loc/2000,dynangle,'o')
% scatter(vert_loc/2000, dynangle,'x')

% i
% pause
% close all

end

end

clear  n Samp_rate t2 for_max vert_max for_loc vert_loc