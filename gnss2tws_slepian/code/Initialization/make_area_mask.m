function make_area_mask(long_range,lati_range,integral_edge_file,regionName)
%
% Description: Generating a mask file in 'result/REGIONS/'
%
% Input:
%   long_range         Longitude range
%   lati_range         Latitude range
%   integral_edge_file Boundary of study area
%   regionName         Region name
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

edge = load(integral_edge_file);
[lon, lat]=meshgrid(long_range,lati_range);

grid_mask=ones(size(lon));

in = inpolygon(lon,lat,edge(:,1),edge(:,2));
grid_mask(~in)=NaN;

save(['result/REGIONS/' regionName 'grid' '.mat'],'grid_mask');
end
