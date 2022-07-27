global T TS tauS tauD;
global G dt CHECK N;


in_circ_normal %initialize
for klok=1:klokmax
    
  t=klok*dt;
  P_old=P;
  C_old=C;
  
  Pdiff_old = P_old(iU)-P_old(iD);
  Q_old = (Gf.*(Pdiff_old>0)+Gr.*(Pdiff_old<0)).*Pdiff_old;
  V_old = Vd + C_old.*P_old;
  
  %find current values of left and right 
  %ventricular compliance and store each 
  %of them in the appropriate slot in the array C:
  
  C(iLV)=1/elastance(t,T,0,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum);
  C(iRV)=1/elastance(t,T,0,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
  C(iLA)=1/elastance(t,T,t_atrial_delay,tau1A,tau2A,m1A,m2A,EminLA,EmaxLA,maxnumA);
  C(iRA)=1/elastance(t,T,t_atrial_delay,tau1A,tau2A,m1A,m2A,EminRA,EmaxRA,maxnumA);
  % V_total_start = Vd+C.*P
  % fixed-point iteration
  for ifp=1:ifpmax

    %this is important to make sure we are using the conductances at the correct time!
    G_prev = G;

    set_valves
    %store variables in arrays for future plotting:

    t_plot(klok)=t;
    C_plot(:,klok)=C;
    P_plot(:,klok)=P;
    V_plot(:,klok)=Vd+C.*P;
    V = Vd+C.*P;
    
    Pdiff=P(iU)-P(iD); %pressure differences 
                        %for flows of interest:
    Q_plot(:,klok)=(Gf.*(Pdiff>0)+Gr.*(Pdiff<0)).*Pdiff;
    %(the net flow is computed in each case)

  end
  
end
%plot results:
circ_out
