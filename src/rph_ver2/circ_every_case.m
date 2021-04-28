% exercise simulation for every case
tic
clear all
close all

do_exercise = true

jasd=7;
jvsd=8;
jd=9;

m_vec = (16.8 : 8.32 : 100)
ncase_dm = length(m_vec);

num_cycles_for_mean = 5;

%% normal case

disease_state = false
if (disease_state == false) 
    oxy_sv_normal = zeros(1, ncase_dm);
    oxy_sa_normal = zeros(1, ncase_dm);
    
    Ashunt = 0
    for iNN = 1:length(m_vec)
       j_shunt = jd;
       m_set = m_vec(iNN);
       HR_set = 0.94 * (m_set - 16.8) + 80;
       Rs_set = (17.5 * 80)/HR_set;
       circ;
       ns = (T/dt)*10; 
       oxy_sv_normal(iNN) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
       oxy_sa_normal(iNN) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
 
    end
end    

%% pre-intervention rph case

disease_state = true
if (disease_state == true) 
    oxy_sv_pre_intervention_rph = zeros(1, ncase_dm);
    oxy_sa_pre_intervention_rph = zeros(1, ncase_dm);
   
    Ashunt = 0   
    for iPP = 1:length(m_vec)
       j_shunt = jd;
       m_set = m_vec(iPP);
       HR_set = 0.94 * (m_set - 16.8) + 80;
       Rs_set = (17.5 * 80)/HR_set;
       circ;
       ns = (T/dt)*10; 
       oxy_sv_pre_intervention_rph(iPP) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
       oxy_sa_pre_intervention_rph(iPP) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
 
    end    
end 

%% potts shunt 0.1cm^2 rph case

disease_state = true
if (disease_state == true) 
    d_vec = 0.1 /100
    oxy_sv_potts_shunt = zeros(1, ncase_dm);
    oxy_sa_potts_shunt = zeros(1, ncase_dm);
    
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_potts_shunt(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_potts_shunt(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end  
end 

%% vsd 0.3cm^2 rph case
disease_state = true
if (disease_state == true) 
    v_vec = 0.3 /100
    oxy_sv_vsd = zeros(1, ncase_dm);
    oxy_sa_vsd = zeros(1, ncase_dm);
    
    for iDD = 1:length(v_vec)
        j_shunt = jvsd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_vsd(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_vsd(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end  
end 

figure(1000)
plot(m_vec, 10*oxy_sv_normal, '-o', m_vec, 10*oxy_sa_normal, '-o', m_vec, 10*oxy_sv_pre_intervention_rph, '-o',  m_vec, 10*oxy_sa_pre_intervention_rph, '-o', m_vec, 10*oxy_sv_potts_shunt, '-o', m_vec, 10*oxy_sa_potts_shunt, '-o', m_vec, 10*oxy_sv_vsd,'-o', m_vec, 10*oxy_sa_vsd,'-o','linewidth', 3)
set(gca,'FontSize',20)
%yline(0, '--b','linewidth', 2)
title('Systemic vein oxgyen','FontWeight','Normal')
%legend({'normal','pre-intervention','potts shunt 1cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
grid on

figure(1001)
plot(m_vec, 10*oxy_sv_normal, '-o', m_vec, 10*oxy_sv_pre_intervention_rph, '-o', m_vec, 10*oxy_sv_potts_shunt, '-o', m_vec, 10*oxy_sv_vsd,'-o','linewidth', 2.5)
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
title('Systemic vein oxgyen','FontWeight','Normal')
legend({'normal','pre-intervention','potts shunt 1cm^2', 'vsd 3cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
grid on

figure(1002)
plot(m_vec, 10*oxy_sa_normal, '-o', m_vec, 10*oxy_sa_pre_intervention_rph, '-o', m_vec, 10*oxy_sa_potts_shunt, '-o', m_vec, 10*oxy_sa_vsd,'-o','linewidth', 2.5)
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
title('Systemic artery oxgyen','FontWeight','Normal')
legend({'normal','pre-intervention','potts shunt 1cm^2', 'vsd 3cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
grid on

toc
