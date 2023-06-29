function plotSlepian(val,vec,lmax,l,long_range,lati_range,regionName)
%
% Description: Plotting Slepian basic functions
%
% Input:
%   val          Eigenvalues in order
%   vec          Unitary matrix of localization coefficients
%   lmax         Maximal order
%   l            Number of selected Slepian basic functions
%   long_range   Longitude range
%   lati_range   Latitude range
%   regionName   Name of study region
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

nplot=6;
long_range = downsample(long_range,2);
lati_range =downsample(lati_range,2);
disp('Ploting Slepian basis functions');
load(['REGIONS/',regionName,'.mat']);
region=XY;

[X,Y]=meshgrid(long_range,lati_range);
[m,n]=size(X);
clat=reshape(90-Y,[],1);
lon=reshape(X,[],1);

N=1;
if m*n>10&&m*n<=500
    N=20;
elseif m*n>500
    N=30;
end

if rem(length(l),nplot)==0
    numraw=fix(length(l)/nplot);
else
    numraw=fix(length(l)/nplot)+1;
end
set(gcf, 'outerposition', [100 100 1000 800]);
h=figure(1);
set(h,'color','w');
wbh=waitbar(0,'Ploting Slepian basis functions...');
for z=1:length(l)
    nn=floor(length(clat)/N);
    rest=length(clat)-nn*N;
    G=[];
    for i=1:N
        G = [G;my_galpha(clat((i-1)*nn+1:i*nn),lon((i-1)*nn+1:i*nn),vec,l(z),lmax)];
    end
    if rest~=0
        G=[G;my_galpha(clat(nn*N+1:nn*N+rest),lon(nn*N+1:nn*N+rest),vec,l(z),lmax)];
    end
    G = G./max(abs(G));
    G=reshape(G,m,n);
    %     ok= abs(G)<=10^(-2);
    %     G(ok)=nan;
    %     subplot(numraw,nplot,z)
    subplot(numraw,nplot,i);
    h=pcolor(X,Y,G);
    %     colorbar;
    caxis([-1,1]);
    colormap(bluewhitered);
    set(h,'edgecolor','none','facecolor','interp');
    hold on
    plot(region(:,1),region(:,2),'k','LineWidth',2);
    xlim([long_range(1),long_range(end)]);
    ylim([lati_range(1),lati_range(end)]);
    title(['\bf{\alpha}=', num2str(l(z)), ', ' '\bf{\gamma}=', num2str(val(l(z)))]);
    set(gca,'yaxislocation','right');
    waitbar(z/length(l),wbh);
    if z~=(length(l))
        set(gca,'xtick',[0:0:0],'ytick',[0:0:0]);
    end
end
close(wbh);
saveas(gcf,'result/figure/Slepian.tiff');
delete(gcf);
