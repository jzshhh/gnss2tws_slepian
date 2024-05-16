function plot_gnss_vcd_L_U(GNSS_times,GNSS_positions,coeff,scores,boundary)
%
% Description: Plot temporal and spatial functions of each PC
%
% Input:
%   GPS_times       Time list, format (8 int): yyyymmdd
%   GNSS_positions  Coordinates of all GNSS sites
%   coeff           Spatial functions
%   scores          Temporal fucntions
%   boundary        Study area boundary
%
% Author: Zhongshan Jiang
% Date: 12/09/2022 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn

date = datevec(num2str(GNSS_times),'yyyymmdd');
year=date2yr(date);
nn=ceil(size(coeff,2)/3);
%% plot temporal fucntions
figure('color',[1 1 1])
for i=1:size(coeff,2)
    subplot(nn,3,i);
    plot(year,scores(:,i));
    title(['PC' num2str(i)]);
    set(gca,'xlim',[year(1) year(end)]);
end
saveas(gcf,'result/figure/Temporal_functions.tiff');
% delete(gcf);

nn=ceil(size(coeff,2)/3);

%% plot spatial functions
figure('color',[1 1 1])
for i=1:size(coeff,2)
    subplot(nn,3,i);
    scatter(GNSS_positions(:,1),GNSS_positions(:,2),15,coeff(:,i),'filled');
    hold on
    plot(boundary(:,1),boundary(:,2));
    colormap(jet);
    colorbar;
    % axis image 
    caxis([min(coeff(:,i)) max(coeff(:,i))]);
    grid on
    title(['PC' num2str(i)]);
end
saveas(gcf,'result/figure/Spatial_functions.tiff');
% delete(gcf);