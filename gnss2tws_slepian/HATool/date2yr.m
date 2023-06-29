function year = date2yr(date)
% 
% Description: Convert date to fractional year
% 
% Input:
%   date            date, e.g., [yyyy mm dd]
% Output:
%   year            fractional year
% 
% Author: Zhongshan Jiang
% Date: 06/04/2023 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn

for i=1:size(date,1)
    ser = datenum(date(i,:));
    serbeg = datenum(date(i,1),1,1);
    % See if year and therefore how many days in year
    if mod(date(i,1),4) == 0 && mod(date(i,1),100) ~= 0 ||  mod(date(i,1),400 )== 0
        loy = 366;
    else
        loy = 365;
    end
    year(i,1) = date(i,1)+(ser-serbeg)./loy;
end

