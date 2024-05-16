function TWScoef = VCDcoef2TWScoef(coef,vec)
%
% Description: Converting displacement-related Slepian coefficients to EWH-related Slepian coefficients
%
% Input:
%   coef         Displacement-related Slepian coefficients
%   vec          Eigenvectors
% Output:        
%   TWScoef      EWH-related Slepian coefficients
%
% Author: Zhongshan Jiang
% Date: 12/09/2022
% Institution: Sun Yat-Sen University
% E-mail: jiangzhsh@mail.sysu.edu.cn

lmax=sqrt(length(vec))-1;
J=length(coef(:,1));
[love_h,love_l,love_k]=load_LLNs;
pe=5507.85;
pw=1000;
[EM,EL]=addmout(lmax);
Sa=pe/3/pw*(2*EL+1)./love_h(EL+1);
wbar=waitbar(0,'coef2TWScoef');
for t=1:length(coef(1,:))
    for a=1:J
        VecSa=0;
        Veca=Sa.*vec(:,a);
        for b=1:J
            VecSa=VecSa+vec(:,b)'*Veca*coef(b,t);
        end
        TWScoef(a,t)=VecSa;
    end
     waitbar(t/length(coef(1,:)),wbar);
end
delete(wbar);
 