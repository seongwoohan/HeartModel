% The new main program and figures for vsd
% variables for vsd
tic
clear all % clear all variables
close all       

% vsd shunt conductance (L/min/mmHg)
jasd=7;
jvsd=8;
jd=9;
j_shunt = jvsd
vsd_vec = (0 : 0.1 : 1) / 100
% (0 : 0.1 : 1) / 100
% 0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01

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

num_cycles_for_mean = 5;

% mean value for above variables
for iV = 1:length(vsd_vec)
    Ashunt = vsd_vec(iV);
    circ;
    qAo_vsd_vecV(iV) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, num_cycles_for_mean);
    qs_vsd_vecV(iV) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    qTr_vsd_vecV(iV) = meanvalue(Q_plot(jTr,:), klokmax, T, dt, num_cycles_for_mean);
    qPu_vsd_vecV(iV) = meanvalue(Q_plot(jPu,:), klokmax, T, dt, num_cycles_for_mean);
    qp_vsd_vecV(iV) = meanvalue(Q_plot(jp,:), klokmax, T, dt, num_cycles_for_mean);
    qMi_vsd_vecV(iV) = meanvalue(Q_plot(jMi,:), klokmax, T, dt, num_cycles_for_mean);
    
    q_vsd_mean_vecV(iV) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean);
    q_vsd_plus_vecV(iV) = meanvalue(max(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
    q_vsd_minus_vecV(iV) = meanvalue(min(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
    
    ppa_vsd_vecV(iV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    psa_vsd_vecV(iV) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_sa_vsd_vecV(iV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_pa_vsd_vecV(iV) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
end 

if (length(vsd_vec) > 0)

figure(8)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 4);
set(gca,'FontSize',23)
title('Ventricular Septal Defect','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
xlim([12.4375 12.5])
ylim([0 7])


% VSD : shunt conductance & pressure
figure(300)
plot(vsd_vec*100, ppa_vsd_vecV, '-bo', vsd_vec*100, psa_vsd_vecV, '-ro','linewidth', 4)
set(gca,'FontSize',23)
title('Ventricular Septal Defect','FontSize', 22, 'FontWeight', 'Normal')
legend({'Pulmonary Artery','Systemic Artery'},'Location', 'northeast','FontSize',18) 
legend boxoff
xlabel('Shunt Area (cm^2)','FontSize', 22) 
ylabel('Pressure (mmHg)','FontSize', 22)
grid on



% VSD : shunt conductance & shunt flow mean
figure(301)
plot(vsd_vec*100, q_vsd_mean_vecV, '-o',vsd_vec*100, q_vsd_plus_vecV,'-o', vsd_vec*100, q_vsd_minus_vecV, '-o','linewidth', 2)
title('Ventricular Septal Defect')
legend({'Overall Flow', 'Positive Flow', 'Negative Flow'},'Location', 'east','FontSize',25) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',25)
grid on

figure(302)
subplot(3,1,1),plot(vsd_vec*100, q_vsd_mean_vecV, '-ro','linewidth', 2)
title('Ventricular Septal Defect')
legend({'Overall Flow'},'Location', 'east','FontSize',18) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,2),plot(vsd_vec*100, q_vsd_plus_vecV,'-bo','linewidth', 2)
legend({'Positive Flow'},'Location', 'east','FontSize',18) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,3),plot(vsd_vec*100, q_vsd_minus_vecV, '-yo','linewidth', 2)
legend({'Negative Flow'},'Location', 'east','FontSize',18) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on

% VSD : shunt conductance & oxygen saturation
% Without semilogx
figure(303)
plot(vsd_vec*100, qs_vsd_vecV, '-ro','linewidth', 2)
title('Ventricular Septal Defect: Systemic Artery')
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Flow (L/min)')
set(gca,'FontSize',18)
grid on
figure(304)
plot(vsd_vec*100, 10.*oxy_sa_vsd_vecV, '-bo','linewidth', 2)
title('Ventricular Septal Defect: Oxygen Saturation')
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',18)
grid on
figure(305)
plot(vsd_vec*100, qs_vsd_vecV.*oxy_sa_vsd_vecV, '-mo','linewidth', 2)
title('Ventricular Septal Defect: Oxygen Delivery')
xlabel('Shunt Area (cm^2)')
ylabel('Oxygen Delivery (mmol/min)')
set(gca,'FontSize',18)
grid on



% explain 0 part
figure(306)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jAo,((klokmax-((T/dt)*10)+1):klokmax)),t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5)

figure(307)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax),P_plot([iLV,iRV],(klokmax-((T/dt)*10)+1):klokmax))

%figure(305)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Gshuntf_plot((klokmax-((T/dt)*10)+1):klokmax),t_plot((klokmax-((T/dt)*10)+1):klokmax), Gshuntr_plot((klokmax-((T/dt)*10)+1):klokmax))

%figure(306)
%plot(t_plot,P_plot(iLV,:), t_plot, P_plot(iRV,:)) 
%yline(0, '--b','linewidth', 2)

% draw a line on the 0 
% ylim([-110 60])
%}

end
toc