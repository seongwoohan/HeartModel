% The new main program and figures for asd
% variables for asd
tic
clear all % clear all variables
close all       

%% set disease state
disease_state = false;

%% set exercise flag
do_exercise = false;

% we have to set j_shunt to something...
jasd=7;
jvsd=8;
jd=9;
j_shunt = jasd
asd_vec = 0 / 100

num_cycles_for_mean = 10;

% mean value for above variables
Ashunt = 0;
circ;     
qAo_normal = meanvalue(Q_plot(jAo,:), klokmax, T, dt, num_cycles_for_mean);
qs_normal = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
qTr_normal = meanvalue(Q_plot(jTr,:), klokmax, T, dt, num_cycles_for_mean);
qPu_normal = meanvalue(Q_plot(jPu,:), klokmax, T, dt, num_cycles_for_mean);
qp_normal = meanvalue(Q_plot(jp,:), klokmax, T, dt, num_cycles_for_mean);
qMi_normal = meanvalue(Q_plot(jMi,:), klokmax, T, dt, num_cycles_for_mean);

q_normal_mean = meanvalue(Q_plot(jasd,:), klokmax, T, dt, num_cycles_for_mean);
q_normal_plus = meanvalue(max(Q_plot(jasd,:),0), klokmax, T, dt, num_cycles_for_mean);
q_normal_minus = meanvalue(min(Q_plot(jasd,:),0), klokmax, T, dt, num_cycles_for_mean);

ppa_normal = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
psa_normal = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
oxy_sa_normal = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
oxy_pa_normal = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);

ns = (T/dt)*10;
Vtot = sum(V_plot, 1);      
fprintf('\n%s %f %s\n','Total blood volume is ', Vtot(end), ' liters');
fprintf('%s %f %s\n\n','Cardiac ouput is ', qs_normal, ' (L/min)');
fprintf('%s %f %s\n','Stroke volume from LV is ', 1000*(max(V_plot(iLV,(klokmax-ns+1):klokmax)) - min(V_plot(iLV,(klokmax-ns+1):klokmax))), ' mL');
fprintf('%s %f %s\n','Stroke volume from RV is ', 1000*(max(V_plot(iRV,(klokmax-ns+1):klokmax)) - min(V_plot(iRV,(klokmax-ns+1):klokmax))), ' mL');

fprintf('%s %f %s\n','Diastolic systemic arterial pressure is ', min(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n','Systolic systemic arterial pressure is ', max(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n','Mean systemic arterial pressure is ', psa_normal, ' mmHg');

fprintf('%s %f %s\n','Diastolic pulmonary arterial pressure is ', min(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n','Systolic pulmonary arterial pressure is ', max(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n\n','Mean pulmonary arterial pressure is ', ppa_normal, ' mmHg');

     
% ASD : Flow on time dependence
% axis([xmin xmax ymin ymax])
figure(205)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jasd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 4);
title('Atrial Septal Defect','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
ylim([-3 4])
     
toc
