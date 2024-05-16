function poten = coef2pot(coef,vec,position,data,val)
%
% Description: Converting Slepian coefficients to a spatial field

% Input:
%   coef         Slepian coefficients
%   vec          Unitary matrix of localization coefficients
%   position     Position of geographical grid 
%   data         GPS data
%   val          Eigenvalues in order
% Output:
%   poten        Spatial field
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

lmax=sqrt(length(vec))-1;
J=length(coef(:,1));
R=6371000;
[m,n]=size(data);
clat=90-position(:,2);
lon=position(:,1);
ll=1:J;
if length(clat)>300
    G=[];N=30;
    nn=floor(length(clat)/N);
    rest=length(clat)-nn*N;
    for i=1:N
        G=[G;my_galpha(clat((i-1)*nn+1:i*nn),lon((i-1)*nn+1:i*nn),vec,ll,lmax)];
    end
    if rest~=0
        G=[G;my_galpha(clat(nn*N+1:nn*N+rest),lon(nn*N+1:nn*N+rest),vec,ll,lmax)];
    end
else
    G=my_galpha(clat,lon,vec,ll,lmax);
end
if isempty(val)
    poten=G*coef*R;
else
    coef=coef.*repmat(val(1:J),1,length(coef(1,:)));
    poten=G*coef*R;
end

if ~isempty(data)
    for i=1:m
        figure(i);
        plot(1:n,data(i,:));
        hold on;
        plot(1:n,poten(i,:),'Color','r');
        legend('data','pot');
    end
else
    for i=1:m
        figure(i);
        plot(1:n,poten(i,:));
    end
end