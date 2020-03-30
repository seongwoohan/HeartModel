%The new main program

clear all % clear all variables
close all       % and figures

asd_vec = []%0 10 100 500 800 1000 2000 3000 5000 10000]
vsd_vec = []%0 0.5 3.5 5 7 10 13 16 20 30 50 70 80 100 500 800 1000]% 1500 3000]
d_vec = [] % 0 0.1 0.3 0.5 0.7 1 3 4 6 10 30 50 70 100 500 1000

% asd
ncase_asd = length(asd_vec);
qAo_asd_vecA = zeros(1,ncase_asd);
q_asd_vecA = zeros(1,ncase_asd);
ppa_asd_vecA = zeros(1,ncase_asd);
psa_asd_vecA = zeros(1,ncase_asd);
oxy_sa_asd_vecA = zeros(1,ncase_asd);
oxy_sv_asd_vecA = zeros(1,ncase_asd);

% vsd
ncase_vsd = length(vsd_vec);
qAo_vsd_vecV = zeros(1,ncase_vsd);
q_vsd_vecV = zeros(1,ncase_vsd);
ppa_vsd_vecV = zeros(1,ncase_vsd);
psa_vsd_vecV = zeros(1,ncase_vsd);
oxy_sa_vsd_vecV = zeros(1,ncase_vsd);
oxy_sv_vsd_vecV = zeros(1,ncase_vsd);

% ductus
ncase_d = length(d_vec);
qAo_d_vecD = zeros(1,ncase_d);
q_d_vecD = zeros(1,ncase_d);
ppa_d_vecD = zeros(1,ncase_d);
psa_d_vecD = zeros(1,ncase_d);
oxy_sa_d_vecD = zeros(1,ncase_d);
oxy_sv_d_vecD = zeros(1,ncase_d);

%atrium conneciton & pulmonary and systemic artery pressure
for iA = 1:length(asd_vec)
    asd = asd_vec(iA);
    vsd=0; 
    d=0;
    circ;    
    q_asd_vecA(iA) = meanvalue(Q_plot(jasd,:), klokmax, T, dt, 10);
    qAo_asd_vecA(iA) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, 10);	
    ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    % oxygen for sa & sv
    oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_sv_asd_vecA(iA) = meanvalue(O2_plot(isv,:), klokmax, T, dt, 10);
end

