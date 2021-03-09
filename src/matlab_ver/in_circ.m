%filename: in_circ.m  (initialization for circ)
T =0.0125    %Duration of heartbeat (minutes)


tau1 = 0.269*T % time scale of contraction (minutes)
tau2 = 0.452*T % duration of systole (minutes)
m1 = 1.32
m2 = 27.4
%initialization of maxnum (same for both ventricles):
tt=0:(T/1000):T;
g1=(tt/tau1).^m1;
g2=(tt/tau2).^m2;
g2T=(T/tau2)^m2;
num1=g1./(1+g1);
num2=(1./(1+g2)) - (1/(1+g2T));
maxnum = max(num1.*num2)
%parameters specific to each ventricle:
EminLV = 0.08*1000 % (mmHg/L)
EmaxLV = 30.00*1000 % (mmHg/L)
EminRV = EminLV %0.04*1000 % (mmHg/L)
EmaxRV = EmaxLV %0.60*1000 % (mmHg/L)

tmax=10*T
clockmax =3000
dt=tmax/clockmax
for clock=1:clockmax
  t=clock*dt;
  ELV(clock)=elastance(t,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum);
  ERV(clock)=elastance(t,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
  tsave(clock) = t;
end
plot(tsave,ELV,tsave,ERV)

%TS=0.005     %Duration of systole   (minutes)
% 
%tauS=0.0025  %CLV time constant during systole (minutes)

% double it triple it ... 
% voa flows 
%0.0025

%tauD=0.0075  %CLV time constant during diastole (minutes)

% different compliance function
% tauS, tauD

Rs=17.5 %Systemic resistance  
% ( 10.8 mmHg / ((liter/minute)/m2)))/ 0.44 m2
% SVR = 10.8 Wood U x m2
% Du Bois commonly used ==> 0.44 m2
% Rp=(18.6/0.44)
Rp=1.5*Rs
%Rp= 1.79     %Pulmonary resistance (mmHg/(liter/minute))

%Unrealistic valve resistances,
%Chosen small enough to be negligible.
RMi=0.01   %mitral valve resistance (mmHg/(liter/minute))
RAo=0.01   %aortic valve resistance (mmHg/(liter/minute))
RTr=0.01   %tricuspid valve resistance (mmHg/(liter/minute))
RPu=0.01   %pulmonic valve  resistance (mmHg/(liter/minute))
Rvisc = 0.01

%The following values of Csa and Cpa are approximate.
%They will need adjustment to make the systemic 
%blood pressure be roughly 120/80 mmHg
%and to make the pulmonary 
%blood pressure be roughly 25/8 mmHg.
Csa=0.00175   %Systemic  arterial compliance (liters/mmHg)
%Cpa=0.00412  %Pulmonary arterial compliance (liters/mmHg)
Cpa=Csa
Csv=1.75     %Systemic  venous compliance (liters/mmHg)
Cpv=0.08     %Pulmonary venous compliance (liters/mmHg)
CLVS=0.00003  %Min (systolic)  value of CLV (liters/mmHg)
CLVD=0.0146   %Max (diastolic) value of CLV (liters/mmHg)
%Make the compliance the same
CRVS=CLVS
CRVD=CLVD
%CRVS=0.0002  %Min (systolic)  value of CRV (liters/mmHg)
%CRVD=0.0365  %Max (diastolic) value of CRV (liters/mmHg)
Vsad=0.825     %Systemic arterial volume at P=0 (liters)
Vpad=0.0382    %Pulmonary arterial volume at P=0 (liters)
Vsvd=0         %Systemic venous volume at P=0 (liters)
Vpvd=0         %Pulmonary venous volume at P=0 (liters)
VLVd=0.010     %Left ventricular volume at P=0 (liters)
VRVd= VLVd     %0.055  %Right ventricular volume at P=0 (liters) 0.027
%0.01
dt=0.01*T    %Time step duration (minutes)
%This choice implies 100 timesteps per cardiac cycle.
klokmax=100*T/dt %T/dt %Total number of timesteps 
%This choice implies simulation of 15 cardiac cycles.

ifpmax = 10 
%the trouble comes from the fact that we set the conductance of the shunt based on 
%its flow in the previous time step.  It would be better to use the flow in 
%the present time step, but this is unknown.  To find it, we could try fixed-point iteration, 
%which simply means that we repeat each time step some number of times, 
%always adjusting the conductance accordingto the flow that we found on 
%the latest pass through the time step.

