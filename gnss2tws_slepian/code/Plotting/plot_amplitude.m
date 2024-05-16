function [position,TWS]=plot_amplitude(GPS_times,GPS_positions,long_range,lati_range,regionName,boundary,time_func)
%
% Description: Plotting annual amplitudes of grided TWS time series
%
% Input:
%   GPS_times         Time list, format (8 int): yyyymmdd
%   GPS_positions     Longitude and latitude coordinates of all GNSS sites
%   long_range        Longitude range
%   lati_range        Latitude range
%   regionName        Name of study region
%   boundary          Boundary of study area
%   time_func         Temporal fucntions of GNSS data
% Output:
%   position          Grid locations
%   TWS               Grid EWH data
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

global lmax;
load(['result/REGIONS/' regionName 'grid.mat']);
load('result/TWScoef.mat');
load(['result/' regionName num2str(lmax) 'vec.mat']);
load(['result/' regionName num2str(lmax) 'val.mat']);

[X,Y]=meshgrid(long_range,lati_range);
[m,n]=size(X);
position(:,2)=reshape(Y,m*n,1);
position(:,1)=reshape(X,m*n,1);
TWS=coef2pot(TWScoef,vec,position,[],val);
TWS=TWS*time_func';

h=waitbar(0,'Calculating amplitude...');
tws(:,1)=date2yr(datevec(num2str(GPS_times),'yyyymmdd'));
for i=1:m*n
    tws(:,2)=TWS(i,:);
    TWSann1(i,1)=calc_amplitude(tws);
    waitbar(i/m*n,h);
end
close(h);
h=figure();
set(h,'color','w');
TWSann=reshape(TWSann1,m,n);
grid=TWSann.*grid_mask;

pcolor(X,Y,grid);
colormap(jet);
hold on
plot(boundary(:,1), boundary(:,2),'linewidth',.8,'color','r');
hold on
scatter(GPS_positions(:,1),GPS_positions(:,2));
caxis([0,max(TWSann1)]);
colorbar;
saveas(gcf,'result/figure/gnsstws.tiff');
% delete(gcf);

end