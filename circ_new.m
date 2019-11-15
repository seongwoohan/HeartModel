%The new main program

clear all % clear all variables
close all       % and figures

asd_vec = [0 ] % 0 10 100 1000 10000
vsd_vec = [0 ] % 0 50 100 1000 10000
d_vec = [0 3 4 6 10 100] % 0 10 100 1000 10000

ncase = 5;
q_asd_vecA = zeros(1,ncase);
ppa_asd_vecA = zeros(1,ncase);
psa_asd_vecA = zeros(1,ncase);

q_vsd_vecV = zeros(1,ncase);
ppa_vsd_vecV = zeros(1,ncase);
psa_vsd_vecV = zeros(1,ncase);

q_d_vecD = zeros(1,ncase);
ppa_d_vecD = zeros(1,ncase);
psa_d_vecD = zeros(1,ncase);

%atrium conneciton & pulmonary and systemic artery pressure
for iA = 1:length(asd_vec)
    asd = asd_vec(iA);
    vsd=0; 
    d=0;
    circ;    
    q_asd_vecA(iA) = meanvalue(Q_plot(jasd,:), klokmax, T, dt, 10);
    ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
end

%ventricle conneciton & pulmonary and systemic artery pressure
for iV = 1:length(vsd_vec)
    vsd = vsd_vec(iV);
    asd=0;
    d=0;
    circ;
    q_vsd_vecV(iV) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, 10);
    ppa_vsd_vecV(iV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_vsd_vecV(iV) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
end 
% 
%aorta conneciton & pulmonary and systemic artery pressure
for iDD = 1:length(d_vec)
    d = d_vec(iDD);
    asd=0;
    vsd=0;
    circ;    
    q_d_vecD(iDD) = meanvalue(Q_plot(jd,:), klokmax, T, dt, 10);
    ppa_d_vecD(iDD) = meanvalue(P_plot(ipa,:), klokmax, T, dt, 10);
    psa_d_vecD(iDD) = meanvalue(P_plot(isa,:), klokmax, T, dt, 10);
end 

figure(200)
subplot(3,1,1),plot(q_asd_vecA, '-o')
title('Flow between Right and Left Atrium')
xlabel('Shunt Flow') 
ylabel('Shunt Mean')
subplot(3,1,2),plot(ppa_asd_vecA, '-o')
title('Flow between Right and Left Atrium')
xlabel('Shunt Flow') 
ylabel('Pressure')
subplot(3,1,3),plot(psa_asd_vecA, '-o')
title('Flow between Right and Left Atrium')
xlabel('Shunt Flow') 
ylabel('Pressure')


figure(201)
plot(q_asd_vecA, ppa_asd_vecA, '-ro', q_asd_vecA, psa_asd_vecA, '-bs')
title('Atirum Shunt Flow between Pulmonary Artery Pressure and Systemic Artery Pressure')
legend({'Pulmonary artery P','Systemic artery P'},'Location', 'east') 
xlabel('Shunt Flow') 
ylabel('Pressure')

figure(202)
plot(q_asd_vecA, ppa_asd_vecA, '-ro')
title('Atirum Shunt Flow between Pulmonary Artery Pressure')
xlabel('Shunt Flow') 
ylabel('Pressure')

figure(203)
plot(q_asd_vecA, psa_asd_vecA, '-bs')
title('Atirum Shunt Flow between Systemic Artery Pressure')
xlabel('Shunt Flow') 
ylabel('Pressure')

figure(300)
subplot(3,1,1),plot(q_vsd_vecV, '-o')
subplot(3,1,2),plot(ppa_vsd_vecV, '-o')
subplot(3,1,3),plot(psa_vsd_vecV, '-o')

figure(301)
plot(q_vsd_vecV, ppa_vsd_vecV, '-ro', q_vsd_vecV, psa_vsd_vecV, '-bs')
title('Ventricle Shunt Flow between Pulmonary Artery Pressure and Systemic Artery Pressure')
legend({'Pulmonary artery P','Systemic artery P'},'Location', 'east') 
xlabel('Shunt Flow') 
ylabel('Pressure')

figure(400)
subplot(3,1,1),plot(q_d_vecD, '-o')
subplot(3,1,2),plot(ppa_d_vecD, '-o')
subplot(3,1,3),plot(psa_d_vecD, '-o')

figure(401)
plot(q_d_vecD, ppa_d_vecD, '-ro', q_d_vecD, psa_d_vecD, '-bs')
title('Artery Shunt Flow between Pulmonary Artery Pressure and Systemic Artery Pressure')
legend({'Pulmonary artery P','Systemic artery P'},'Location', 'east') 
xlabel('Shunt Flow') 
ylabel('Pressure')

%negative value will be ignored
%semilogx(q_asd_vecA, psa_asd_vecA)

