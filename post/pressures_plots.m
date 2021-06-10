clear all
clc
close all

% script to compare different total pressures with/without roughness and
% with different inlet angles

gamma = 1.4;
isexp = (gamma-1)/gamma; 
alpha2 = 60;
alpha2rad = alpha2*pi/180;
Rgas = 287;
cp = 1004.5;

%% no rough
load 30degHR.txt
a = X30degHR;
p0_30 = a(:,21); %% 
pitch1 = a(:,9);
ll = length(p0_30);

T01 = a(:,6);
p2 = (a(:,19)+a(:,20))/2;
p02 = a(:,21);

[avg30] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);

%% 30deg rough
load 30deg_rough.txt
a = X30deg_rough;
pitch2 = a(:,9);
p0_30r = a(:,21);

T01 = a(:,6);
p2 = (a(:,19)+a(:,20))/2;
p02 = a(:,21);

[avg30r] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);

% 10deg rough
load 10deg_rough.txt
a = X10deg_rough;
p0_10r = a(:,21);
pitch3 = a(:,9);
ll2 = length(pitch3);

T01 = a(:,6);
p2 = (a(:,19)+a(:,20))/2;
p02 = a(:,21);

[avg10r] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);

% 0deg rough
load 0deg_rough.txt
a = X0deg_rough;
p0_0r = a(:,21);

T01 = a(:,6);
p2 = (a(:,19)+a(:,20))/2;
p02 = a(:,21);

[avg0r] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);

% -20deg rough
load 20_neg_deg_rough.txt
a = X20_neg_deg_rough;
p0_n20r = a(:,21);

T01 = a(:,6);
p2 = (a(:,19)+a(:,20))/2;
p02 = a(:,21);

[avg20nr] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);

% -30deg rough
load 30_neg_deg_rough.txt
a = X30_neg_deg_rough;
p0_n30r = a(:,21);

T01 = a(:,6);
p2 = (a(:,19)+a(:,20))/2;
p02 = a(:,21);

[avg30nr] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);

%% plot rough vs no rough

figure(1)
% subplot(1,2,1)
title('Roughness influence','fontsize',16)
xlabel('Pitchwise position [mm]','fontsize',16)
ylabel('p_{02} [kPa]','fontsize',16)
hold on
plot(pitch1,p0_30)
plot(pitch1,p0_30r(1:ll))
legend('no roughness','roughness','fontsize',12)
grid on

% avg total pressures

% subplot(1,2,2)
% title('Roughness influence')
% xlabel('Pitchwise position [mm]')
% ylabel('p02 [kPa]')
% hold on
% plot([pitch1(1) pitch1(end)],[avg30 avg30],'--')
% plot([pitch1(1) pitch1(end)],[avg30r avg30r],'--')
% legend('no roughness','roughness')
% grid on

%% inlet angle influence

figure(2)
% subplot(1,2,1)
title('Inlet angle influence','fontsize',16)
xlabel('Pitchwise position [mm]','fontsize',16)
ylabel('p_{02} [kPa]','fontsize',16)
hold on
plot(pitch2,p0_30r)
plot(pitch3,p0_10r)
plot(pitch3,p0_0r)
plot(pitch3,p0_n20r)
plot(pitch3,p0_n30r)

legend('30 deg','10 deg','0 deg','-20 deg','-30 deg','fontsize',12)
grid on

% subplot with averaged total pressures

% figure(2)
% subplot(1,2,2)
% title('Inlet angle influence, avg p02')
% xlabel('Pitchwise position [mm]')
% ylabel('p02 [kPa]')
% hold on
% plot(pitch3,avg10r*ones(ll2,1),'--','Linewidth',3)
% plot(pitch3,avg0r*ones(ll2,1),'--','Linewidth',3)
% plot(pitch3,avg20nr*ones(ll2,1),'--','Linewidth',3)
% plot(pitch3,avg30nr*ones(ll2,1),'--','Linewidth',3)
% legend('10 deg','0 deg','-20 deg','-30 deg')
% grid on

%% resolution comparison

load 30deg.txt
load 30degHR.txt

aLR = X30deg;
p02LR = aLR(:,21);
pitchLR = aLR(:,9);

aHR = X30degHR;
p02HR = aHR(:,21);
pitchHR = aHR(:,9);

figure(3)
title('Spatial Resolution','fontsize',16)
xlabel('Pitchwise position [mm]','fontsize',16)
ylabel('p_{02} [kPa]','fontsize',16)
hold on
plot(pitchLR,p02LR,pitchHR,p02HR)
legend('LR','HR','fontsize',12)
grid on