function coef = filter_slep_coff_gauss(coef,vec,r)
%
% Description: Filtering slepian coefficient using Gaussian filter
%
% Input:
%   coef    Slepian coefficients
%   vec     Unitary matrix of localization coefficients
%   r       Gaussian filter radius
% Output:
%   coef    Filtered Slepian coefficient
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

J=length(coef(:,1));
Sph=vec(:,1:J)*coef; % Converting slepian coefficients to Spherical harmonic coefficients (SHs)
CS=Ulm2cs(Sph,[],[]); % Converting SHs in order of alpha to SHs with format "l m cos sin"
lmax=sqrt(length(vec))-1;
GFC=gaussian(r,lmax);
for t=1:length(CS(1,1,:))
    for i=1:length(CS(:,1,1))
        CS(i,:,t)=CS(i,:,t)*GFC(i); % Filtering the spherical harmonic coefficient
    end
end

for i=1:length(coef(1,:))
    lmcosi=cs2plm(CS(:,:,i)); 
    sph=lmcst2vec(lmcosi); % Converting SHs with format "l m cos sin" to SHs in order of alpha
    coef(:,i)=vec(:,1:J)'*sph; % Converting SHs to slepian coefficients
end
end

function GFC = gaussian(GFR, lmax)
%
% Description: Calculate Gaussian filter coefficient
%
% Input:
%   GFR       Gaussian filter radius
%   lmax      Maximal degree
% Output:                
%   GFC       Gaussian filter coefficient

GFC(1) = 1;
GFC(2) = (1+exp(-2*(log(2.)/(1-cos(GFR/6378.137)))))/...
         (1-exp(-2*(log(2.)/(1-cos(GFR/6378.137)))))-...
         1/(log(2.)/(1-cos(GFR/6378.137)));
for l=2:lmax
  GFC(l+1) = -(2*l-1)/(log(2.)/(1-cos(GFR/6378.137)))*GFC(l)+GFC(l-1);
end
end

function CS = Ulm2cs(Ulm,time,timespan)
%
% Description: Converting SHs in order of alpha to SHs with format "l m cos sin"
%
% Input:
%   Ulm         Spherical harmonic coefficients (SHs) in order of alpha
%   time        Time corresponding to the number of Ulm's columns
%   timespan    [Start_time End_time]
% Output:
%   CS          SHs with format "l m cos sin"

lmax=sqrt(length(Ulm(:,1)))-1;
if ~isempty(time) && ~isempty(timespan)
    ok=find(time>=timespan(1) & time<=timespan(2));
else
    ok=1:length(Ulm(1,:));
end
for t=1:length(ok)
    [clm,slm,dl,mo]= vec2cs(Ulm(:,ok(t)));
    C=clm;S=slm;
    Clm=zeros(lmax+1,lmax+1);Slm=zeros(lmax+1,lmax+1);
    for i=1:length(C)
        Clm(dl(i)+1,mo(i)+1)=C(i); Slm(dl(i)+1,mo(i)+1)=S(i);
    end
    Clm=zero2nan(Clm);Slm=zero2nan(Slm);
    Clm=fliplr(Clm);cs=[Clm,Slm];cs(:,lmax+2)=[];
    CS(:,:,t)=cs;
end
end

function [clm,slm,dl,dm]= vec2cs(vec)
%
% Description: Converting slepian coefficients to SHs with format "l m cos sin"
%
% Input:
%   vec             SHs in order of alpha corresponding to certain month
% Output:                
%   clm             Cos terms of SHs
%   slm             Sin terms of SHs
%   dl              Degree of SHs
%   dm              Order of SHs

lmax=sqrt(length(vec))-1;
[m,l]=addmout(lmax);
nc=1;ns=1;
for i=0:lmax
    ok=find(l(:)==i);
    ok1=find(m(ok)==0);
    l1=ok(ok1);
    for j=l1:-1:l1-i
        clm(nc,1)=vec(j);
        dl(nc,1)=i;
        nc=nc+1;
    end
    for j=l1:1:l1+i
        if j==l1
            slm(ns,1)=0;
        else
            slm(ns,1)=vec(j);
        end
       dm(ns,1)=m(j);
       ns=ns+1;
    end
end
end

function lmcosi=cs2plm(CS)
%
% Description: Processing SHs with format "l m cos sin"
%

[m,n,p]=size(CS);
L=m-1;
cs=CS(:,:,1);
Clm=cs(:,1:L+1);Clm=fliplr(Clm);
Slm=cs(:,L+2:end);s1=zeros(m,1);Slm=[s1 Slm];
z=1;
for i=1:L+1
    for j=1:i
        lmcosi(z,1)=i-1;
        lmcosi(z,2)=j-1;
        lmcosi(z,3)=Clm(i,j);
        lmcosi(z,4)=Slm(i,j);
        z=z+1;
    end
end
end

function vec = lmcst2vec(plmt)
%
% Description: Converting filtered SHs back to alpha-arranged
%

if iscell(plmt)
    N=length(plmt);
    for i=1:N
        lmcosi=plmt{i};
        maxL=max(lmcosi(:,1));
        [~,~,~,lmcosiW,~,~,~,~,~,ronmW]=addmon(maxL);
        cosi=lmcosi(:,3:4);
        vec(:,i)=cosi(ronmW);
    end
else
    lmcosi=plmt;
    maxL=max(lmcosi(:,1));
    [~,~,~,lmcosiW,~,~,~,~,~,ronmW]=addmon(maxL);
    cosi=lmcosi(:,3:4);
    vec=cosi(ronmW);
end
end

function CS = zero2nan(CS)
%
% Description: Converting 0 elements in the matrix to NaN
%

[m,n]=size(CS);
cs=CS(1,1);
for i=1:m
    for j=1:n
        if CS(i,j)==0
            CS(i,j)=NaN;
        end
    end
end
CS(1,1)=cs;
end

