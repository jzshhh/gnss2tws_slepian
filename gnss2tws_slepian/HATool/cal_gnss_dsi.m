function [gps_ewh_smooth,gps_season,ewh_diff,ewh_defi,ewh_surp,gnss_dsi] = cal_gnss_dsi(time_mon,gnss_ewh)
% 
% Description: Calculating GNSS-based drought severity index 
% 
% Input:
%   time_mon         Monthly date, format: YYYYMM15 
%   gnss_ewh         Monthly GNSS-EWH time series
% Output:
%   gnss_ewh_smooth  Smoothing GNSS-EWH time series 
%   gnss_season      Climatological averages 
%   ewh_diff         GNSS-EWH anomaly time series
%   ewh_defi         Water storage deficit  time series
%   ewh_surp         Water storage surplus time series
%   gnss_dsi         GNSS-DSI (or standardized EWH anomaly time series)
% 
% Author: Zhongshan Jiang
% Date: 06/10/2023 
% Institution: Sun Yat-Sen University 
% E-mail: jiangzhsh@mail.sysu.edu.cn

gps_ewh_smooth=movmean(detrend(gnss_ewh),3);

st_yr=fix(time_mon(1)/10000);
en_yr=fix(time_mon(end)/10000);
nyears=en_yr-st_yr+1;
num=0;
for i=st_yr:en_yr
    for j=1:12
        num=num+1;
        times_all(num)=i*10000+j*100+15;
    end
end

[~,ok1,ok2]=intersect(time_mon,times_all);
ewh=nan(12,nyears);
ewh(ok2)=gps_ewh_smooth(ok1);

ewh_mon_ave = mean(ewh,2,'includenan');
ewh_mon_std = std(ewh,0,2,'includenan');

gps_dsi_tmp=nan(12,nyears);
diff_ewh_emp=nan(12,nyears);

for i =1:size(ewh,1)
    diff_ewh_emp(i,:)=ewh(i,:)-ewh_mon_ave(i);
    gps_dsi_tmp(i,:)=(diff_ewh_emp(i,:))./ewh_mon_std(i);   
end
gps_season=repmat(ewh_mon_ave,size(ewh,2),1);  gps_season=gps_season(ok2);
gnss_dsi = reshape(gps_dsi_tmp,[],1);  gnss_dsi=gnss_dsi(ok2);
ewh_diff=reshape(diff_ewh_emp,[],1);  ewh_diff=ewh_diff(ok2);
ewh_defi= ewh_diff;
ewh_defi(ewh_defi>0)=0;
ewh_surp=ewh_diff;
ewh_surp(ewh_surp<0)=0;
end