%Assign an index to each compliance vessel 
%of the model circulation:
iLV=1
isa=2
isv=3
iRV=4
ipa=5
ipv=6
N=6
%Enter parameters and initial values 
%into correct slots in arrays.
%Note that the code that follows is independent 
%of the specific numbering scheme chosen above.
%Compliance vector:
C=zeros(N,1);  
%This makes C a column vector of length N.
%C(iLV)=CV_now(0,CLVS,CLVD); % CLVS,CLVD  %initial value
C(iLV)=1/elastance(0,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum)
C(isa)=Csa;
C(isv)=Csv;
%C(iRV)=CV_now(0,CRVS,CRVD); % CRVS, CRVD %initial value
C(iRV)=1/elastance(0,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
C(ipa)=Cpa;  %Cpa
C(ipv)=Cpv;
C  %This writes the result on the screen.

%Pressure vector (initial values) at end of diastole:
P=zeros(N,1);  
%This makes P a column vector of length N.
P(iLV)= 5;
P(isa)=80;
%P(isv)= 2;
P(isv)= 4;
P(iRV)= 2;
%P(ipa)= 8; 
P(ipa)=100;
P(ipv)= 5;
P  %This writes the result on the screen.
%Vector of dead volumes (volume at zero pressure);
%Note: Vd is only needed for output purposes.  
%It drops out of the equations we solve for P, 
%but we need it if we want to output (e.g., plot)  
%the volume of any compliance vessel.
Vd=zeros(N,1);  
%This makes Vd a column vector of length N.
Vd(iLV)=VLVd;
Vd(isa)=Vsad;
Vd(isv)=Vsvd;
Vd(iRV)=VRVd;
Vd(ipa)=Vpad;
Vd(ipv)=Vpvd;
Vd  
%This writes the results on the screen.
%Conductance matrix:
G=zeros(N,N);  
%This makes G an NxN matrix filled with zeros.
%Any element of G that is not explicitly 
%made nonzero remains zero, 
%thus modeling an infinite resistance connection, 
%that is, no connection at all.
G(iLV,isa)=1/RAo;  %But G(isa,iLV)=0 (no leak)
G(isa,isv)=1/Rs;   %no valve
G(isv,isa)=1/Rs;   %no valve
G(isv,iRV)=1/RTr;  %But G(iRV,isv)=0; (no leak)
G(iRV,ipa)=1/RPu;  %But G(ipa,iRV)=0; (no leak)
G(ipa,ipv)=1/Rp;   %no valve
G(ipv,ipa)=1/Rp;   %no valve
G(ipv,iLV)=1/RMi;  %But G(iLV,ipv)=0; (no leak)

%New varaiable
% asd = 1,10,100 // vsd =1,10,100...  // d = 1,10,100...
G;  %This writes the result on the screen.

%Matrix of initial valve states:
S=zeros(N,N);   
%This makes S an NxN matrix filled with zeros
%(and writes it on the screen).
%Start with all valves closed.
%Valves will adjust to pressures 
%during first time step.
%Initialize arrays to store data for plotting:
t_plot=zeros(1,klokmax);
C_plot=zeros(N,klokmax);
P_plot=zeros(N,klokmax);

% V_diff arrary
V_diff=zeros(N,klokmax);

O2_plot=zeros(N,klokmax);
O2_amt_plot=zeros(N,klokmax);
total_oxy_amt_plot=zeros(klokmax,1);
Gshuntf_plot=zeros(1,klokmax);
Gshuntr_plot=zeros(1,klokmax);
%Other variables that we might want to plot 
%can be found from these.
%For self-checking in P_new, set CHECK=1.
%To skip self-checking set CHECK=0.
%(should be much faster with CHECK=0)

CHECK=0;
%Initialize flow computation (for output purposes only)
%assign an index to each flow of interest:
jAo=1;
js =2; % except this one
jTr=3;
jPu=4;
jp =5; % except this one
jMi=6;

%add three more flows(atria, ventricle ,artery)

Nflows=9;

%note index of upstream and downstream chamber 
%for each flow:
iU=zeros(Nflows,1);
iD=zeros(Nflows,1);
iU(jAo)=iLV;
iD(jAo)=isa;
iU(js )=isa;
iD(js )=isv;
iU(jTr)=isv;
iD(jTr)=iRV;
iU(jPu)=iRV;
iD(jPu)=ipa;
iU(jp )=ipa;
iD(jp )=ipv;
iU(jMi)=ipv;
iD(jMi)=iLV;

%NEW three connections between the flow
iU(jasd)=isv;
iD(jasd)=ipv;
iU(jvsd)=iRV;
iD(jvsd)=iLV;
iU(jd)=ipa;
iD(jd)=isa;

%Ashunt
%pause

if (Ashunt > 0) 
    
G(iU(j_shunt),iD(j_shunt)) = 1 / Rvisc
G(iD(j_shunt),iU(j_shunt)) = 1 / Rvisc

end

% oxy concentration mmol/L
% metabolism = mmol/min

% O2 concentration
% 8.2/ 64868 * 1000 = 1.272
% 4*[Hb]=4 * 1.272 = 5.088  (mmol/liter)

% initial O2 concentration (wrong)
% woman hb = 12 gm/dl
% (10 * (8.2/12)) = 6.83

% mb = -((160 / 22.4) * 0.44)= -3.14285 (pi)
% 1 mmol occupies 22.4 mL and 0.44 is du-bois

% O2 concentration M ==> mol/L
% hemoglobin molecule has four binding sites for oxygen molecules
% 4*[Hb] = 4 * 2.5(mmol/L) = 10 mmol/L
oxy_vec = ones(N, 1) .* 10;   % 5.088

%metabolism amount
%10 * 0.3*5.6=16.8 (mmol/min)

metabolism = zeros(size(G));
metabolism(isa, isv) = -16.8;

%extract the conductances from the matrix G:
Gf=zeros(Nflows,1);
Gr=zeros(Nflows,1);
for j=1:Nflows
  Gf(j)=G(iU(j),iD(j)); %forward conductance
  Gr(j)=G(iD(j),iU(j)); %reverse conductance
end
%create arrays to store current pressure differences 
%and history over time of the net flows:
Pdiff=zeros(Nflows,1);
Q_plot=zeros(Nflows,klokmax);
