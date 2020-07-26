% The new main program and figures for vsd
% variables for vsd

clear all % clear all variables
close all       

% vsd shunt conductance (L/min/mmHg)
vsd_vec = [0 0.1 3 10 50 100 300 500 800 1000]% 5000 10000]
ncase_vsd = length(vsd_vec);

% each flow of interest
qAo_vsd_vecV = zeros(1,ncase_vsd);
qs_vsd_vecV = zeros(1,ncase_vsd);
qTr_vsd_vecV = zeros(1,ncase_vsd);
qPu_vsd_vecV = zeros(1,ncase_vsd);
qp_vsd_vecV = zeros(1,ncase_vsd);
qMi_vsd_vecV = zeros(1,ncase_vsd);

% shunt flow mean
q_vsd_mean_vecV = zeros(1,ncase_vsd);
q_vsd_plus_vecV = zeros(1,ncase_vsd);
q_vsd_minus_vecV = zeros(1,ncase_vsd);

% pressure in pulmonary artery and systemic artery 
ppa_vsd_vecV = zeros(1,ncase_vsd);
psa_vsd_vecV = zeros(1,ncase_vsd);

% oxygen saturation in pulmonary artery and systemic artery 
oxy_sa_vsd_vecV = zeros(1,ncase_vsd);
oxy_pa_vsd_vecV = zeros(1,ncase_vsd);

% mean value for above variables
for iV = 1:length(vsd_vec)
    vsd = vsd_vec(iV);
    asd=0;
    d=0;
    circ;
    qAo_vsd_vecV(iV) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, 10);
    qs_vsd_vecV(iV) = meanvalue(Q_plot(js,:), klokmax, T, dt, 10);
    qTr_vsd_vecV(iV) = meanvalue(Q_plot(jTr,:), klokmax, T, dt, 10);
    qPu_vsd_vecV(iV) = meanvalue(Q_plot(jPu,:), klokmax, T, dt, 10);
    qp_vsd_vecV(iV) = meanvalue(Q_plot(jp,:), klokmax, T, dt, 10);
    qMi_vsd_vecV(iV) = meanvalue(Q_plot(jMi,:), klokmax, T, dt, 10);
    
    q_vsd_mean_vecV(iV) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, 10);
    q_vsd_plus_vecV(iV) = meanvalue(max(Q_plot(jvsd,:),0), klokmax, T, dt, 10);
    q_vsd_minus_vecV(iV) = meanvalue(min(Q_plot(jvsd,:),0), klokmax, T, dt, 10);
    
    ppa_vsd_vecV(iV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_vsd_vecV(iV) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    oxy_sa_vsd_vecV(iV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_pa_vsd_vecV(iV) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, 10);
end 

if (length(vsd_vec) > 0)

% VSD : shunt conductance & pressure
figure(300)
plot(vsd_vec, ppa_vsd_vecV, '-o', vsd_vec, psa_vsd_vecV, '-o','linewidth', 1.5)
title('Ventricular Septal Defect','FontSize',18,'FontWeight','bold')
legend({'Pulmonary Artery','Systemic Artery'},'Location', 'northeast') 
xlabel('Shunt Conductance (L/min/mmHg)n','FontSize',15,'FontWeight','bold') 
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

% VSD : shunt conductance & shunt flow mean
figure(301)
plot(vsd_vec, q_vsd_mean_vecV, '-o',vsd_vec, q_vsd_plus_vecV,'-o', vsd_vec, q_vsd_minus_vecV, '-o','linewidth', 1.5)
title('Ventricular Septal Defect','FontSize',18,'FontWeight','bold')
legend({'Overall Flow', 'Positive Flow', 'Negative Flow'},'Location', 'east') 
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
grid on

% VSD : shunt conductance & oxygen saturation
figure(303)
subplot(3,1,1),semilogx(vsd_vec, qs_vsd_vecV, '-ro','linewidth', 1.5)
title('Ventricular Septal Defect: Systemic Artery','FontSize',18,'FontWeight','bold')
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Systemic Flow (L/min)','FontSize',15','FontWeight','bold')
grid on
subplot(3,1,2),semilogx(vsd_vec, 10.*oxy_sa_vsd_vecV, '-bo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',15','FontWeight','bold')
grid on
subplot(3,1,3),semilogx(vsd_vec, qs_vsd_vecV.*oxy_sa_vsd_vecV, '-mo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',15','FontWeight','bold')
grid on

% Without semilogx
figure(304)
subplot(3,1,1),plot(vsd_vec, qs_vsd_vecV, '-ro','linewidth', 1.5)
title('Ventricular Septal Defect: Systemic Artery','FontSize',18,'FontWeight','bold')
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Systemic Flow (L/min)','FontSize',15','FontWeight','bold')
grid on
subplot(3,1,2),plot(vsd_vec, 10.*oxy_sa_vsd_vecV, '-bo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',15','FontWeight','bold')
grid on
subplot(3,1,3),plot(vsd_vec, qs_vsd_vecV.*oxy_sa_vsd_vecV, '-mo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',15','FontWeight','bold')
grid on

% VSD : Flow on time dependence
figure(305)
plot(t_plot,Q_plot(jvsd,:),'linewidth', 1.5);
title('Ventricular Septal Defect Shunt Flow','FontSize',18,'FontWeight','bold')
xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')

end
