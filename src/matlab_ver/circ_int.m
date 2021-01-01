tic
clear all % clear all variables
close all  

jasd=7;
jvsd=8;
jd=9;

int_vec = (0 : 0.1 : 1) / 100

ncase_asd = length(int_vec);
ncase_vsd = length(int_vec)
ncase_d = length(int_vec);

% each flow of interest
qs_asd_vecA = zeros(1,ncase_asd);
qs_vsd_vecV = zeros(1,ncase_vsd);
qs_d_vecD = zeros(1,ncase_d);

% pressure in pulmonary artery and systemic artery 
ppa_asd_vecA = zeros(1,ncase_asd);
psa_asd_vecA = zeros(1,ncase_asd);
ppa_vsd_vecV = zeros(1,ncase_vsd);
psa_vsd_vecV = zeros(1,ncase_vsd);
ppa_d_vecD = zeros(1,ncase_d);
psa_d_vecD = zeros(1,ncase_d);

% oxygen saturation in pulmonary artery and systemic artery
oxy_sa_asd_vecA = zeros(1,ncase_asd);
oxy_pa_asd_vecA = zeros(1,ncase_asd);
oxy_sa_vsd_vecV = zeros(1,ncase_vsd);
oxy_pa_vsd_vecV = zeros(1,ncase_vsd);
oxy_sa_d_vecD = zeros(1,ncase_d);
oxy_pa_d_vecD = zeros(1,ncase_d);

num_cycles_for_mean = 10;

% mean value for above variables
for iA = 1:length(int_vec)
    j_shunt = jasd
    Ashunt = int_vec(iA);
    circ;     
    qs_asd_vecA(iA) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_pa_asd_vecA(iA) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
end

for iV = 1:length(int_vec)
    j_shunt = jvsd
    Ashunt = int_vec(iV);
    circ;
    qs_vsd_vecV(iV) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    ppa_vsd_vecV(iV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    psa_vsd_vecV(iV) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_sa_vsd_vecV(iV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_pa_vsd_vecV(iV) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
end 

for iDD = 1:length(int_vec)
    j_shunt = jd
    Ashunt = int_vec(iDD);
    circ; 
    qs_d_vecD(iDD) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    ppa_d_vecD(iDD) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    psa_d_vecD(iDD) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_sa_d_vecD(iDD) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_pa_d_vecD(iDD) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
end 
%, int_vec*100, qs_vsd_vecV, int_vec*100, qs_d_vecD

%{
figure(500)
plot(int_vec*100, ppa_asd_vecA, '-o', int_vec*100, ppa_vsd_vecV, '-o', int_vec*100, ppa_d_vecD, '-o','linewidth', 4)
set(gca,'FontSize',25)
title('Pulmonary Artery Pressure','FontSize',22)
legend({'ASD','VSD','PDA'},'Location', 'best','FontSize',18) 
legend boxoff                  
xlabel('Shunt Area (cm^2)','FontSize', 22) 
ylabel('Pressure (mmHg)','FontSize', 22)
grid on

figure(501)
plot(int_vec*100, psa_asd_vecA, '-o', int_vec*100, psa_vsd_vecV, '-o', int_vec*100, psa_d_vecD, '-o','linewidth', 4)
set(gca,'FontSize',25)
title('Systemic Artery Pressure','FontSize', 22)
legend({'ASD','VSD','PDA'},'Location', 'east','FontSize',18) 
legend boxoff 
xlabel('Shunt Area (cm^2)','FontSize', 22) 
ylabel('Pressure (mmHg)','FontSize', 22)
grid on
%}

figure(600)
plot(int_vec*100, qs_asd_vecA, '-o', int_vec*100, qs_vsd_vecV, '-o', int_vec*100, qs_d_vecD, '-o','linewidth', 2)
set(gca,'FontSize',25)
title('Systemic Flow')
legend({'ASD','VSD', 'PDA'},'Location', 'east','FontSize',17) 
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Flow (L/min)')

grid on
figure(601)
plot(int_vec*100, 10.*oxy_sa_asd_vecA, '-o', int_vec*100, 10.*oxy_sa_vsd_vecV, '-o', int_vec*100, 10.*oxy_sa_d_vecD,'-o','linewidth', 2)
title('Oxygen Saturation')
legend({'ASD','VSD', 'PDA'},'Location', 'east','FontSize',17) 
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',25)
grid on

figure(602)
plot(int_vec*100, qs_asd_vecA.*oxy_sa_asd_vecA, '-o', int_vec*100, qs_vsd_vecV.*oxy_sa_vsd_vecV, '-o',int_vec*100, qs_d_vecD.*oxy_sa_d_vecD,'-o','linewidth', 2)
title('Oxygen Delivery')
legend({'ASD','VSD', 'PDA'},'Location', 'east','FontSize',17) 
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Delivery (mmol/min)')
set(gca,'FontSize',25)
grid on


toc