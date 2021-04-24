tic
clear all % clear all variables
close all  

%% set exercise flag
do_exercise = true;

%% set disease state
disease_state = true;

% ductance shunt conductance (L/min/mmHg)
jasd=7;
jvsd=8;
jd=9;
j_shunt = jd

% values for consumption, our independent variable
d_vec = 0.1
m_vec = (16.8 : 8.32 : 100)

ncase_d = length(d_vec);
ncase_dm = length(m_vec);


% oxygen saturation in systemic vein
noxy_sv_d_vecD = zeros(1,ncase_dm);

% pressure in systemic artery and pulmonary artery
npsa_d_vecD = zeros(1,ncase_dm);
nppa_d_vecD = zeros(1,ncase_dm);

% diastolic/systolic systemic artery pressure
ndpsa_d_vecD = zeros(1,ncase_dm);
nspsa_d_vecD = zeros(1,ncase_dm);

% LV and RV stroke
nLV_d_vecD = zeros(1,ncase_dm);
nRV_d_vecD = zeros(1,ncase_dm);

% HR & Rs
HR_d_vecD = zeros(1,ncase_dm);
Rs_d_vecD = zeros(1,ncase_dm);

% cardiac output
nqs_d_vecD = zeros(1,ncase_dm);

% number of cycles
num_cycles_for_mean = 5;

% first we consider the case of no shunts
%Ashunt = 0

