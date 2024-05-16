function average_ewh=cal_basin_average_time_series(area_grids,ewh_grids,basin_file)
% 
% Description: calculating  basin-averaged EWH time series using a latitude-weighted scheme
% 
% Input:
%   area_grids       latitude and longitude of grids
%   ewh_grids        EWH values at all grids
%   basin_file       File name of watershed boundary 
% Output:
%   average_ewh      Basin-averaged EWH time series
% 
% Author: Zhongshan Jiang
% Date: 06/10/2023 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn


bour=load(basin_file);
index=inpolygon(area_grids(:,1),area_grids(:,2),bour(:,1),bour(:,2));

ok=find(index==1);
lonlat=area_grids(ok,:);ewh=ewh_grids(ok,:);

nn=0;
for i=1:length(ok)
    if ~isnan(ewh(i))
        nn=nn+1;
        temp(nn)=cosd(lonlat(i,2));
        ewh0(nn,:)=ewh(i,:).*temp(nn);
    end
end

average_ewh=sum(ewh0,1)./sum(temp);