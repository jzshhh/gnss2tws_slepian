function G = my_galpha(clat,lon,vec,J,L)
%
% Description: Constructing a matrix of Slepian eigenfunctions evaluated at a set of spatial locations
%
% Input:
%   clat      Colatitude
%   lon       Longitude
%   vec       Unitary matrix of localization coefficients
%   J         NO. of the best eigenfunctions
%   L         Maximal degree
% Output:
%   G         Galpha
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

len=length(clat);
if len==1
    Ylm=ylm([0 L],[],clat*pi/180,lon*pi/180);
    Ylm=Ylm*sqrt(4*pi);
    G(1,:)=vec(:,J)'*Ylm;
else 
    [Ylm,theta,phi]=ylm([0 L],[],clat*pi/180,lon*pi/180);
	Ylm=Ylm*sqrt(4*pi);  % When calculating Ylm, in addition to the sqrt(4*pi), we need to multiply it back to get a fully normalized one
    for i=1:len
        G(i,:)=vec(:,J)'*Ylm(:,(i-1)*len+i);
    end
end


