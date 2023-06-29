function [coeff,score,all_explained,each_explained,data_recon]=gnss_pca(data_raw,num_pc)
% 
% Description: Performing PCA decomposition using the 'als' algorithm for missing data
% 
% Input:
%   data_raw         Raw observation data
%   num_pc           Number of selected PCs, note that it may cause overfitting due to too much PCs
% Output:
%   coeff            Spatial functions
%   score            Temporal fucntions
%   all_explained    Variance contribution of selected PCs to raw GNSS data
%   each_explained   Variance contribution of each PC to the filtered data
%   data_recon       Reconstructed GNSS data
% 
% Author: Zhongshan Jiang
% Date: 06/01/2023 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn

%% Implementing PCA decomposition, algorithm 'als'
h=msgbox('Implement PCA decomposition, algorithm: ''als'', please wait!');
opt = statset('pca'); opt.MaxIter = 1000; opt.Display = 'iter';
[coeff,score,latent,tsquared,each_explained,mu] = pca(data_raw,'algorithm','als','Centered','off','NumComponents',num_pc,'Options',opt);
data_recon = score*coeff' + repmat(mu,size(data_raw,1),1);

%% Calcuating variance contribution of selected PCs to raw GNSS data
no_site=size(data_raw,2);
var_r=zeros(no_site,1);
Var_d=zeros(no_site,1);
for i=1:1:no_site
    ok=~isnan(data_raw(:,i));
    d=data_raw(ok,i);
    dhat=data_recon(ok,i);
    r=d-dhat;
    var_r(i,1)=r'*r;
    Var_d(i,1)=d'*d;
end
all_explained=100*(1-sum(var_r)/sum(Var_d));
fprintf('variance explained PCA = %f%%\n', all_explained);
close(h);

