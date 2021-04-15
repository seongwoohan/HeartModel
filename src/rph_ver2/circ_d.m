% The new main program and figures for ductance
% variables for ductance
tic
clear all % clear all variables
close all  

%% set disease state
disease_state = true;

% ductance shunt conductance (L/min/mmHg)
jasd=7;
jvsd=8;
jd=9;
j_shunt = jd
d_vec = (0 : 0.1 : 1) / 100
% (0 : 0.1 : 1) / 100
% 0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01


ncase_d = length(d_vec);

% each flow of interest
qAo_d_vecD = zeros(1,ncase_d);
qs_d_vecD = zeros(1,ncase_d);
qTr_d_vecD = zeros(1,ncase_d);
qPu_d_vecD = zeros(1,ncase_d);
qp_d_vecD = zeros(1,ncase_d);
qMi_d_vecD = zeros(1,ncase_d);

% shunt flow mean
q_d_mean_vecD = zeros(1,ncase_d);
q_d_plus_vecD = zeros(1,ncase_d);
q_d_minus_vecD = zeros(1,ncase_d);

% pressure in pulmonary artery and systemic artery 
ppa_d_vecD = zeros(1,ncase_d);
psa_d_vecD = zeros(1,ncase_d);

% oxygen saturation in pulmonary artery and systemic artery
oxy_sa_d_vecD = zeros(1,ncase_d);
oxy_pa_d_vecD = zeros(1,ncase_d);

num_cycles_for_mean = 5;

% mean value for above variables
for iDD = 1:length(d_vec)
    Ashunt = d_vec(iDD);
    circ; 
    qAo_d_vecD(iDD) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, num_cycles_for_mean);
    qs_d_vecD(iDD) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    qTr_d_vecD(iDD) = meanvalue(Q_plot(jTr,:), klokmax, T, dt, num_cycles_for_mean);
    qPu_d_vecD(iDD) = meanvalue(Q_plot(jPu,:), klokmax, T, dt, num_cycles_for_mean);
    qp_d_vecD(iDD) = meanvalue(Q_plot(jp,:), klokmax, T, dt, num_cycles_for_mean);
    qMi_d_vecD(iDD) = meanvalue(Q_plot(jMi,:), klokmax, T, dt, num_cycles_for_mean);
    
    q_d_mean_vecD(iDD) = meanvalue(Q_plot(jd,:), klokmax, T, dt, num_cycles_for_mean);
    q_d_plus_vecD(iDD) = meanvalue(max(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
    q_d_minus_vecD(iDD) = meanvalue(min(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);

    ppa_d_vecD(iDD) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
    psa_d_vecD(iDD) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_sa_d_vecD(iDD) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
    oxy_pa_d_vecD(iDD) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
end 

if (length(d_vec) > 0)


figure(1000)
plot(t_plot, 10.*O2_plot,'linewidth',3)
id = legend('LV','SA','SV','RV','PA','PV')
xlabel('Time (min)') 
ylabel('O2')
set(gca,'FontSize',18)

figure(1001)
plot(t_plot, 10.*O2_plot(iLV,:),'linewidth',3)
xlabel('Time (min)') 
ylabel('O2 in left ventricle')
id = legend('LV')
set(gca,'FontSize',18)

figure(1002)
plot(t_plot, total_oxy_amt_plot,'linewidth',3)
xlabel('Time (min)') 
ylabel('Total oxygen amount')
set(gca,'FontSize',18)

figure(1003)
plot(t_plot, O2_amt_plot,'linewidth',3)
id = legend('LV','SA','SV','RV','PA','PV')
xlabel('Time (min)') 
ylabel('O2 amount')
set(gca,'FontSize',18)

figure(1004)
plot(t_plot, V_plot,'linewidth',3)
id = legend('LV','SA','SV','RV','PA','PV')
xlabel('Time (min)') 
ylabel('Volume')
set(gca,'FontSize',18)
%}
figure(404)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 4);
title('Potts Shunt','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
xlim([12.4375 12.5])
ylim([0 8])
yline(0, '--b','linewidth', 2)


% Ductus : shunt conductance & pressure
figure(400)
plot(d_vec*100, ppa_d_vecD, '-bo', d_vec*100, psa_d_vecD, '-ro','linewidth', 4)
set(gca,'FontSize',23)
title('Potts Shunt','FontSize', 22, 'FontWeight', 'Normal')
legend({'Pulmonary Artery', 'Systemic Artery'},'Location', 'east','FontSize',18) 
legend boxoff
xlabel('Shunt Area (cm^2)','FontSize', 22)
ylabel('Pressure (mmHg)','FontSize', 22)
grid on


%{
figure(300)
plot(d_vec*100, ppa_vsd_vecD, '-o', d_vec*100, psa_vsd_vecD, '-o','linewidth', 4)
set(gca,'FontSize',25)
title('Ventricular Septal Defect')
legend({'Pulmonary Artery','Systemic Artery'},'Location', 'northeast','FontSize',18) 
legend boxoff
xlabel('Shunt Area (cm^2)','FontSize', 22) 
ylabel('Pressure (mmHg)','FontSize', 22)
grid on
%}
% Ductus : shunt conductance & shunt flow mean
figure(401)
plot(d_vec*100, q_d_mean_vecD,'-o',d_vec*100, q_d_plus_vecD,'-o', d_vec*100, q_d_minus_vecD,'-o','linewidth', 2)
title('Potts Shunt')
legend({'Overall Flow', 'Positive Flow', 'Negative Flow'},'Location', 'east','FontSize',25) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',25)
grid on

figure(402)
subplot(3,1,1),plot(d_vec*100, q_d_mean_vecD,'-bo','linewidth', 2)
title('Potts Shunt')
legend({'Overall Flow'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,2),plot(d_vec*100, q_d_plus_vecD,'r-o','linewidth', 2)
legend({'Positive Flow'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,3),plot(d_vec*100, q_d_minus_vecD,'-yo','linewidth', 2)
legend({'Negative Flow'},'Location', 'northeast','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Shunt Flow Mean (L/min)')
set(gca,'FontSize',18)
grid on

% Ductus : shunt conductance & oxygen saturation 
% Without semilogx 
figure(410)
plot(d_vec*100, qs_d_vecD, '-ro','linewidth', 2)
title('Potts Shunt: Systemic Artery')
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Flow (L/min)')
set(gca,'FontSize',18)
grid on
figure(411)
plot(d_vec*100, 10.*oxy_sa_d_vecD, '-bo','linewidth', 2)
title('Potts Shunt: Oxygen Saturation')
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',18)
grid on
figure(412)
plot(d_vec*100, qs_d_vecD.*oxy_sa_d_vecD, '-mo','linewidth', 2)
title('Potts Shunt: Oxygen Delivery')
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Delivery (mmol/min)')
set(gca,'FontSize',18)
grid on

% Ductus : Flow on time dependence
figure(404)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
title('Potts Shunt Flow')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
ylim([0 8])
yline(0, '--b','linewidth', 2)
%draw a line on the 0 

figure(406)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jAo,((klokmax-((T/dt)*10)+1):klokmax)),t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5)
%title('Aortic Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 50])

%figure(407)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jTr,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
%title('Tricuspid Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 30])

%figure(408)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jPu,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
%title('Pulmonic Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 60])

%figure(409)
%plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jMi,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 1.5);
%title('Mitral Valve Flow','FontSize',18,'FontWeight','bold')
%xlabel('Time (min)','FontSize',15,'FontWeight','bold') 
%ylabel('Blood Flow (L)','FontSize',15,'FontWeight','bold')
%ylim([0 25])

%}

end
toc
