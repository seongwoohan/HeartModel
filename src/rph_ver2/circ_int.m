tic
clear all % clear all variables
close all  

jasd=7;
jvsd=8;
jd=9;

int_vec = 0.3
m_vec = 50.8%(16.8 : 16.64 : 100);

%% set disease state
disease_state = true;

%% set exercise flag
do_exercise = true;

%% set disease_pre flag
disease_state_pre = false;

%% set rp flag
Rp_state = false

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

num_cycles_for_mean = 5;

% mean value for above variables
for iA = 1:length(int_vec)
    j_shunt = jasd
    Ashunt = int_vec(iA);
    for iEE = 1:length(m_vec)
        m_set = m_vec(iEE);
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        circ;     
        qs_asd_vecA(iA) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
        psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        oxy_pa_asd_vecA(iA) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    end
end

for iV = 1:length(int_vec)
    j_shunt = jvsd
    Ashunt = int_vec(iV);
    for iEE = 1:length(m_vec)
        m_set = m_vec(iEE);
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        circ; 
        qs_vsd_vecV(iV) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        ppa_vsd_vecV(iV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
        psa_vsd_vecV(iV) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        oxy_sa_vsd_vecV(iV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        oxy_pa_vsd_vecV(iV) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    end
end 

for iDD = 1:length(int_vec)
    j_shunt = jd
    Ashunt = int_vec(iDD);
    for iEE = 1:length(m_vec)
        m_set = m_vec(iEE);
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        circ; 
        qs_d_vecD(iDD) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        ppa_d_vecD(iDD) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
        psa_d_vecD(iDD) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        oxy_sa_d_vecD(iDD) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        oxy_pa_d_vecD(iDD) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    end
end 
%, int_vec*100, qs_vsd_vecV, int_vec*100, qs_d_vecD

if (length(int_vec) > 0)

      ns = (T/dt)*10;
      Vtot = sum(V_plot, 1);      
      fprintf('\n%s %f %s\n','Total blood volume is ', Vtot(end), ' liters');
      fprintf('%s %f %s\n\n','Cardiac ouput is ', qs_asd_vecA(end), ' (L/min)');
      fprintf('%s %f %s\n','Stroke volume from LV is ', 1000*(max(V_plot(iLV,(klokmax-ns+1):klokmax)) - min(V_plot(iLV,(klokmax-ns+1):klokmax))), ' mL');
      fprintf('%s %f %s\n','Stroke volume from RV is ', 1000*(max(V_plot(iRV,(klokmax-ns+1):klokmax)) - min(V_plot(iRV,(klokmax-ns+1):klokmax))), ' mL');
      
      fprintf('%s %f %s\n','Diastolic systemic arterial pressure is ', min(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Systolic systemic arterial pressure is ', max(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Mean systemic arterial pressure is ', psa_asd_vecA(1), ' mmHg');

      fprintf('%s %f %s\n','Diastolic pulmonary arterial pressure is ', min(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Systolic pulmonary arterial pressure is ', max(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n\n','Mean pulmonary arterial pressure is ', ppa_asd_vecA(1), ' mmHg');
 
      
figure(1006)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 2.5);
title('Potts Shunt Flow','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
%ylim([-2 10])
yline(0, '--b','linewidth', 2)

figure(1007)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 2.5);
set(gca,'FontSize',23)
title('Ventricular Septal Defect','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
%xlim([12.4375 12.5])
%ylim([-4 8])

figure(500)
plot(int_vec*100, ppa_asd_vecA, '-o', int_vec*100, ppa_vsd_vecV, '-o', int_vec*100, ppa_d_vecD, '-o','linewidth', 4)
set(gca,'FontSize',25)
title('Pulmonary Artery Pressure','FontSize',22,'FontWeight','Normal')
legend({'ASD','VSD','Potts Shunt'},'Location', 'best','FontSize',18) 
legend boxoff                  
xlabel('Shunt Area (cm^2)','FontSize', 22) 
ylabel('Pressure (mmHg)','FontSize', 22)
grid on

figure(501)
plot(int_vec*100, psa_asd_vecA, '-o', int_vec*100, psa_vsd_vecV, '-o', int_vec*100, psa_d_vecD, '-o','linewidth', 4)
set(gca,'FontSize',25)
title('Systemic Artery Pressure','FontSize', 22,'FontWeight','Normal')
legend({'ASD','VSD','Potts Shunt'},'Location', 'best','FontSize',18) 
legend boxoff 
xlabel('Shunt Area (cm^2)','FontSize', 22) 
ylabel('Pressure (mmHg)','FontSize', 22)
grid on


figure(600)
plot(int_vec*100, qs_asd_vecA, '-o', int_vec*100, qs_vsd_vecV, '-o', int_vec*100, qs_d_vecD, '-o','linewidth', 4)
title('Systemic Flow','FontWeight','Normal')
legend({'ASD','VSD', 'Potts Shunt'},'Location', 'best','FontSize',17, 'Box','off') 
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Flow (L/min)')
set(gca,'FontSize',20)
grid on

figure(601)
plot(int_vec*100, 10.*oxy_sa_asd_vecA, '-o', int_vec*100, 10.*oxy_sa_vsd_vecV, '-o', int_vec*100, 10.*oxy_sa_d_vecD,'-o','linewidth', 4)
title('Oxygen Saturation','FontWeight','Normal')
legend({'ASD','VSD', 'Potts Shunt'},'Location', 'best','FontSize',17, 'Box','off') 
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',20)
grid on

figure(602)
plot(int_vec*100, qs_asd_vecA.*oxy_sa_asd_vecA, '-o', int_vec*100, qs_vsd_vecV.*oxy_sa_vsd_vecV, '-o',int_vec*100, qs_d_vecD.*oxy_sa_d_vecD,'-o','linewidth', 4)
title('Oxygen Delivery','FontWeight','Normal')
legend({'ASD','VSD', 'Potts Shunt'},'Location', 'best','FontSize',17, 'Box','off') 
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Delivery (mmol/min)')
set(gca,'FontSize',20)
grid on

end

toc
