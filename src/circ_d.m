% The new main program and figures for ductance
% variables for ductance

clear all % clear all variables
close all  

% ductance shunt conductance (L/min/mmHg)
jasd=7;
jvsd=8;
jd=9;
j_shunt = jd
d_vec = (0 : 0.1 : 1) / 100 % dm2
ncase_d = length(d_vec);

% each flow of interest
qAo_d_vecD = zeros(1,ncase_d);
qs_d_vecD = zeros(1,ncase_d);
qTr_d_vecD = zeros(1,ncase_d);
qPu_d_vecD = zeros(1,ncase_d);
qp_d_vecD = zeros(1,ncase_d);
qMi_d_vecD = zeros(1,ncase_d);

% shunt flow mean
q_d_mean_vecD = zeros(1,ncase_d);
q_d_plus_vecD = zeros(1,ncase_d);
q_d_minus_vecD = zeros(1,ncase_d);

% pressure in pulmonary artery and systemic artery 
ppa_d_vecD = zeros(1,ncase_d);
psa_d_vecD = zeros(1,ncase_d);

% oxygen saturation in pulmonary artery and systemic artery
oxy_sa_d_vecD = zeros(1,ncase_d);
oxy_pa_d_vecD = zeros(1,ncase_d);

% mean value for above variables
for iDD = 1:length(d_vec)
    Ashunt = d_vec(iDD);
    circ; 
    qAo_d_vecD(iDD) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, 10);
    qs_d_vecD(iDD) = meanvalue(Q_plot(js,:), klokmax, T, dt, 10);
    qTr_d_vecD(iDD) = meanvalue(Q_plot(jTr,:), klokmax, T, dt, 10);
    qPu_d_vecD(iDD) = meanvalue(Q_plot(jPu,:), klokmax, T, dt, 10);
    qp_d_vecD(iDD) = meanvalue(Q_plot(jp,:), klokmax, T, dt, 10);
    qMi_d_vecD(iDD) = meanvalue(Q_plot(jMi,:), klokmax, T, dt, 10);
    
    q_d_mean_vecD(iDD) = meanvalue(Q_plot(jd,:), klokmax, T, dt, 10);
    q_d_plus_vecD(iDD) = meanvalue(max(Q_plot(jd,:),0), klokmax, T, dt, 10);
    q_d_minus_vecD(iDD) = meanvalue(min(Q_plot(jd,:),0), klokmax, T, dt, 10);
    
    ppa_d_vecD(iDD) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_d_vecD(iDD) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    oxy_sa_d_vecD(iDD) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_pa_d_vecD(iDD) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, 10);
end 

if (length(d_vec) > 0)

% Ductus : shunt conductance & pressure
figure(400)
plot(d_vec*100, ppa_d_vecD, '-o', d_vec*100, psa_d_vecD, '-o','linewidth', 2)
title('Patent Ductus Arteriosus')
legend({'Pulmonary Artery', 'Systemic Artery'},'Location', 'east','FontSize',25) 
xlabel('Shunt Area (cm^2)')
ylabel('Pressure (mmHg)')
set(gca,'FontSize',25)
grid on

% Ductus : shunt conductance & shunt flow mean
figure(401)
plot(d_vec*100, q_d_mean_vecD,'-o',d_vec*100, q_d_plus_vecD,'-o', d_vec*100, q_d_minus_vecD,'-o','linewidth', 2)
title('Patent Ductus Arteriosus')
legend({'Overall Flow', 'Positive Flow', 'Negative Flow'},'Location', 'east','FontSize',25) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',25)
grid on

figure(402)
subplot(3,1,1),plot(d_vec*100, q_d_mean_vecD,'-bo','linewidth', 2)
title('Patent Ductus Arteriosus')
legend({'Overall Flow'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,2),plot(d_vec*100, q_d_plus_vecD,'r-o','linewidth', 2)
legend({'Positive Flow'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,3),plot(d_vec*100, q_d_minus_vecD,'-yo','linewidth', 2)
legend({'Negative Flow'},'Location', 'northeast','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on

% Ductus : shunt conductance & oxygen saturation 
% Without semilogx 
figure(403)
subplot(3,1,1),plot(d_vec*100, qs_d_vecD, '-ro','linewidth', 2)
title('Patent Ductus Arteriosus: Systemic Artery')
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Flow (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,2),plot(d_vec*100, 10.*oxy_sa_d_vecD, '-bo','linewidth', 2)
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',18)
grid on
subplot(3,1,3),plot(d_vec*100, qs_d_vecD.*oxy_sa_d_vecD, '-mo','linewidth', 2)
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Delivery (mmol/min)')
set(gca,'FontSize',18)
grid on

% Ductus : Flow on time dependence
figure(404)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
title('Patent Ductus Arteriosus Shunt Flow')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
yline(0, '--b','linewidth', 2)
% draw a line on the 0 

%figure(406)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jAo,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
%title('Aortic Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 50])

%figure(407)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jTr,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
%title('Tricuspid Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 30])

%figure(408)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jPu,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
%title('Pulmonic Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 60])

%figure(409)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jMi,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
%title('Mitral Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 25])

end
