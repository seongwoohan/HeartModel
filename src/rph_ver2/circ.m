global T TS tauS tauD;
global G dt CHECK N;

in_circ_normal  %initialize
%change

for klok=1:klokmax
    
  t=klok*dt;
  oxy_old_vec = oxy_vec;
  P_old=P;
  C_old=C;
  
  Pdiff_old = P_old(iU)-P_old(iD);
  Q_old = (Gf.*(Pdiff_old>0)+Gr.*(Pdiff_old<0)).*Pdiff_old;
  V_old = Vd + C_old.*P_old;
  
  %find current values of left and right 
  %ventricular compliance and store each 
  %of them in the appropriate slot in the array C:
  
  %C(iLV)=CV_now(t,CLVS,CLVD);
  %C(iRV)=CV_now(t,CRVS,CRVD);
  %find self-consistent valve states and pressures:
  
  C(iLV)=1/elastance(t,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum);
  C(iRV)=1/elastance(t,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
  
  % V_total_start = Vd+C.*P
  % fixed-point iteration
  for ifp=1:ifpmax

    % this is very important... to make sure we are using the conductances at the correct time!
    G_prev = G;

    set_valves
    %store variables in arrays for future plotting:

    t_plot(klok)=t;
    C_plot(:,klok)=C;
    P_plot(:,klok)=P;
    V_plot(:,klok)=Vd+C.*P;
    V = Vd+C.*P;
    
    % calculate initial volume difference
%    V_total = sum(V)
%    V_diff(klok) = V_total - V_total_start
    
    Pdiff=P(iU)-P(iD); %pressure differences 
                        %for flows of interest:
    Q_plot(:,klok)=(Gf.*(Pdiff>0)+Gr.*(Pdiff<0)).*Pdiff;
    %(the net 4flow is computed in each case)
  
    % gorlin equation place
    rho = 1000 / ((1.36*980*10*(60)^2));   % mmHg.min2/dm2
 
    % extra careful about the parethesis
    if (Ashunt > 0)
      
    G(iU(j_shunt),iD(j_shunt)) = 1 / (Rvisc + ( (rho / (2*Ashunt^2) )* abs(Q_plot(j_shunt,klok))));
    G(iD(j_shunt),iU(j_shunt)) = 1 / (Rvisc + ( (rho / (2*Ashunt^2) )* abs(Q_plot(j_shunt,klok))));
  
    Gf(j_shunt)=G(iU(j_shunt),iD(j_shunt)); %forward conductance
    Gr(j_shunt)=G(iD(j_shunt),iU(j_shunt)); %reverse conductance
  
    end
    Gshuntf_plot(klok) = Gf(j_shunt);
    Gshuntr_plot(klok) = Gr(j_shunt);

  end
  
  % oxygen
  
  if S(ipa,ipv) == 0
      error("S(ipa,ipv) == 0")
  end   
  
  Qp = S(ipa,ipv)*G(ipa,ipv)*(P(ipa)-P(ipv));
  metabolism(ipa,ipv) = Qp * (10 - oxy_old_vec(ipa));
  
  % maybe forward euler?
  % backward euler method
  for i=1:N
      oxy_amt(i)=oxy_old_vec(i)*V_old(i);
      for j=1:N
          if j ~= i
              Qij = S(i,j)*G_prev(i,j)*(P(i)-P(j));
              Qji = S(j,i)*G_prev(j,i)*(P(j)-P(i));
             
              oxy_amt(i) = oxy_amt(i) + dt*(oxy_old_vec(j) * Qji - oxy_old_vec(i) * Qij + metabolism(j,i));
          end
      end
      oxy_vec(i) = oxy_amt(i)/V(i);
      total_oxy_amt_plot(klok,1) = total_oxy_amt_plot(klok,1) + oxy_amt(i);
  end
  
  oxy_vec
  % store the O2 cocentration at klok
  O2_plot(:,klok) = oxy_vec;  
  O2_amt_plot(:,klok) = oxy_amt; 
  %pause
end
%plot results:
circ_out