% mean value for above variables
for iDD = 1: length(d_vec)
    Ashunt = d_vec(iDD);
    for iEE = 1:length(m_vec)
        m_set = m_vec(iEE);
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        circ;
        ns = (T/dt)*10;
        noxy_sv_d_vecD(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
        npsa_d_vecD(iEE) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        nqs_d_vecD(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        nppa_d_vecD(iEE) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
        ndpsa_d_vecD(iEE) = min(P_plot(isa,(klokmax-ns+1):klokmax));
        nspsa_d_vecD(iEE) = max(P_plot(isa,(klokmax-ns+1):klokmax));
        nLV_d_vecD(iEE) = 1000*(max(V_plot(iLV,(klokmax-ns+1):klokmax)) - min(V_plot(iLV,(klokmax-ns+1):klokmax)));
        nRV_d_vecD(iEE) = 1000*(max(V_plot(iRV,(klokmax-ns+1):klokmax)) - min(V_plot(iRV,(klokmax-ns+1):klokmax)));
        %HR_d_vecD(iEE) = HR_plot(:,klokmax)
        HR_d_vecD(iEE) = HR_set
        Rs_d_vecD(iEE) = Rs_set
    end 
end

% exercise plot
figure(900)
plot(m_vec, 10*noxy_sv_d_vecD, '-o','linewidth', 3)
set(gca,'FontSize',20)
title('Systemic vein oxgyen','FontWeight','Normal')
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
yline(0, '--b','linewidth', 2)
grid on

figure(901)
plot(m_vec, npsa_d_vecD, '-ro','linewidth', 3)
set(gca,'FontSize',20)
title('Systemic arterial pressure','FontWeight','Normal')
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Pressure (mmHg)')
xlim([16.8 100])
grid on

figure(902)
plot(m_vec, ndpsa_d_vecD, '-mo','linewidth', 3)
set(gca,'FontSize',20)
title('Diastolic SAP','FontWeight','Normal')
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Pressure (mmHg)')
xlim([16.8 100])
grid on

figure(903)
plot(m_vec, nspsa_d_vecD, '-bo','linewidth', 3)
set(gca,'FontSize',20)
title('Systolic SAP','FontWeight','Normal')
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Pressure (mmHg)')
xlim([16.8 100])
grid on

figure(904)
subplot(3,1,1),plot(m_vec, nspsa_d_vecD, '-ro','linewidth', 3)
set(gca,'FontSize',20)
title('Systemic arterial pressure','FontWeight','Normal')
legend({'systolic'},'Location', 'northeast','FontSize',15) 
legend boxoff
xlim([16.8 100])
grid on
subplot(3,1,2),plot(m_vec, npsa_d_vecD, '-mo','linewidth', 3)
set(gca,'FontSize',20)
legend({'mean'},'Location', 'northeast','FontSize',15) 
legend boxoff
ylabel('Pressure (mmHg)')
xlim([16.8 100])
grid on
subplot(3,1,3),plot(m_vec, ndpsa_d_vecD, '-bo','linewidth', 3)
set(gca,'FontSize',20)
legend({'diastolic'},'Location', 'northeast','FontSize',15) 
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
xlim([16.8 100])
grid on

figure(905)
plot(m_vec, nspsa_d_vecD, '-ro', m_vec, npsa_d_vecD, '-mo',m_vec, ndpsa_d_vecD, '-bo', 'linewidth', 3)
set(gca,'FontSize',20)
title('Systemic arterial pressure','FontWeight','Normal')
legend({'systolic', 'mean', 'diastolic'},'Location', 'best','FontSize',18) 
legend boxoff                  
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Pressure (mmHg)')
xlim([16.8 100])
grid on

figure(906)
plot(m_vec, nqs_d_vecD, '-mo','linewidth', 3)
set(gca,'FontSize',20)
title('Cardiac output','FontWeight','Normal')
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Cardiac output (L/min)')
xlim([16.8 100])
grid on

figure(907)
plot(m_vec, nLV_d_vecD, '-ro', m_vec, nRV_d_vecD, '-ro','linewidth', 3)
set(gca,'FontSize',20)
title('Stroke volume ','FontWeight','Normal')
legend({'LV & RV'},'Location', 'east','FontSize',20) 
legend boxoff                  
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Volume (mL)')
xlim([16.8 100])
grid on

figure(908)
plot(m_vec, HR_d_vecD, '-bo','linewidth', 3)
set(gca,'FontSize',25)
title('Oxygen consumption vs Heart rate','FontSize',22,'FontWeight','Normal')               
xlabel('Oxgyen consumption (mmol/min)','FontSize', 22) 
ylabel('Heart rate (beat/min)','FontSize', 22)
xlim([16.8 100])
grid on

figure(909)
plot(HR_d_vecD, Rs_d_vecD, '-ro','linewidth', 3)
set(gca,'FontSize',25)
title('Heart rate vs Systemic resistance','FontSize',22,'FontWeight','Normal')               
xlabel('Heart rate (beat/min)','FontSize', 22) 
ylabel('Systemic resistance (mmHg/(L/min)','FontSize', 22)
grid on


if (length(m_vec) > 0)
    
      Vtot = sum(V_plot, 1);      
      fprintf('\n%s %f %s\n','Total blood volume is ', Vtot(end), ' liters');
      fprintf('%s %f %s\n\n','Cardiac ouput is ', nqs_d_vecD(end), ' (L/min)');
      fprintf('%s %f %s\n','Stroke volume from LV is ', 1000*(max(V_plot(iLV,(klokmax-ns+1):klokmax)) - min(V_plot(iLV,(klokmax-ns+1):klokmax))), ' mL');
      fprintf('%s %f %s\n','Stroke volume from RV is ', 1000*(max(V_plot(iRV,(klokmax-ns+1):klokmax)) - min(V_plot(iRV,(klokmax-ns+1):klokmax))), ' mL');
      
      fprintf('%s %f %s\n','Diastolic systemic arterial pressure is ', min(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Systolic systemic arterial pressure is ', max(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Mean systemic arterial pressure is ', npsa_d_vecD(1), ' mmHg');

      fprintf('%s %f %s\n','Diastolic pulmonary arterial pressure is ', min(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n','Systolic pulmonary arterial pressure is ', max(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
      fprintf('%s %f %s\n\n','Mean pulmonary arterial pressure is ', nppa_d_vecD(1), ' mmHg');
      fprintf('%s %f %s\n','Heart rate is', HR_set, ' beat/min');
      fprintf('%s %f %s\n','Systemic resistance is', Rs_set, ' mmHg/(L/min)');
end

toc
