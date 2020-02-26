%The new main program

clear all % clear all variables
close all       % and figures

asd_vec = [ ]%0 10 100 500 800 1000 2000 3000 5000 10000]
vsd_vec = [0 0.5 3.5 5 7 10 13 16 20 30 50 70 80 100 500 800 1000]% 1500 3000]
d_vec = [ ] % 0 0.1 0.3 0.5 0.7 1 3 4 6 10 30 50 70 100 500 1000

ncase_asd = length(asd_vec);
q_asd_vecA = zeros(1,ncase_asd);
qAo_asd_vecA = zeros(1,ncase_asd);
ppa_asd_vecA = zeros(1,ncase_asd);
psa_asd_vecA = zeros(1,ncase_asd);
oxy_sa_asd_vecA = zeros(1,ncase_asd);

ncase_vsd = length(vsd_vec);
qAo_vsd_vecV = zeros(1,ncase_vsd);
q_vsd_vecV = zeros(1,ncase_vsd);
ppa_vsd_vecV = zeros(1,ncase_vsd);
psa_vsd_vecV = zeros(1,ncase_vsd);
oxy_sa_vsd_vecV = zeros(1,ncase_vsd);

ncase_d = length(d_vec);
q_d_vecD = zeros(1,ncase_d);
ppa_d_vecD = zeros(1,ncase_d);
psa_d_vecD = zeros(1,ncase_d);

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
    oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);	
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
    oxy_sa_vsd_vecV(iV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, 10);
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

if(length(asd_vec) > 0)

figure(201)
plot(q_asd_vecA, ppa_asd_vecA, '-ro', q_asd_vecA, psa_asd_vecA, '-bs')
title('Atrium Shunt Flow between Pulmonary Artery Pressure and Systemic Artery Pressure')
legend({'Pulmonary artery P','Systemic artery P'},'Location', 'east') 
xlabel('Shunt Flow Mean') 
ylabel('Pressure')

figure(202)
plot(q_asd_vecA, ppa_asd_vecA, '-ro')
title('Atrium Shunt Flow between Pulmonary Artery Pressure')
xlabel('Shunt Flow Mean') 
ylabel('Pressure')

figure(203)
plot(q_asd_vecA, psa_asd_vecA, '-bs')
title('Atrium Shunt Flow between Systemic Artery Pressure')
xlabel('Shunt Flow Mean') 
ylabel('Pressure')

figure(204)
plot(q_asd_vecA, 10.*oxy_sa_asd_vecA, '-bs','linewidth', 2)
title('Atrium Shunt Flow versus oxygen saturation ')
xlabel('Shunt Flow Mean') 
ylabel('oxygen saturation')

end

if(length(vsd_vec) > 0)

figure(301)
plot(q_vsd_vecV, ppa_vsd_vecV, '-ro', q_vsd_vecV, psa_vsd_vecV, '-bs')
title('Ventricle Shunt Flow between Pulmonary Artery Pressure and Systemic Artery Pressure')
legend({'Pulmonary artery P','Systemic artery P'},'Location', 'east') 
xlabel('Shunt Flow Mean') 
ylabel('Pressure')

figure(304)
plot(q_vsd_vecV, 10.*oxy_sa_vsd_vecV, '-bs','linewidth', 2)
title('Ventricle Shunt Flow versus oxygen saturation ')
xlabel('Shunt Flow Mean') 
ylabel('oxygen saturation')

end


if (length(d_vec) > 0)

figure(401)
plot(q_d_vecD, ppa_d_vecD, '-ro', q_d_vecD, psa_d_vecD, '-bs')
title('Artery Shunt Flow between Pulmonary Artery Pressure and Systemic Artery Pressure')
legend({'Pulmonary artery P','Systemic artery P'},'Location', 'east') 
xlabel('Shunt Flow Mean') 
ylabel('Pressure')

end