clear;clc;

%% Load original boundary data
sta_info=importdata('sites.all');
load coastlines.mat

%% Plot original boundary
figure('color',[1 1 1])
plot(coastlon,coastlat);
hold on
scatter(sta_info.data(:,1),sta_info.data(:,2),20,'r','filled');
set(gca,'xlim',[-130 -65],'ylim',[25 53]);

%% Manually extract boundaries
num=0;
while 1
    if strcmpi(get(gcf,'CurrentCharacter'),'q') % Finish when enter 'q'
        break;
    end
    num=num+1;
    aa(num,:) = ginput(1);
    hold on
    plot(aa(num,1),aa(num,2),'o-')
    hold on
end
aa=[aa; aa(1,:)];

save USA_border_L1.txt aa -ascii % save raw boundary data
