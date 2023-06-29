function [h, l, k]=load_LLNs
%% Read the load Love numbers from the file 'PREM-LLNs-complete.dat'
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

fname='PREM-LLNs-complete.dat';
fid=fopen(fname,'r+');
data=textscan(fid,'%d %f %f %f %f %f','headerlines',1);
fclose(fid);
h=cell2mat(data(2));
l=cell2mat(data(3));
k=cell2mat(data(4));

end
