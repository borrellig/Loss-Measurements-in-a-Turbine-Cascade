function [xavg] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2,x)

% function to calculate mass flow average of a chosen quantity
% isexp accounts for the exponent of the isentropic relationship, 
% i.e. (gamma-1)/gamma

for i = 1:length(x)
    rho2(i,:) = p2(i)/Rgas/T01(i)*(p02(i)/p2(i))^isexp;
    c2(i,:) = sqrt(2*cp*T01(i)*(1-(p2(i)/p02(i))^isexp));
    c2n(i,:) = c2(i)*cos(alpha2);
end

xavg = sum(x.*rho2.*c2n)/sum(rho2.*c2n);
