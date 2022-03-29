% File: change.m globally overwrites the given parameters inside 
% in_circ_normal.m and changes the heart condition from normal to
% disease-state

% EminLV, EmaxLV, EminRV and EmaxRV
EminRV = EminLV;         % (mmHg/L)
EmaxRV = EmaxLV;         % (mmHg/L) 
C(iRV)=1/elastance(0,T,0,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);

EminRA = EminLA;
C(iRA) = 1/elastance(t,T,t_atrial_delay,tau1A,tau2A,m1A,m2A,EminRA,EmaxRA,maxnumA);
 
% in_circ_normal_v2
% C(iRV)=1/elastance(0,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);

% Rp value
%Rs = 17.5;
%Rp = 16
Rp = 1.3*Rs; %14.95%0.26  % lower factor by 2
%{
Rs_normal = 17.5;
Rs = Rs_normal;
Rp_RPH = 1.3*Rs_normal
Rp = 14.95%Rp_RPH
%}
G(ipa,ipv)=1/Rp;   %no valve
G(ipv,ipa)=1/Rp;   %no valve

% Pressure 
P(isv)= 7%10;
P(ipa)=70%100;
<<<<<<< HEAD
% in_circ_normal_v2 --> turn off
=======
>>>>>>> 1ceb2fd9229b3cfd925e0d4f2ea2cc251f22dd0f
P(iRA)= P(isv)
P(iLA)= P(ipv)

Cpa = Cpa/2 %8-->_2.png / 2-->_.png
C(ipa) = Cpa
<<<<<<< HEAD
% in_circ_normal_v2 --> turn off
=======
>>>>>>> 1ceb2fd9229b3cfd925e0d4f2ea2cc251f22dd0f
C(iRA) = C(iLA)
