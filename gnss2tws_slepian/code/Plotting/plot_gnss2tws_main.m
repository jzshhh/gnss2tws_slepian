function [position,TWS]=plot_gnss2tws_main(val,vec,lmax,basis_degree,regionName,long_range,lati_range,cutoff,GPS_times,GPS_positions,boundary,time_func,space_func)
%
% Description: Main function of plotting figures
%
% Input:
%   val               Eigenvalues in order 
%   vec               Eigenvectors
%   lmax              Max order
%   basis_degree      Selected order of Slepian basis functions for displaying
%   regionName        Name of study area
%   long_range        Longitude range
%   lati_range        Latitude range
%   cutoff            Cutoff value for  eigenvalues
%   GPS_times         GNSS time list, format (8 int): yyyymmdd
%   GPS_positions     Longitude and latitude coordinates of all GNSS sites
%   boundary          Boundary of study area
%   time_func         Temporal fucntions of GNSS data
%   space_func        Spatial functions of GNSS data
% Output:
%   position          Grid locations
%   TWS               Grid EWH data
% 
% Author: Zhongshan Jiang
% Date: 12/09/2022 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn

h=msgbox('Ploting some figures, please wait!');

%% Plotting temporal and spatial fucntions of GNSS data
plot_gnss_vcd_L_U(GPS_times,GPS_positions,space_func,time_func,boundary)

%% Drawing  the convergence region of the basis functions
if ~isempty(basis_degree)
    plotSlepian(val,vec,lmax,basis_degree,long_range,lati_range,regionName);
end

%% Plotting Slepian eigenvalues
plot_eig_val(val,cutoff);

%% Plotting annual amplitudes of grided TWS time series
[position,TWS]=plot_amplitude(GPS_times,GPS_positions,long_range,lati_range,regionName,boundary,time_func);
close(h);
end