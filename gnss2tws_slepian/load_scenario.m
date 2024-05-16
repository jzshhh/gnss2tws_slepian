%% Constant variable
global Aq  Gq gq pw lmax;
Aq=6371000; Gq=6.67259*10^-11;gq=9.8242;pw =1000; lmax=80; %lmax=60；lmax=100;

%% GNSS data
timespan = [20060101 20221231];
udir='data/gps';form='*.up';site_info_file='data/sites.all'; 

%% Study area
regionName = 'USA';
integral_edge_file= [pwd '/data/USA_border_L2.txt']; % expanded boundary file
long_range = -130:0.5:-100; lati_range =25:0.5:54; % It shold cover the whole study area

%% PCA Decomposition
num_pc=6;

%% Inversion
cutoff = 0.1;
Gauss_radius=150;

%% Plotting
boundary_file=[pwd '/data/USA_border_L1.txt'];  % real boundary file
[long_bou, lat_bou]=textread(boundary_file,'%f %f','commentstyle','shell');
boundary=[long_bou lat_bou];
basis_order=1:42; % Drawing Slepian basis function according to orders 
% basis_order=[]; 

%%
Initialization(long_range,lati_range,integral_edge_file,regionName);

