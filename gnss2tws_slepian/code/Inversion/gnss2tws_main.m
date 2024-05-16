function gnss2tws_main(GPS_positions,GPS_data,val,vec,cutoff,Gauss_radius,GPS_times,GPS_sites,time_func)
%
% Description: Main function of the inversion model
%
% Input:
%   GPS_positions  Longitude and latitude coordinates of all sites
%   GPS_data       Spatial functions of all PCs
%   val            Eigenvalue
%   vec            Eigenvectors
%   cutoff         Cutoff of eigenvalues  
%   Gauss_radius   Gaussian filter radius
%   GPS_times      Time list, format (8 int): yyyymmdd
%   GPS_sites      Site list, 4 char
%   time_func      Temporal fucntions of selected PCs
% 
% Author: Zhongshan Jiang
% Date: 06/02/2023
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

h=msgbox('Starting inversion modeling, please wait!');

global Aq lmax;
position=GPS_positions;
clat=90-position(:,2);
lon=position(:,1);

J=find(val>=cutoff, 1, 'last' );
ll=1:J;
G=my_galpha(clat,lon,vec,ll,lmax)*Aq;

%%
ddir1='result\Ucoef.mat'; % save displacement Slepian coefficients
ddir2='result\TWScoef.mat';% save EWH Slepian coefficient
ddir3='result\TWS_site.mat';% save EWH at gnss sites
ddir4='result\Udata.mat';% Save VCD data

%% Conversion from spatial-domain to spectral-domain displacement data
Data=GPS_data;
coef=datafit(G,Data);
coef1=coef*time_func';
save(ddir1,'coef1','GPS_times');
fprintf('Ucoef Compute Finish!\n');

%% Conversion from spectral-domain to spatial-domain displacement data
Upre=coef2pot(coef,vec,position,[],[]);
Upre=time_func*Upre';
Data=time_func*Data';
save(ddir4,'Upre','Data','GPS_times','GPS_positions','GPS_sites');
fprintf('Upre Compute Finish!\n');

%%  Conversion from spectral-domain displacement data to spectral-domain EWH estimates
TWScoef=VCDcoef2TWScoef(coef,vec);
TWScoef=filter_slep_coff_gauss(TWScoef,vec,Gauss_radius);
save(ddir2,'TWScoef','GPS_times');
fprintf('TWScoef Compute Finish!\n');

%% Conversion from spectral-domain to spatial-domain EWH estimates
TWS=coef2pot(TWScoef,vec,position,[],val);
TWS=time_func*TWS';
save(ddir3,'TWS','GPS_times');
fprintf('TWS Compute Finish!\n');
close(h);
