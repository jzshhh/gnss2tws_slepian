function plot_eig_val(val,cutoff)
%
% Description: Plotting Slepian eigenvalues
%
% Input:
%   val         Eigenvalues in order
%   cutoff      Cutoff value for  eigenvalues
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

disp('Ploting Slepian eigenvalues...');
h=figure();
set(h,'color','w');
ok=find(val>=cutoff,1,'last');
x=1:length(val);
semilogx(x,val,'-o');
ylabel('Eigenvalue \gamma');
xlabel('Index \bf{\alpha}');
set(gca,'xlim',[x(1) x(end)],'ylim',[-0.05 1.05]);
hold on 
ysize=ylim;
line([ok,ok],ysize,'LineStyle','--','Color','c','LineWidth',1);
hold on 
xsize=xlim;
line(xsize,[val(ok),val(ok)],'LineStyle','--','Color','c','LineWidth',1);
text(ok+5,val(ok)+0.03,sprintf('(%d, %6.4f)',ok,val(ok)));
grid on 
saveas(gcf,'result/figure/Eigenvalue.tiff');
delete(gcf);
