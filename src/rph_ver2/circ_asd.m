% The new main program and figures for asd
% variables for asd
tic
clear all % clear all variables
close all       

%% set disease state
disease_state = true;

%% set exercise flag
do_exercise = false;

% asd shunt conductance (L/min/mmHg)
jasd=7;
jvsd=8;
jd=9;
j_shunt = jasd
asd_vec = 0.1 / 100
%(0 : 0.1 : 1) / 100
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
q_asd_plus_vecA = zeros(1,ncase_asd);
q_asd_minus_vecA = zeros(1,ncase_asd);

% pressure in pulmonary artery and systemic artery 
ppa_asd_vecA = zeros(1,ncase_asd);
psa_asd_vecA = zeros(1,ncase_asd);

% oxygen saturation in pulmonary artery and systemic artery 
oxy_sa_asd_vecA = zeros(1,ncase_asd);
oxy_pa_asd_vecA = zeros(1,ncase_asd);

% minimum/maximum SA pressure and stroke volume
%psamin_asd_vecA = zeros(1, ncase_asd);
%psamax_asd_vecA = zeros(1, ncase_asd);
%sv_asd_vecA = zeros(1, ncase_asd);

num_cycles_for_mean = 10;

% mean value for above variables
for iA = 1:length(asd_vec)
    Ashunt = asd_vec(iA);
    circ;     
    qAo_asd_vecA(iA) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, num_cycles_for_mean);
    qs_asd_vecA(iA) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    qTr_asd_vecA(iA) = meanvalue(Q_plot(jTr,:), klokmax, T, dt, num_cycles_for_mean);
    qPu_asd_vecA(iA) = meanvalue(Q_plot(jPu,:), klokmax, T, dt, num_cycles_for_mean);
    qp_asd_vecA(iA) = meanvalue(Q_plot(jp,:), klokmax, T, dt, num_cycles_for_mean);
    qMi_asd_vecA(iA) = meanvalue(Q_plot(jMi,:), klokmax, T, dt, num_cycles_for_mean);
    
    q_asd_mean_vecA(iA) = meanvalue(Q_plot(jasd,:), klokmax, T, dt, num_cycles_for_mean);
    q_asd_plus_vecA(iA) = meanvalue(max(Q_plot(jasd,:),0), klokmax, T, dt, num_cycles_for_mean);
    q_asd_minus_vecA(iA) = meanvalue(min(Q_plot(jasd,:),0), klokmax, T, dt, num_cycles_for_mean);
    
    ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_pa_asd_vecA(iA) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    
    %psamin_asd_vecA(iA) = min(meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean));
    %psamax_asd_vecA(iA) = max(meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean));
    %sv_asd_vecA(iA) = meanvlaue(SV, klokmax, T, dt, num_cycles_for_mean);
end

if (length(asd_vec) > 0)

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
      
     
%{    
% ASD : shunt conductance & pressure
figure(199)
plot(asd_vec*100, ppa_asd_vecA, '-bo', asd_vec*100, psa_asd_vecA, '-ro','linewidth', 2)
set(gca,'FontSize',25)
title('Atrial Septal Defect','FontSize',22,'FontWeight','Normal')
legend({'Pulmonary Artery', 'Systemic Artery'},'Location', 'northeast','FontSize',20, 'Box','off') 
legend boxoff                  
xlabel('Shunt Area (cm^2)','FontSize', 22) 
ylabel('Pressure (mmHg)','FontSize', 22)
grid on

figure(200)
subplot(2,1,1),plot(asd_vec*100, ppa_asd_vecA, '-bo','linewidth', 2)
legend({'Pulmonary Artery'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Pressure (mmHg)')
set(gca,'FontSize',18)
grid on
subplot(2,1,2),plot(asd_vec*100, psa_asd_vecA, '-ro','linewidth', 2)
legend({'Systemic Artery'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Pressure (mmHg)')
set(gca,'FontSize',18)
grid on


% ASD : shunt conductance & shunt flow mean
figure(201)
plot(asd_vec*100, q_asd_mean_vecA, '-o', asd_vec*100, q_asd_plus_vecA, '-o', asd_vec*100, q_asd_minus_vecA, '-o','linewidth', 2)
title('Atrial Septal Defect')
legend({'Mean Flow', 'Positive Flow', 'Negative Flow'},'Location', 'northwest','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',25)
grid on

% Without semilogx
figure(202)
plot(asd_vec*100, qs_asd_vecA, '-ro','linewidth', 2)
title('Atrial Septal Defect: Systemic Artery')
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Flow (L/min)')
set(gca,'FontSize',18)
grid on
figure(203)
plot(asd_vec*100, 10.*oxy_sa_asd_vecA, '-bo','linewidth', 2)
title('Atrial Septal Defect: Oxygen Saturation')
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',18)
grid on
figure(204)
plot(asd_vec*100, qs_asd_vecA.*oxy_sa_asd_vecA, '-mo','linewidth', 2)
title('Atrial Septal Defect: Oxygen Delivery')
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Delivery (mmol/min)')
set(gca,'FontSize',18)
grid on

%}    
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
%xlim([12.4375 12.5])
% 0 on the line

%{
figure(207)
plot(asd_vec*100, psamin_asd_vecA, '-bo', asd_vec*100, psamax_asd_vecA, '-ro','linewidth', 2)
title('Atrial Septal Defect')
legend({'Minimum', 'Maximum'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Artery Pressure')
set(gca,'FontSize',18)
grid on


figure(207)
plot(asd_vec*100, psamin_asd_vecA, '-ro','linewidth', 2)
title('Atrial Septal Defect')
legend({'Minimum', 'Maximum'},'Location', 'northwest','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Systemic Artery Pressure (mmHg)')
set(gca,'FontSize',18)
grid on


figure(208)
plot(asd_vec*100, sv_asd_vecA,  '-mo','linewidth', 2)
xlabel('Shunt Area (cm^2)')
ylabel('Stroke Volume (mL)')
set(gca,'FontSize',18)
grid on


%figure(206)
%need this when calibrating data
%plot(asd_vec, qp_asd_vecA, '-bo','linewidth', 1.5); hold on;
%plot(asd_vec, qs_asd_vecA, '-mo', 'linewidth', 1.5); hold off;
%grid on
%}
     
end
        
toc
