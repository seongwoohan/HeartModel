% The new main program and figures for asd
% variables for asd

clear all % clear all variables
close all       

% asd shunt conductance (L/min/mmHg)
asd_vec = [0 0.1 3 10 50 100 300 500 800 1000]% 5000 10000]
ncase_asd = length(asd_vec);

% each flow of interest
qAo_asd_vecA = zeros(1,ncase_asd);
qs_asd_vecA = zeros(1,ncase_asd);
qTr_asd_vecA = zeros(1,ncase_asd);
qPu_asd_vecA = zeros(1,ncase_asd);
qp_asd_vecA = zeros(1,ncase_asd);
qMi_asd_vecA = zeros(1,ncase_asd);

% shunt flow mean
q_asd_mean_vecA = zeros(1,ncase_asd);

% pressure in pulmonary artery and systemic artery 
ppa_asd_vecA = zeros(1,ncase_asd);
psa_asd_vecA = zeros(1,ncase_asd);

% oxygen saturation in pulmonary artery and systemic artery 
oxy_sa_asd_vecA = zeros(1,ncase_asd);
oxy_pa_asd_vecA = zeros(1,ncase_asd);

% mean value for above variables
for iA = 1:length(asd_vec)
    asd = asd_vec(iA);
    vsd=0; 
    d=0;
    circ;     
    qAo_asd_vecA(iA) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, 10);
    qs_asd_vecA(iA) = meanvalue(Q_plot(js,:), klokmax, T, dt, 10);
    qTr_asd_vecA(iA) = meanvalue(Q_plot(jTr,:), klokmax, T, dt, 10);
    qPu_asd_vecA(iA) = meanvalue(Q_plot(jPu,:), klokmax, T, dt, 10);
    qp_asd_vecA(iA) = meanvalue(Q_plot(jp,:), klokmax, T, dt, 10);
    qMi_asd_vecA(iA) = meanvalue(Q_plot(jMi,:), klokmax, T, dt, 10);
    q_asd_mean_vecA(iA) = meanvalue(Q_plot(jasd,:), klokmax, T, dt, 10);	   
    ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_pa_asd_vecA(iA) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, 10);
end

if (length(asd_vec) > 0)

% ASD : shunt conductance & pressure
figure(200)
plot(asd_vec, ppa_asd_vecA, '-o', asd_vec, psa_asd_vecA, '-o','linewidth', 1.5)
title('Atrial Septal Defect','FontSize',18,'FontWeight','bold')
legend({'Pulmonary Artery', 'Systemic Artery'},'Location', 'east') 
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

% ASD : shunt conductance & shunt flow mean
figure(201)
plot(asd_vec, q_asd_mean_vecA, '-o','linewidth', 1.5)
title('Atrial Septal Defect','FontSize',18,'FontWeight','bold')
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold')
ylabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
grid on

% ASD : shunt conductance & oxygen saturation 
figure(203)
subplot(3,1,1),semilogx(asd_vec, qs_asd_vecA, '-ro','linewidth', 1.5)
title('Atrial Septal Defect: Systemic Artery','FontSize',18,'FontWeight','bold')
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15','FontWeight','bold') 
ylabel('Cardiac Output (L/min)','FontSize',15','FontWeight','bold')
grid on
subplot(3,1,2),semilogx(asd_vec, 10.*oxy_sa_asd_vecA, '-bo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,3),semilogx(asd_vec, qs_asd_vecA.*oxy_sa_asd_vecA, '-mo','linewidth', 1.5)
xlabel('Shunt Conductance (L/min/mmHg)','FontSize',15,'FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',15,'FontWeight','bold')
grid on

%figure(206)
%need this when calibrating data
%plot(asd_vec, qp_asd_vecA, '-bo','linewidth', 1.5); hold on;
%plot(asd_vec, qs_asd_vecA, '-mo', 'linewidth', 1.5); hold off;
%grid on

end