clear all

% Low resolution data
load 30degHR.txt
a = X30degHR;

M2 = 0.82;

alpha1 = 30; %deg
alpha1rad = alpha1*pi/180; %rad
alpha2 = 60;
alpha2rad = alpha2*pi/180;
gamma = 1.4;
Rgas = 287;
cp = 1004.5;

freq = 15; % Hz

patm = a(:,5); % kPa
T01 = a(:,6); % K

probe_ups = a(:,7); % deg
probe_dwns = a(:,8); % deg
pitch = a(:,9); % mm & cfr position
span = a(:,10); % percentage

% all pressures in kPa

% open air
% p1 = a(:,11); 
% p2 = a(:,12); 
% p3 = a(:,13); 
% p1_dwn = a(:,14);
% p2_dwn = a(:,15);
% p3_dwn = a(:,16);
% p0_inlet = a(:,17);
% p8 = a(:,18);

% lat pointf of dwns probe (static pressures)
p9 = a(:,19);
p10 = a(:,20); 
p2 = (p9+p10)/2;

% midpoint dwns probe (total pressure)
p11 = a(:,21); %% 
p02 = p11;

p12 = a(:,22); % inlet pressure
p01 = p12;

% figure(1)
% xlabel('pitch-wise position [mm] ')
% ylabel('Pressure [kPa]')
% hold on
% plot(p9)
% plot(p10)
% plot(p11)
% plot(p12)
% legend('1st p_s','2nd p_s','p_tot dwns','p_tot in')
% 
% figure(2)
% xlabel('pitch-wise position [mm] ')
% ylabel('Pressure [kPa]')
% hold on
% plot(p11)
% grid on

%open channels
% p13 = a(:,23);
% p14 = a(:,24);
% p15 = a(:,25);
% p16 = a(:,26);


isexp = (gamma-1)/gamma; %exponent of isentropic transf
[p2avg] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p2)
[p02avg] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02)
[p01avg] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p01)

loss_coeff = ((p2avg/p02avg)^isexp-(p2avg/p01avg)^isexp)/(1-(p2avg/p02avg)^isexp)