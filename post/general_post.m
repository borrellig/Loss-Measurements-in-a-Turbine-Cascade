% General structure of the script for post processing of the data

clear all
clc

gamma = 1.4;
Rgas = 287;
cp = 1004.5;
freq = 15; % Hz
isexp = (gamma-1)/gamma; %exponent of isentropic transf

% load data 
load 30deg.txt
% load 30degHR.txt
% load 30deg_rough.txt
% load 10deg_rough.txt
% load 0deg_rough.txt
% load 20_neg_deg_rough.txt
% load 30_neg_deg_rough.txt

%% example with experiment 1 
a = X30deg;
alpha1(1) = 30; %deg
% alpha1rad = alpha1*pi/180; %rad
alpha2 = 60; %deg
alpha2rad = alpha2*pi/180; %rad

patm = a(:,5); % kPa
T01 = a(:,6); % K

probe_ups = a(:,7); % deg
probe_dwns = a(:,8); % deg
pitch = a(:,9); % mm, cfr position
span = a(:,10); % percentage

% lat points of dwns probe (static pressures)
p9 = a(:,19);
p10 = a(:,20);
p2 = (p9+p10)/2; % p2 obtained with avg between the two static ports

% midpoint dwns probe (outlet total pressure)
p11 = a(:,21); 
p02 = p11;

% ups probe (inlet total pressure)
p12 = a(:,22); 
p01 = p12;

[p2avg] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p2);
[p02avg] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);
[p01avg] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p01);

loss_coeff = ((p2avg/p02avg)^isexp-(p2avg/p01avg)^isexp)/(1-(p2avg/p02avg)^isexp);

% printing results
fprintf('alpha1|    p01   |    p2    |    p02   | loss\n') 
fprintf('%2.2f | %4.4f | %4.4f | %4.4f | %.4f \n', alpha1,p01avg,p2avg,p02avg,loss_coeff)

%% Soderbergh's evaluation for comparison

eps = abs(alpha2-alpha1);
loss_sod = 0.04+0.06*(eps/100).^2;

%% Plots of interest... (e.g. resolution, roughness, inlet angle..)