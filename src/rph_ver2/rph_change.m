% File: change.m globally overwrites the given parameters inside 
% in_circ_normal.m and changes the heart condition from normal to
% disease-state

% EminLV, EmaxLV, EminRV and EmaxRV
EminRV = EminLV;         % (mmHg/L)
EmaxRV = EmaxLV;         % (mmHg/L) 
C(iRV)=1/elastance(0,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);

% Rp value
%Rs = 17.5;
Rp = 1.3*Rs; %0.26  % lower factor by 2
G(ipa,ipv)=1/Rp;   %no valve
G(ipv,ipa)=1/Rp;   %no valve

% Pressure 
P(isv)= 7%10;
P(ipa)=70%100;

Cpa = Cpa/2 %8-->_2.png / 2-->_.png
C(ipa) = Cpa

