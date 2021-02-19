%compute and plot elastance for LV and RV
%
%parameters that are the same for both ventricles:
T = 0.0125 %0.89/60 % period of heartbeat (minutes)
tau1 = 0.269*T % time scale of contraction (minutes)
tau2 = 0.452*T % duration of systole (minutes)
m1 = 1.32
m2 = 27.4
%initialization of maxnum (same for both ventricles):
tt=0:(T/1000):T
g1=(tt/tau1).^m1
g2=(tt/tau2).^m2
g2T=(T/tau2)^m2
num1=g1./(1+g1)
num2=(1./(1+g2)) - (1/(1+g2T))
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
plot(tsave,ELV, tsave, ERV)

