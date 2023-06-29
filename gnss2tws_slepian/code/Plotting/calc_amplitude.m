function amplitude=calc_amplitude(ts)
%
% Description: Calculating annual amplitude of a time series
%
% Input:
%   ts            A time series with the first column time (Decimal year)
%   and the second column data
% Output:
%   amplitude     Annual amplitude of a time series
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

time=ts(:,1);data=ts(:,2);
A=[ones(size(data,1),1) time-time(1) cos(2*pi*time) sin(2*pi*time) cos(4*pi*time) sin(4*pi*time)];
B=data;
coeff=lscov(A,B);
amplitude=(coeff(3,:).^2+coeff(4,:).^2).^0.5;
amplitude=amplitude';
end