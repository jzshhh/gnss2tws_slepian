function Initialization(long_range,lati_range,integral_edge_file,regionName)
% 
% Description: Initializating related directories and files
% 
% Input:
%   long_range          Longitude range
%   lati_range          Latitude range
%   integral_edge_file  Boundary of extended study area
%   regionName          Region name
% 
% Author: Zhongshan Jiang
% Date: 06/01/2023 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn

h=waitbar(0,'Initialization...');
if ~exist('result','dir')
    mkdir('result');
end
if ~exist('result/REGIONS','dir')
    mkdir('result/REGIONS');
end
addpath('result/REGIONS');
if ~exist('result/KERNELC','dir')
    mkdir('result/KERNELC');
end

if ~exist('result/EARTHMODELS','dir')
    mkdir('result/EARTHMODELS');
end

if ~exist('result/EARTHMODELS/CONSTANTS','dir')
    mkdir('result/EARTHMODELS/CONSTANTS');
end
copyfile('code\slepian_alpha\EARTHMODELS\CONSTANTS\Earth.mat','result/EARTHMODELS/CONSTANTS');

if ~exist('result/GLMALPHA','dir')
    mkdir('result/GLMALPHA');
end
if ~exist('result/COASTS','dir')
    mkdir('result/COASTS');
end
if ~exist('result/figure','dir')
    mkdir('result/figure');
end

waitbar(0.50,h);
%% Generating a *.m file ("regionName".m) in result/REGIONS/
fid = fopen(['result/REGIONS/' regionName '.m'],'wt');
fprintf(fid,'function varargout=%s(res,buf)\r',regionName);
fprintf(fid,'defval(''res'',0);\r');
fprintf(fid,'defval(''buf'',0);\r');
fprintf(fid,'regn=''%s'';\r',regionName);
fprintf(fid,'xunt=[];\r');

fprintf(fid,'XY=load(fullfile(getenv(''IFILES''),''%s''));\r',regionName);
fprintf(fid,'XY=XY.XY;\r');
fprintf(fid,'XY=regselect(regn,XY(:,1),XY(:,2),xunt,res,buf);\r');

fprintf(fid,'if nargout==0\r');
fprintf(fid,'plot(XY(:,1),XY(:,2),''k-''); axis image; grid on\r');
fprintf(fid,'end\r');

fprintf(fid,'varns={XY};\r');
fprintf(fid,'varargout=varns(1:nargout);\r');
fclose(fid);

make_area_mask(long_range,lati_range,integral_edge_file,regionName);
waitbar(1.00,h);
close(h);