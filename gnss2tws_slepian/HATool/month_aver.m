function  [time_mon,data_mon]=month_aver(data_raw,GNSS_times)
% 
% Description: Calculating monthly average from daily time series
% 
% Input:
%   data_raw        Daily time series  
%   GNSS_times      Daily date, format: YYYYMMDD
% Output:
%   time_mon        Monthly date,, format: YYYYMM15
%   data_mon        Monthly time series  
% 
% Author: Zhongshan Jiang
% Date: 06/04/2023 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn

time_num=datenum(datevec(num2str(GNSS_times),'yyyymmdd'));
yyyymm=str2num(datestr(time_num,'yyyymm'));
months=unique(yyyymm);

data_mon=NaN(length(months),size(data_raw,2));
time_mon=NaN(length(months),1);
for i=1:size(data_raw,2)
    for j=1:length(months)
        ok=find(months(j)==yyyymm);
        time_mon(j,1)=months(j)*100+15;
        data_mon(j,i)=mean(data_raw(ok,i),'includenan');
    end
end
