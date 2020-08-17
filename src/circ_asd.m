% The new main program and figures for asd
% variables for asd

clear all % clear all variables
close all       

% asd shunt conductance (L/min/mmHg)
jasd=7;
jvsd=8;
jd=9;
j_shunt = jasd
asd_vec = (0 : 0.1 : 1) / 100. % dm2
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

% mean value for above variables
for iA = 1:length(asd_vec)
    Ashunt = asd_vec(iA);
    circ;     
    qAo_asd_vecA(iA) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, 10);
    qs_asd_vecA(iA) = meanvalue(Q_plot(js,:), klokmax, T, dt, 10);
    qTr_asd_vecA(iA) = meanvalue(Q_plot(jTr,:), klokmax, T, dt, 10);
    qPu_asd_vecA(iA) = meanvalue(Q_plot(jPu,:), klokmax, T, dt, 10);
    qp_asd_vecA(iA) = meanvalue(Q_plot(jp,:), klokmax, T, dt, 10);
    qMi_asd_vecA(iA) = meanvalue(Q_plot(jMi,:), klokmax, T, dt, 10);
    
    q_asd_mean_vecA(iA) = meanvalue(Q_plot(jasd,:), klokmax, T, dt, 10);
    q_asd_plus_vecA(iA) = meanvalue(max(Q_plot(jasd,:),0), klokmax, T, dt, 10);
    q_asd_minus_vecA(iA) = meanvalue(min(Q_plot(jasd,:),0), klokmax, T, dt, 10);
    
    ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_pa_asd_vecA(iA) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, 10);
end

if (length(asd_vec) > 0)

% ASD : shunt conductance & pressure
figure(200)
subplot(3,1,1),plot(asd_vec*100, ppa_asd_vecA, '-o', asd_vec*100, psa_asd_vecA, '-o','linewidth', 2)
title('Atrial Septal Defect')
legend({'Pulmonary Artery', 'Systemic Artery'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Pressure (mmHg)')
set(gca,'FontSize',18)
grid on
subplot(3,1,2),plot(asd_vec*100, ppa_asd_vecA, '-bo','linewidth', 2)
legend({'Pulmonary Artery'},'Location', 'east','FontSize',20) 
xlabel('Shunt Area (cm^2)')
ylabel('Pressure (mmHg)')
set(gca,'FontSize',18)
grid on
subplot(3,1,3),plot(asd_vec*100, psa_asd_vecA, '-ro','linewidth', 2)
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
subplot(3,1,1),plot(asd_vec*100, qs_asd_vecA, '-ro','linewidth', 2)
title('Atrial Septal Defect: Systemic Artery')
xlabel('Shunt Area (cm^2)') 
ylabel('Systemic Flow (L/min)')
set(gca,'FontSize',18)
grid on
subplot(3,1,2),plot(asd_vec*100, 10.*oxy_sa_asd_vecA, '-bo','linewidth', 2)
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Saturation (%)')
set(gca,'FontSize',18)
grid on
subplot(3,1,3),plot(asd_vec*100, qs_asd_vecA.*oxy_sa_asd_vecA, '-mo','linewidth', 2)
xlabel('Shunt Area (cm^2)') 
ylabel('Oxygen Delivery (mmol/min)')
set(gca,'FontSize',18)
grid on

% ASD : Flow on time dependence
% axis([xmin xmax ymin ymax])
figure(203)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jasd,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 2);
title('Atrial Septal Defect Shunt Flow')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
ylim([-1.5 1.5])
% 0 on the line

%figure(206)
%need this when calibrating data
%plot(asd_vec, qp_asd_vecA, '-bo','linewidth', 1.5); hold on;
%plot(asd_vec, qs_asd_vecA, '-mo', 'linewidth', 1.5); hold off;
%grid on

end
