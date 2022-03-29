% function E = elastance(t,T,tau1,tau2,m1,m2,Emin,Emax,maxnum)
function E = elastance(t,T,t_delay,tau1,tau2,m1,m2,Emin,Emax,maxnum)

tt=mod(t-t_delay,T);
% tt=mod(t,T);
g1=(tt/tau1)^m1;
g2=(tt/tau2)^m2;
g2T=(T/tau2)^m2;
num1=g1/(1+g1);
num2=(1/(1+g2)) - (1/(1+g2T));
E=Emin + (Emax-Emin)*num1*num2/maxnum;

% t=time
% T=period of the heartbeat
% tau1,tau2 = constants with units of time 
% tau1 controls the time scale of contraction
% tau2 is approximately the duration of systole
% m1,m2 = Hill coefficients (dimensionless)
% Emin = minimum (diastolic) elastance
% Emax = maximum (systolic) elastance
% maxnum = parameter needed to get specified value of Emax-Emin
% see comments below concerning the evaluation of maxnum
%
%
%This implements the elastance function of Mynard et al.
%International Journal for Numerical Methods 
%in Biomedical Engineering 2012; 28:626–641
%DOI: 10.1002/cnm.1466
%with a very minor modification (see definition of num2)
%to ensure that E(0)=E(T), exactly instead of approximately.
%Note that elastance is the reciprocal of compliance.
%Note that the input parameter maxnum 
%must be initialized as follows:
%tt=0:(T/1000):T
%g1=(tt/tau1).^m1;
%g2=(tt/tau2).^m2;
%g2T=(T/tau2)^m2;
%num1=g1./(1+g1);
%num2=(1./(1+g2)) - (1/(1+g2T));
%maxnum = max(num1.*num2)
%It would be inefficient to do this on every call.
%Also, it cannot be done within the function on first call only,
%since the function may be called within the same program
%with different values of the parameters T,tau1,tau2,m1,m2, 
%upon which maxnum depends.
%Thus, the calling program may need to have several different
%values of maxnum, one for each parameter set that it uses.
%Note, however that maxnum does not depend on t, so the calls
%at different times with the other parameters fixed 
%do not require recomputation of maxnum.
%Also, maxnum does not depend on Emin or Emax.