%ventricle conneciton & pulmonary and systemic artery pressure
for iV = 1:length(vsd_vec)
    vsd = vsd_vec(iV);
    asd=0;
    d=0;
    circ;
    q_vsd_vecV(iV) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, 10);
    qAo_vsd_vecV(iV) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, 10);
    ppa_vsd_vecV(iV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_vsd_vecV(iV) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    % oxygen for sa & sv
    oxy_sa_vsd_vecV(iV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_sv_vsd_vecV(iV) = meanvalue(O2_plot(isv,:), klokmax, T, dt, 10);
end 

%aorta conneciton & pulmonary and systemic artery pressure
for iDD = 1:length(d_vec)
    d = d_vec(iDD);
    asd=0;
    vsd=0;
    circ;  
    qAo_d_vecD(iDD) = meanvalue(Q_plot(jAo,:), klokmax, T, dt, 10);
    q_d_vecD(iDD) = meanvalue(Q_plot(jd,:), klokmax, T, dt, 10);
    ppa_d_vecD(iDD) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_d_vecD(iDD) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
    % oxygen for sa & sv
    oxy_sa_d_vecD(iDD) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
    oxy_sv_d_vecD(iDD) = meanvalue(O2_plot(isv,:), klokmax, T, dt, 10);
end 

if(length(asd_vec) > 0)

figure(201)
plot(q_asd_vecA, ppa_asd_vecA, '-ro', q_asd_vecA, psa_asd_vecA, '-bs')
legend({'Pulmonary artery P','Systemic artery P'},'Location', 'east') 
xlabel('Shunt Flow Mean') 
ylabel('Pressure')

% asd comparison with systemic artery
figure(202)
subplot(2,1,1),plot(q_asd_vecA, ppa_asd_vecA, '-ro','linewidth', 1.5)
title('Atrial Septal Defect','FontSize',16,'FontWeight','bold')
legend({'Pulmonary Artery Pressure'},'Location', 'northwest') 
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold')
ylabel('Pressure (mmHg)','FontSize',10,'FontWeight','bold')
grid on
subplot(2,1,2),plot(q_asd_vecA, 10.*oxy_sa_asd_vecA, '-m*','linewidth', 1.5)
legend({'Systemic Artery Pressure'},'Location', 'west') 
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold')
ylabel('Oxygen Saturation (%)','FontSize',10,'FontWeight','bold')
grid on

% asd comparison with systemic artery
figure(203)
subplot(2,1,1),plot(q_asd_vecA, psa_asd_vecA, '-bs','linewidth', 1.5)
title('Atrial Septal Defect','FontSize',16,'FontWeight','bold')
legend({'Systemic Artery Pressure'},'Location', 'northeast') 
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold') 
ylabel('Pressure (mmHg)','FontSize',10,'FontWeight','bold')
grid on
subplot(2,1,2),plot(q_asd_vecA, 10.*oxy_sa_asd_vecA, '-m*','linewidth', 1.5)
legend({'Systemic Artery Pressure'},'Location', 'west') 
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',10,'FontWeight','bold')
grid on

% asd comparison with systemic vein
figure(204)
subplot(2,1,1),plot(q_asd_vecA, ppa_asd_vecA, '-ro')
title('Atrium Shunt Flow in Pulmonary Artery Pressure')
xlabel('Shunt Flow Mean') 
ylabel('Pressure')
subplot(2,1,2),plot(q_asd_vecA, 10.*oxy_sv_asd_vecA, '-m*','linewidth', 2)
title('Atrium Shunt Flow vs Oxygen Saturation for Systemic Vein')
xlabel('Shunt Flow Mean') 
ylabel('Oxygen Saturation (%)')

% asd comparison with systemic vein
figure(205)
subplot(2,1,1),plot(q_asd_vecA, psa_asd_vecA, '-bs')
title('Atrium Shunt Flow in Systemic Artery Pressure')
xlabel('Shunt Flow Mean') 
ylabel('Pressure')
subplot(2,1,2),plot(q_asd_vecA, 10.*oxy_sv_asd_vecA, '-m*','linewidth', 2)
title('Atrium Shunt Flow vs Oxygen Saturation for Systemic Vein')
xlabel('Shunt Flow Mean') 
ylabel('Oxygen Saturation (%)')

figure(206)
subplot(3,1,1),semilogx(asd_vec, qAo_asd_vecA, '-ro','linewidth', 1.5)
title('ASD: Systemic Artery','FontSize',16,'FontWeight','bold')
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('Cardiac Output (L/min)','FontSize',10,'FontWeight','bold')
grid on
subplot(3,1,2),semilogx(asd_vec, 10.*oxy_sa_asd_vecA, '-bo','linewidth', 1.5)
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('O2 Saturation (%)','FontSize',10,'FontWeight','bold')
grid on
subplot(3,1,3),semilogx(asd_vec, qAo_asd_vecA.*oxy_sa_asd_vecA, '-mo','linewidth', 1.5)
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',10,'FontWeight','bold')
grid on

end

if(length(vsd_vec) > 0)

% vsd comparison with systemic artery
figure(301)
subplot(2,1,1),plot(q_vsd_vecV, ppa_vsd_vecV, '-ro', q_vsd_vecV, psa_vsd_vecV, '-bo','linewidth', 1.5)
title('Ventricular Septal Defect','FontSize',16,'FontWeight','bold')
legend({'Pulmonary Artery Pressure','Systemic Artery Pressure'},'Location', 'northeast') 
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold') 
ylabel('Pressure (mmHg)','FontSize',10,'FontWeight','bold')
grid on
subplot(2,1,2),plot(q_vsd_vecV, 10.*oxy_sa_vsd_vecV, '-mo','linewidth', 1.5)
legend({'Systemic Artery Pressure'},'Location', 'northeast') 
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',10,'FontWeight','bold')
grid on

% vsd comparison with systemic vein
figure(302)
subplot(2,1,1),plot(q_vsd_vecV, ppa_vsd_vecV, '-ro', q_vsd_vecV, psa_vsd_vecV, '-bs')
title('Ventricular Septal Defect')
legend({'Pulmonary Artery Pressure','Systemic Artery Pressure'},'Location', 'northeast') 
xlabel('Shunt Flow Mean') 
ylabel('Pressure (mmHg)')
grid on
subplot(2,1,2),plot(q_vsd_vecV, 10.*oxy_sv_vsd_vecV, '-m*','linewidth', 2)
xlabel('Shunt Flow Mean') 
title('Ventricle Shunt Flow vs Oxygen Saturation for Systemic Vein')
ylabel('Oxygen Saturation (%)')
grid on

% oxygen delivery = cardiac ouput * oxygen concentration 
figure(303)
subplot(3,1,1),semilogx(vsd_vec, qAo_vsd_vecV, '-ro','linewidth', 1.5)
title('VSD: Systemic Artery','FontSize',16,'FontWeight','bold')
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('Caridac Output (L/min)','FontSize',10,'FontWeight','bold')
grid on
subplot(3,1,2),semilogx(vsd_vec, 10.*oxy_sa_vsd_vecV, '-bo','linewidth', 1.5)
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('O2 Saturation (%)','FontSize',10,'FontWeight','bold')
grid on
subplot(3,1,3),semilogx(vsd_vec, qAo_vsd_vecV.*oxy_sa_vsd_vecV, '-mo','linewidth', 1.5)
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',10,'FontWeight','bold')
grid on

end


if (length(d_vec) > 0)

% ductus comparison with systemic artery
figure(401)
subplot(2,1,1),plot(q_d_vecD, ppa_d_vecD, '-ro', q_d_vecD, psa_d_vecD, '-bo','linewidth', 1.2)
title('Patent Ductus Arteriosus','FontSize',16,'FontWeight','bold')
legend({'Pulmonary Artery Pressure','Systemic Artery Pressure'},'Location', 'northeast') 
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold') 
ylabel('Pressure (mmHg)','FontSize',10,'FontWeight','bold')
grid on
subplot(2,1,2),plot(q_d_vecD, 10.*oxy_sa_d_vecD, '-mo','linewidth', 1.2)
legend({'Systemic Artery Pressure'},'Location', 'northeast')
xlabel('Shunt Flow Mean','FontSize',10,'FontWeight','bold') 
ylabel('Oxygen Saturation (%)','FontSize',10,'FontWeight','bold')
grid on

% ductus comparison with systemic vein
figure(402)
subplot(2,1,1),plot(q_d_vecD, ppa_d_vecD, '-ro', q_d_vecD, psa_d_vecD, '-bs')
title('Ductus Arteriosus')
legend({'Pulmonary Artery Pressure','Systemic Artery Pressure'},'Location', 'northeast') 
xlabel('Shunt Flow Mean') 
ylabel('Pressure')
grid on
subplot(2,1,2),plot(q_d_vecD, 10.*oxy_sv_d_vecD, '-m*','linewidth', 2)
xlabel('Shunt Flow Mean') 
ylabel('Oxygen Saturation (%)')
grid on

% oxygen delivery = cardiac ouput * oxygen concentration 
figure(403)
subplot(3,1,1),semilogx(d_vec, qAo_d_vecD, '-ro','linewidth', 1.5)
title('Ductus: Systemic Artery','FontSize',16,'FontWeight','bold')
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('Cardiac Output (L/min)','FontSize',10,'FontWeight','bold')
grid on
subplot(3,1,2),semilogx(d_vec, 10.*oxy_sa_d_vecD, '-bo','linewidth', 1.5)
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('O2 Saturation (%)','FontSize',10,'FontWeight','bold')
grid on
subplot(3,1,3),semilogx(d_vec, qAo_d_vecD.*oxy_sa_d_vecD, '-mo','linewidth', 1.5)
xlabel('Shunt Size','FontSize',10,'FontWeight','bold') 
ylabel('Oxygen Delivery (mmol/min)','FontSize',10,'FontWeight','bold')
grid on

end
