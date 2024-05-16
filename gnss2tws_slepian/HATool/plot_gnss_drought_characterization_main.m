%% plot figures about characterization of hydrological extremes
clc;clear;
gnss_ewh=load('gnss_ewh_area_series.txt');

time_gnss=date2yr(datevec(num2str(gnss_ewh(:,1)),'yyyymmdd'));
time_month=gnss_ewh(:,1);

basin={'Upper Colorado' 'Lower Colorado' 'Great Basin' 'Pacific Northwest' 'California'};
num=size(basin,2);

figure('color',[1 1 1])
set(gcf,'Position',[100 100 1000 600]);
[ha, pos] = tight_subplot(5,2,[.055 .056],[.08 .03],[.1 .1]);
for i=1:size(basin,2)
    [gnss_ewh_smooth,gnss_season,gnss_diff,gnss_defi(:,i),gnss_surp,gnss_dsi(:,i)] = cal_gnss_dsi(gnss_ewh(:,1),gnss_ewh(:,i+1)); % characterization results of hydrological extremes
    axes(ha(2*i-1));
    h1=plot(time_gnss,gnss_ewh_smooth,'LineWidth',1.5,'Color','k');
    yyaxis left
    hold on
    h2=plot(time_gnss,gnss_season,'--b','LineWidth',1.5);
    ylabel('EWH (mm)');
    set(gca,'ycolor','k');
    set(gca,'ylim',[-250 250],'ytick',[-250:250:250]);
    
    yyaxis right
    h3=area(time_gnss,gnss_defi(:,i),'facecolor',[217/255 83/255 25/255]);
    set(gca,'ycolor','r');
    grid on
    ylabel('VCD (mm)');
    set(gca,'ycolor',[217/255 83/255 25/255]);
    set(gca,'xlim',[2006 2023],'ylim',[-250 0],'ytick',[-250:250:0]);
    set(gca,'linewidth',1.5);
    title(['(' char(96+i) ') ' char(basin{i})]);
    if i==1
        hh=legend([h1 h2 h3],'EWH','EWH-Catalogue','EWH-deficit','location' ,'south');
        set(hh,'Orientation','horizon','Box','off')
    end
    
    axes(ha(2*i));
    h4=plot(time_gnss,gnss_dsi(:,i),'LineWidth',1.5,'Color',[22/255 160/255 93/255],'linestyle','-','Marker','none');

    ylabel('DSI');
    set(gca,'xlim',[2006 2023],'ylim',[-2.5 2.5],'ytick',[-2.5 0 2.5]);
    set(gca,'yaxislocation','right');
    % set(gca,'ycolor',[22/255 160/255 93/255]);
    
    set(gca,'linewidth',1.5);
    
    if i==1
        nnnn=legend(h4,'GNSS-DSI','location' ,'north');
        set(nnnn,'Orientation','horizon','Box','off')
    end
    title(['(' char(101+i) ') ' char(basin{i})]);
end

% export_fig('Figure7.pdf');
% delete(gcf);