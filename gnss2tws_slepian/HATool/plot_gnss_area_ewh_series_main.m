%% plot figures about basin-averaged EWH time series
clear;clc;
load('../result/gps_ewh.mat');

[time_mon,data_mon]=month_aver(TWS_grid',GNSS_times); % Converting daily sampling to monthly sampling
time_gnss=date2yr(datevec(num2str(time_mon),'yyyymmdd'));

figure('color',[1 1 1])
set(gcf,'Position',[100 100 600 600]);
basin_name={'A','B','C','D','E'};
for i=1:length(basin_name) % Calculating the area-averaged time series for each basin
    bour_file=['basin boundary/' char(basin_name{i}) '.dat'];
    gnss_average_ewh(:,i)=cal_basin_average_time_series(POS_grid,data_mon',bour_file);
    subplot(length(basin_name),1,i)
    plot(time_gnss,gnss_average_ewh(:,i),'LineWidth',1.5,'Color','k');
    ylabel('EWH (mm)');
    title(['(' char(96+i) ') Basin ' char(basin_name{i})]);
    set(gca,'ycolor','k');
    set(gca,'xlim',[2006 2023],'ylim',[-250 250],'ytick',[-250:250:250]);
end

gnss_ewh_info = [time_mon gnss_average_ewh];
save gnss_ewh_area_series.txt gnss_ewh_info -ascii;

