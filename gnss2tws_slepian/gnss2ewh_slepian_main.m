clear; clc;
clearvars; close all;
code_dir = [pwd '\code'];
disp('Setting Paths...');
addpath(genpath(code_dir));
load_scenario;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load GNSS data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Loading GNSS Data...');
[GNSS_sites,GNSS_positions,GNSS_times,GNSS_data]=load_gnss(udir,form,site_info_file,timespan);
disp('Data Loaded.');

save result/gnss_data.mat 
load result/gnss_data.mat 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Decomposition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Decompositing');
[space_func,time_func,all_pc_explained,each_pc_explained,data_recon]=gnss_pca(GNSS_data,num_pc);
disp('Decomposition Complete');

save result/pca_decomposition.mat 
load result/pca_decomposition.mat 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculating eigenvalues and eigenvectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Calculating eigenvalues and eigenvectors');
cd('result');
[eigenvalues,eigenvectors]=calc_eigen_paraments_main(integral_edge_file,regionName);
cd('..');
disp('Eigen prarameters calculated!');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Inversion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Starting Inversion');
gnss2tws_main(GNSS_positions,space_func,eigenvalues,eigenvectors,cutoff,Gauss_radius,GNSS_times,GNSS_sites,time_func);
disp('Inversion Finished');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot/display information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Ploting some figures');
[POS_grid,TWS_grid]=plot_gnss2tws_main(eigenvalues,eigenvectors,lmax,basis_order,regionName,long_range,lati_range,cutoff,GNSS_times,GNSS_positions,boundary,time_func,space_func);

save result/gps_ewh.mat TWS_grid GNSS_times POS_grid;

% save Inversion_TWS.mat;
% load Inversion_TWS.mat;

% close all;


