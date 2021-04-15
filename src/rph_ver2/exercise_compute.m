tic
clear all % clear all variables
close all  

% ductance shunt conductance (L/min/mmHg)
jasd=7;
jvsd=8;
jd=9;
j_shunt = jd

m_vec = 16.8%(16.8 : 8.32 : 100)
% (16.8 : 8.32 : 100)

ncase_dm = length(m_vec);

% oxygen saturation in systemic vein
oxy_sv_d_vecD = zeros(1,ncase_dm);

% pressure in systemic artery and pulmonary artery
psa_d_vecD = zeros(1,ncase_dm);
ppa_d_vecD = zeros(1,ncase_dm);

% each flow of interest 
qs_d_vecD = zeros(1,ncase_dm);

% number of cycles
num_cycles_for_mean = 5;

Ashunt = 0

% mean value for above variables
for iEE = 1:length(m_vec)
    m_set = m_vec(iEE)
    HR_set = 0.94 * (m_set - 16.8) + 80
    %Rs_set = 100 ./ (0.07 * HR_set)
    Rs_set = (17.5 * 80)/HR_set
    circ;
    oxy_sv_d_vecD(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
    psa_d_vecD(iEE) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    qs_d_vecD(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    ppa_d_vecD(iEE) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
end 

% exercise plot
figure(900)
plot(m_vec, 10*oxy_sv_d_vecD, '-bo','linewidth', 3)
title('Systemic vein oxgyen','FontWeight','Normal')
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',15)
grid on

figure(901)
plot(m_vec, psa_d_vecD, '-ro','linewidth', 3)
title('Systemic arterial pressure','FontWeight','Normal')
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Pressure (mmHg)')
set(gca,'FontSize',15)
grid on

figure(902)
plot(m_vec, qs_d_vecD, '-mo','linewidth', 3)
title('Cardiac output','FontWeight','Normal')
xlabel('Shunt Area (cm^2)')
ylabel('Pressure (mmHg)')
set(gca,'FontSize',15)
grid on

figure(903)
plot(m_vec, HR_set, '-bo','linewidth', 3)

figure(904)
plot(HR_set, Rs_set, '-ro','linewidth', 3)

if (length(m_vec) > 0)
    
      ns = (T/dt)*10;
      Vtot = sum(V_plot, 1);      
      fprintf('\n%s %f %s\n','Total blood volume is ', Vtot(end), ' liters');
      fprintf('%s %f %s\n\n','Cardiac ouput is ', qs_d_vecD(end), ' (L/min)');
      fprintf('%s %f %s\n','Stroke volume from LV is ', 1000*(max(V_plot(iLV,(klokmax-ns+1):klokmax)) - min(V_plot(iLV,(klokmax-ns+1):klokmax))), ' mL');
      fprintf('%s %f %s\n','Stroke volume from RV is ', 1000*(max(V_plot(iRV,(klokmax-ns+1):klokmax)) - min(V_plot(iRV,(klokmax-ns+1):klokmax))), ' mL');
      
      fprintf('%s %f %s\n','Diastolic systemic arterial pressure is ', min(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Systolic systemic arterial pressure is ', max(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Mean systemic arterial pressure is ', psa_d_vecD(1), ' mmHg');

      fprintf('%s %f %s\n','Diastolic pulmonary arterial pressure is ', min(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Systolic pulmonary arterial pressure is ', max(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n\n','Mean pulmonary arterial pressure is ', ppa_d_vecD(1), ' mmHg');

end

toc
