function [val,vec]=calc_eigen_paraments_main(integral_boundary,regionName)
%
% Description: Calculating eigenvalues and eigenvectors of D matrix, which
% would call "glmalpha.m" of the Slepian_alpha software
%
% Input:
%   integral_boundary    Extended boundary file
%   regionName           Name of study region
% Output:                
%   val                 Eigenvalues in order
%   vec                 Unitary matrix of localization coefficients
%
% Author: Zhongshan Jiang
% Date: 06/01/2023
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

h=msgbox('Calculating eigenvalues and eigenvectors, please wait!');

defval('opt',0)
global lmax;
XY=load(integral_boundary);
save(['REGIONS/' regionName '.mat'],'XY');

% Note:please ensure that the basis function is centered in the extended boundary
if XY(:,1)<180
    opt=1;
end
%%
%Regional integration and solution
ddir_vec=[regionName,num2str(lmax),'vec.mat'];
ddir_val=[regionName,num2str(lmax),'val.mat'];
if exist(ddir_vec,"file") && exist(ddir_val,"file")
    eval(['load ',ddir_vec]);
    eval(['load ',ddir_val]);
else
    if opt == 1
        %     Klmlmp=kernelcp(lmax,regionName);
        %     % Klmlmp=kernelc(lmax,regionName);
        %     [G,V]=eig(Klmlmp);V=diag(V);[V,vi]=sort(V,'descend');G=G(:,vi);
        %     [~,~,~,~,~,~,ems,els,R1,R2]=addmon(lmax);G=G(R1,:);
        %     [EM,EL]=addmout(lmax);mm=((-1).^EM);
        %     vec=G.*repmat(mm,1,length(G(1,:)));
        %     val=V;
        [G,V,~,EM]=glmalpha(regionName,lmax);
        mm=((-1).^EM);
        vec=G.*repmat(mm,1,length(G(1,:)));
        val=V;
    else
        %     Klmlmp=kernelcp(lmax,regionName);
        %     % Klmlmp=kernelc(lmax,regionName);
        %     [G,V]=eig(Klmlmp);V=diag(V);[V,vi]=sort(V,'descend');G=G(:,vi);
        %     vec=G;
        %     val=V;
        [G,V,~,~]=glmalpha(regionName,lmax);
        vec=G;
        val=V;
    end
    save (ddir_vec,'vec');
    save (ddir_val,'val');
end
fprintf('Finishing computation of D matrix!\n');
close(h);
