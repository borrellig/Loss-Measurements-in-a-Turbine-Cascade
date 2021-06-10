clear all
clc

alpha2 = 60;
alpha2rad = alpha2*pi/180;

gamma = 1.4;
Rgas = 287;
cp = 1004.5;
freq = 15; % Hz
isexp = (gamma-1)/gamma; %exponent of isentropic transf

% Low resolution data
load 30deg.txt
load 30degHR.txt
load 30deg_rough.txt
load 10deg_rough.txt
load 0deg_rough.txt
load 20_neg_deg_rough.txt
load 30_neg_deg_rough.txt

%%
a1 = X30deg;
alpha1(1) = 30;
% alpha1rad = alpha1*pi/180; %rad

patm = a1(:,5); % kPa
T01 = a1(:,6); % K

probe_ups = a1(:,7); % deg
probe_dwns = a1(:,8); % deg
pitch = a1(:,9); % mm & cfr position
span = a1(:,10); % percentage

% lat points of dwns probe (static pressures)
p9 = a1(:,19);
p10 = a1(:,20);
p2 = (p9+p10)/2;

% midpoint dwns probe (total pressure)
p11 = a1(:,21); %%
p02 = p11;
p12 = a1(:,22); % inlet pressure
p01 = p12;

[p2avg(1)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p2);
[p02avg(1)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);
[p01avg(1)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p01);

loss_coeff(1) = ((p2avg(1)/p02avg(1))^isexp-(p2avg(1)/p01avg(1))^isexp)/(1-(p2avg(1)/p02avg(1))^isexp);

%%
a2 = X30degHR;
alpha1(2) = 30;
% alpha1rad = alpha1*pi/180; %rad

patm = a2(:,5); % kPa
T01 = a2(:,6); % K

probe_ups = a2(:,7); % deg
probe_dwns = a2(:,8); % deg
pitch = a2(:,9); % mm & cfr position
span = a2(:,10); % percentage

% lat points of dwns probe (static pressures)
p9 = a2(:,19);
p10 = a2(:,20);
p2 = (p9+p10)/2;

% midpoint dwns probe (total pressure)
p11 = a2(:,21); %%
p02 = p11;
p12 = a2(:,22); % inlet pressure
p01 = p12;

[p2avg(2)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p2);
[p02avg(2)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);
[p01avg(2)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p01);

loss_coeff(2) = ((p2avg(2)/p02avg(2))^isexp-(p2avg(2)/p01avg(2))^isexp)/(1-(p2avg(2)/p02avg(2))^isexp);

%%
a3 = X30deg_rough;
alpha1(3) = 30;
% alpha1rad = alpha1*pi/180; %rad

patm = a3(:,5); % kPa
T01 = a3(:,6); % K

probe_ups = a3(:,7); % deg
probe_dwns = a3(:,8); % deg
pitch = a3(:,9); % mm & cfr position
span = a3(:,10); % percentage

% lat points of dwns probe (static pressures)
p9 = a3(:,19);
p10 = a3(:,20);
p2 = (p9+p10)/2;

% midpoint dwns probe (total pressure)
p11 = a3(:,21); %%
p02 = p11;
p12 = a3(:,22); % inlet pressure
p01 = p12;

[p2avg(3)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p2);
[p02avg(3)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);
[p01avg(3)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p01);

loss_coeff(3) = ((p2avg(3)/p02avg(3))^isexp-(p2avg(3)/p01avg(3))^isexp)/(1-(p2avg(3)/p02avg(3))^isexp);

%%
a4(:,:,1) = X10deg_rough;
a4(:,:,2) = X0deg_rough;
a4(:,:,3) = X20_neg_deg_rough;
a4(:,:,4) = X30_neg_deg_rough;

alpha1 = [alpha1, 10, 0, -20, -30]'; %deg
% alpha1rad = alpha1*pi/180; %rad


