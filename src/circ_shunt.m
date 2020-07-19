% Compare shunt direction for all asd, vsd, ductus

clear all % clear all variables
close all       

% asd, vsd, ductance shunt conductance (L/min/mmHg)
asd_vec = [0 0.1 3 10 50 100 300 500 800 1000 5000 10000]
vsd_vec = [0 0.1 3 10 50 100 300 500 800 1000 5000 10000]
d_vec = [0 0.1 3 10 50 100 300 500 800 1000 5000 10000]
ncase_asd = length(asd_vec);
ncase_vsd = length(vsd_vec);
ncase_d = length(d_vec);

%all_vec = [0 0.1 3 10 50 100 300 500 800 1000]
%ncase_all =length(all_vec);
%q_all_mean_vecAVD = zeros(1, ncase_all);

% asd
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

% vsd
% each flow of interest
qAo_vsd_vecV = zeros(1,ncase_vsd);
qs_vsd_vecV = zeros(1,ncase_vsd);
qTr_vsd_vecV = zeros(1,ncase_vsd);
qPu_vsd_vecV = zeros(1,ncase_vsd);
qp_vsd_vecV = zeros(1,ncase_vsd);
qMi_vsd_vecV = zeros(1,ncase_vsd);
% shunt flow mean
q_vsd_mean_vecV = zeros(1,ncase_vsd);
% pressure in pulmonary artery and systemic artery 
ppa_vsd_vecV = zeros(1,ncase_vsd);
psa_vsd_vecV = zeros(1,ncase_vsd);
% oxygen saturation in pulmonary artery and systemic artery 
oxy_sa_vsd_vecV = zeros(1,ncase_vsd);
oxy_pa_vsd_vecV = zeros(1,ncase_vsd);

% ductus 
% each flow of interest
qAo_d_vecD = zeros(1,ncase_d);
qs_d_vecD = zeros(1,ncase_d);
qTr_d_vecD = zeros(1,ncase_d);
qPu_d_vecD = zeros(1,ncase_d);
qp_d_vecD = zeros(1,ncase_d);
qMi_d_vecD = zeros(1,ncase_d);
% shunt flow mean
q_d_mean_vecD = zeros(1,ncase_d);
% pressure in pulmonary artery and systemic artery 
ppa_d_vecD = zeros(1,ncase_d);
psa_d_vecD = zeros(1,ncase_d);
% oxygen saturation in pulmonary artery and systemic artery
oxy_sa_d_vecD = zeros(1,ncase_d);
oxy_pa_d_vecD = zeros(1,ncase_d);

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
    ppa_vsd_vecV(iV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_vsd_vecV(iV) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    oxy_sa_vsd_vecV(iV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_pa_vsd_vecV(iV) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, 10);
end 

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
    ppa_d_vecD(iDD) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_d_vecD(iDD) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    oxy_sa_d_vecD(iDD) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_pa_d_vecD(iDD) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, 10);
end 

if (length(asd_vec) > 0)
if (length(d_vec) > 0)    
if (length(d_vec) > 0)

% compare shunt direction
% right to left (+)
% left to right (-)
figure(500)
plot(max(q_asd_mean_vecA,0), psa_asd_vecA, '-o', max(q_vsd_mean_vecV,0), psa_vsd_vecV, '-o', max(q_d_mean_vecD,0), psa_d_vecD, '-o','linewidth', 1.5)
title('Shunt direction (+): Systemic Artery','FontSize',18,'FontWeight','bold')
legend({'ASD', 'VSD', 'Ductus'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

figure(501)
plot(min(q_asd_mean_vecA,0), psa_asd_vecA, '-o', min(q_vsd_mean_vecV,0), psa_vsd_vecV, '-o', min(q_d_mean_vecD,0), psa_d_vecD, '-o','linewidth', 1.5)
title('Shunt direction (-): Systemic Artery','FontSize',18,'FontWeight','bold')
legend({'ASD', 'VSD', 'Ductus'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

figure(502)
plot(max(q_asd_mean_vecA,0), ppa_asd_vecA, '-o', max(q_vsd_mean_vecV,0), ppa_vsd_vecV, '-o', max(q_d_mean_vecD,0), ppa_d_vecD, '-o','linewidth', 1.5)
title('Shunt direction (+): Pulmonary Artery','FontSize',18,'FontWeight','bold')
legend({'ASD', 'VSD', 'Ductus'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

figure(503)
plot(min(q_asd_mean_vecA,0), ppa_asd_vecA, '-o', min(q_vsd_mean_vecV,0), ppa_vsd_vecV, '-o', min(q_d_mean_vecD,0), ppa_d_vecD, '-o','linewidth', 1.5)
title('Shunt direction (-): Pulmonary Artery','FontSize',18,'FontWeight','bold')
legend({'ASD', 'VSD', 'Ductus'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

figure(606)
subplot(3,1,1),plot(q_asd_mean_vecA, ppa_asd_vecA, '-o',q_asd_mean_vecA, psa_asd_vecA, '-o','linewidth', 1.5)
title('ASD Shunt Direction','FontSize',18,'FontWeight','bold')
legend({'Pulmonary Artery','Systemic Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,2),plot(q_asd_mean_vecA, ppa_asd_vecA, '-bo','linewidth', 1.5)
legend({'Pulmonary Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,3),plot(q_asd_mean_vecA, psa_asd_vecA, '-ro','linewidth', 1.5)
legend({'Systemic Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on


figure(607)
subplot(3,1,1),plot(q_vsd_mean_vecV, ppa_vsd_vecV, '-o',q_vsd_mean_vecV, psa_vsd_vecV, '-o','linewidth', 1.5)
title('VSD Shunt Direction','FontSize',18,'FontWeight','bold')
legend({'Pulmonary Artery','Systemic Artery'},'Location', 'northeast') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,2),plot(q_vsd_mean_vecV, ppa_vsd_vecV, '-bo','linewidth', 1.5)
legend({'Pulmonary Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,3),plot(q_vsd_mean_vecV, psa_vsd_vecV, '-ro','linewidth', 1.5)
legend({'Systemic Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on

figure(608)
subplot(3,1,1),plot(q_d_mean_vecD, ppa_d_vecD, '-o',q_d_mean_vecD, psa_d_vecD, '-o','linewidth', 1.5)
title('Ductus Shunt Direction','FontSize',18,'FontWeight','bold')
legend({'Pulmonary Artery','Systemic Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,2),plot(q_d_mean_vecD, ppa_d_vecD, '-bo','linewidth', 1.5)
legend({'Pulmonary Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on
subplot(3,1,3),plot(q_d_mean_vecD, psa_d_vecD, '-ro','linewidth', 1.5)
legend({'Systemic Artery'},'Location', 'east') 
xlabel('Shunt Flow Mean (L/min)','FontSize',15,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',15,'FontWeight','bold')
grid on
end
end
end