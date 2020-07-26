% The new main program and figures for ductance
% variables for ductance

clear all % clear all variables
close all  

% ductance shunt conductance (L/min/mmHg)
d_vec = [0 0.1 3 10 50 100 300 500 800 1000]% 5000 10000]
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
    d = d_vec(iDD);
    asd=0;
    vsd=0;
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
plot(d_vec, ppa_d_vecD, '-o', d_vec, psa_d_vecD, '-o','linewidth', 1.5)
title('Patent Ductus Arteriosus','FontSize',18,'FontWeight','bold')
legend({'Pulmonary Artery', 'Systemic Artery'},'Location', 'east') 
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

% Ductus : shunt conductance & shunt flow mean
figure(401)
plot(d_vec, q_d_mean_vecD,'-o',d_vec, q_d_plus_vecD,'-o', d_vec, q_d_minus_vecD,'-o','linewidth', 1.2)
title('Patent Ductus Arteriosus','FontSize',18,'FontWeight','bold')
legend({'Overall Flow', 'Positive Flow', 'Negative Flow'},'Location', 'east') 
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
grid on

figure(402)
subplot(3,1,1),plot(d_vec, q_d_mean_vecD,'-bo','linewidth', 1.5)
title('Patent Ductus Arteriosus','FontSize',18,'FontWeight','bold')
legend({'Overall Flow'},'Location', 'east') 
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,2),plot(d_vec, q_d_plus_vecD,'r-o','linewidth', 1.5)
legend({'Positive Flow'},'Location', 'east') 
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,3),plot(d_vec, q_d_minus_vecD,'-yo','linewidth', 1.5)
legend({'Negative Flow'},'Location', 'northeast') 
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
grid on

% Ductus : shunt conductance & oxygen saturation 
figure(403)
subplot(3,1,1),semilogx(d_vec, qs_d_vecD, '-ro','linewidth', 1.5)
title('Patent Ductus Arteriosus: Systemic Artery','FontSize',18,'FontWeight','bold')
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Systemic Flow (L/min)','FontSize',15','FontWeight','bold')
grid on
subplot(3,1,2),semilogx(d_vec, 10.*oxy_sa_d_vecD, '-bo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,3),semilogx(d_vec, qs_d_vecD.*oxy_sa_d_vecD, '-mo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',15,'FontWeight','bold')
grid on

% Without semilogx 
figure(404)
subplot(3,1,1),plot(d_vec, qs_d_vecD, '-ro','linewidth', 1.5)
title('Patent Ductus Arteriosus: Systemic Artery','FontSize',18,'FontWeight','bold')
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Systemic Flow (L/min)','FontSize',15','FontWeight','bold')
grid on
subplot(3,1,2),plot(d_vec, 10.*oxy_sa_d_vecD, '-bo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,3),plot(d_vec, qs_d_vecD.*oxy_sa_d_vecD, '-mo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',15,'FontWeight','bold')
grid on

% Ductus : Flow on time dependence
figure(405)
plot(t_plot,Q_plot(jd,:),'linewidth', 1.5);
title('Patent Ductus Arteriosus Shunt Flow','FontSize',18,'FontWeight','bold')
xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')

end