for i = 1:4
    
    patm = a4(:,5,i); % kPa
    T01 = a4(:,6,i); % K
    
    probe_ups = a4(:,7,i); % deg
    probe_dwns = a4(:,8,i); % deg
    pitch = a4(:,9,i); % mm & cfr position
    span = a4(:,10,i); % percentage
    
    % all pressures in kPa
    
    % lat pointf of dwns probe (static pressures)
    p9 = a4(:,19,i);
    p10 = a4(:,20,i);
    p2 = (p9+p10)/2;
    
    % midpoint dwns probe (total pressure)
    p11 = a4(:,21,i); %%
    p02 = p11;
    
    p12 = a4(:,22,i); % inlet pressure
    p01 = p12;
    
  
    
    isexp = (gamma-1)/gamma; %exponent of isentropic transf
    [p2avg(i+3)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p2);
    [p02avg(i+3)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p02);
    [p01avg(i+3)] = mass_avg(T01,p2,p02,isexp,Rgas,cp,alpha2rad,p01);
    
    loss_coeff(i+3) = ((p2avg(i+3)/p02avg(i+3))^isexp-(p2avg(i+3)/p01avg(i+3))^isexp)/(1-(p2avg(i+3)/p02avg(i+3))^isexp);
    
end

fprintf('alpha1|    p01   |    p2    |    p02   | loss\n') 
for j = 1:length(alpha1)
    fprintf('%2.2f | %4.4f | %4.4f | %4.4f | %.4f \n', alpha1(j),p01avg(j),p2avg(j),p02avg(j),loss_coeff(j))
end

%% Soderbergh's evaluation

eps = abs(alpha2-alpha1);
loss_sod = 0.04+0.06*(eps/100).^2

%% total pressure lose across cascade, roughness influence

% p0_loss = abs(p01avg-p02avg);
% p0_loss = p0_loss' % kPa

% evaluating avg pressure drop for each blade

aa = X30deg_rough;
pitch = aa(:,9);
n = length(pitch);
n = n-1;
ii = n/3;

p9 = aa(:,19);
p10 = aa(:,20);
p2 = (p9+p10)/2;

% midpoint dwns probe (total pressure)
p11 = aa(:,21); %%
p02 = p11;
p12 = aa(:,22); % inlet pressure
p01 = p12;

[p02avg(1)] = mass_avg(T01(1:ii),p2(1:ii),p02(1:ii),isexp,Rgas,cp,alpha2rad,p02(1:ii));
[p01avg(1)] = mass_avg(T01(1:ii),p2(1:ii),p02(1:ii),isexp,Rgas,cp,alpha2rad,p01(1:ii));
deltap0(1) = abs(p02avg(1)-p01avg(1));
loss_rough(1) = ((p2avg(1)/p02avg(1))^isexp-(p2avg(1)/p01avg(1))^isexp)/(1-(p2avg(1)/p02avg(1))^isexp);

jj = ii+1;
[p02avg(2)] = mass_avg(T01(jj:2*ii),p2(jj:2*ii),p02(jj:2*ii),isexp,Rgas,cp,alpha2rad,p02(jj:2*ii));
[p01avg(2)] = mass_avg(T01(jj:2*ii),p2(jj:2*ii),p02(jj:2*ii),isexp,Rgas,cp,alpha2rad,p01(jj:2*ii));
deltap0(2) = abs(p02avg(2)-p01avg(2));
loss_rough(2) = ((p2avg(2)/p02avg(2))^isexp-(p2avg(2)/p01avg(2))^isexp)/(1-(p2avg(2)/p02avg(2))^isexp);

jj = 2*ii+1;
[p02avg(3)] = mass_avg(T01(jj:end),p2(jj:end),p02(jj:end),isexp,Rgas,cp,alpha2rad,p02(jj:end));
[p01avg(3)] = mass_avg(T01(jj:end),p2(jj:end),p02(jj:end),isexp,Rgas,cp,alpha2rad,p01(jj:end));
deltap0(3) = abs(p02avg(3)-p01avg(3));
loss_rough(3) = ((p2avg(3)/p02avg(3))^isexp-(p2avg(3)/p01avg(3))^isexp)/(1-(p2avg(3)/p02avg(3))^isexp);

deltap0 = deltap0'
loss_rough = loss_rough'