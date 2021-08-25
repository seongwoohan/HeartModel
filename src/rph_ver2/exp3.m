clear all
close all

%% normal case
tic
%{
jasd=7;
jvsd=8;
jd=9;

m_vec = 50.08;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = false;
do_exercise = true;
Rp_state = false;

if (disease_state == false)  
    oxy_sv_normal = zeros(1, ncase_dm);
    oxy_sa_normal = zeros(1, ncase_dm); 
    qs_normal = zeros(1, ncase_dm);
    Ashunt = 0;
    for iNN = 1:length(m_vec)
       j_shunt = jd;
       m_set = m_vec(iNN);
       HR_set = 0.94 * (m_set - 16.8) + 80;
       Rs_set = (17.5 * 80)/HR_set;
       Rp_vec = (1.3*0.2 : 0.26 : 1.3)*Rs_set;
       for iRR = 1:length(Rp_vec)   
           Rp = Rp_vec(iRR);
           circ;
           ns = (T/dt)*10; 
           oxy_sv_normal(iRR) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
           oxy_sa_normal(iRR) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
           qs_normal(iRR) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
       end
    end
end
%}


%% pre-intervention rph case

jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = false;
do_exercise = true;
Rp_state = true;

if (Rp_state == true) 
    oxy_sv_pre_intervention_rph = zeros(1, ncase_dm);
    oxy_sa_pre_intervention_rph = zeros(1, ncase_dm);
    qs_pre_intervention_rph = zeros(1, ncase_dm);
    Ashunt = 0;  
    for iPP = 1:length(m_vec)
       j_shunt = jd;
       m_set = m_vec(iPP);
       HR_set = 0.94 * (m_set - 16.8) + 80;
       Rs_set = (17.5 * 80)/HR_set;
       Rp_vec = (3.25 : 3.9 : 22.75) %(3.25 : 3.9 : 18.85) 
       for iRR = 1:length(Rp_vec)
           Rp = Rp_vec(iRR);
           circ;
           ns = (T/dt)*10; 
           oxy_sv_pre_intervention_rph(iRR) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
           oxy_sa_pre_intervention_rph(iRR) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
           qs_pre_intervention_rph(iRR) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
       end
    end    
end 

%% potts shunt 0.3cm^2 

jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = false;
do_exercise = true;
Rp_state = true;

if (Rp_state == true) 
    d_vec = 0.3 /100;
    oxy_sv_potts_shunt_one = zeros(1, ncase_dm);
    oxy_sa_potts_shunt_one = zeros(1, ncase_dm);
    qs_potts_shunt_one = zeros(1, ncase_dm);
    q_d_mean_vecD_one = zeros(1,ncase_dm);
    q_d_plus_vecD_one = zeros(1,ncase_dm);
    q_d_minus_vecD_one = zeros(1,ncase_dm);
    
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            Rp_vec = (3.25 : 3.9 : 22.75) %(3.25 : 3.9 : 18.85) 
            for iRR = 1:length(Rp_vec)
                Rp = Rp_vec(iRR);
                circ;
                ns = (T/dt)*10;  
                oxy_sv_potts_shunt_one(iRR) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
                oxy_sa_potts_shunt_one(iRR) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
                qs_potts_shunt_one(iRR) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
                q_d_mean_vecD_one(iRR) = meanvalue(Q_plot(jd,:), klokmax, T, dt, num_cycles_for_mean);
                q_d_plus_vecD_one(iRR) = meanvalue(max(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
                q_d_minus_vecD_one(iRR) = meanvalue(min(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
            end
        end
    end  
end 

%% VSD 0.3 cm^2

jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = false;
do_exercise = true;
Rp_state = true;

if (Rp_state == true) 
    v_vec = 0.3 /100;
    oxy_sv_vsd_one = zeros(1, ncase_dm);
    oxy_sa_vsd_one = zeros(1, ncase_dm);
    qs_vsd_one = zeros(1, ncase_dm);
    q_vsd_mean_vecV_one = zeros(1,ncase_dm);
    q_vsd_plus_vecV_one = zeros(1,ncase_dm);
    q_vsd_minus_vecV_one = zeros(1,ncase_dm);
    
    for iDD = 1:length(v_vec)
        j_shunt = jvsd;
        Ashunt = v_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            Rp_vec = (3.25 : 3.9 : 22.75) %(3.25 : 3.9 : 18.85) 
            for iRR = 1:length(Rp_vec)
                Rp = Rp_vec(iRR);
                circ;
                ns = (T/dt)*10;  
                oxy_sv_vsd_one(iRR) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
                oxy_sa_vsd_one(iRR) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
                qs_vsd_one(iRR) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
                q_vsd_mean_vecV_one(iRR) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean);
                q_vsd_plus_vecV_one(iRR) = meanvalue(max(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
                q_vsd_minus_vecV_one(iRR) = meanvalue(min(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean); 
            end
        end
    end  
end 
toc


%% Oxygen Saturation 
f(1) = figure;
plot(22.75, 17.74,'-ro', Rp_vec, 10*oxy_sv_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sv_vsd_one,'-ko', Rp_vec, 10*oxy_sa_potts_shunt_one, '-.bo', Rp_vec, 10*oxy_sa_vsd_one,'-.ko', 'linewidth', 1.8,'MarkerSize', 8)
yline(0, '--b','linewidth', 1.2) %-4.35
%yline(54.19, '-r','linewidth', 1.2)
yline(17.74, '-r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Oxygen Saturation (m = 33.44)','FontWeight','Normal')
legend({'pre-intervention','PS 0.3cm^2', 'VSD 0.3cm^2'},'Location', 'east','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen Saturation (%)')
xlim([3.25 22.75])
ylim([-10 110])
grid on
saveas(f(1),"exp3_os_16.8",'epsc')

figure(1000)
plot(Rp_vec, 10*oxy_sv_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sv_vsd_one,'-ko')

figure(3)
plot(Rp_vec, 10*oxy_sa_pre_intervention_rph, '-ro', Rp_vec, 10*oxy_sa_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sa_vsd_one,'-ko', Rp_vec, 10*oxy_sv_pre_intervention_rph,'-ro', Rp_vec, 10*oxy_sv_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sv_vsd_one,'-ko', 'linewidth', 1.5,'MarkerSize', 8)
yline(0, '--b','linewidth', 1.2)
%yline(-13.54, '-r','linewidth', 1.2)
%yline(54.19, '-r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Oxygen Saturation','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'east','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen Saturation (%)')
xlim([3.25 22.75])
ylim([-50 110])
grid on

%% Systemic Flow
f(4) = figure;
plot(Rp_vec, qs_pre_intervention_rph, '-ro', Rp_vec, qs_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one,'-ko', 'linewidth', 1.8,'MarkerSize', 8)
%yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Systemic Flow (m = 16.8)','FontWeight','Normal')
legend({'pre-intervention','PS 0.3cm^2', 'VSD 0.3cm^2'},'Location', 'northeast','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Systemic flow (L/min)')
xlim([3.25 22.75])
%xlim([4.55 22.75])
ylim([3.5 7])
grid on
saveas(f(4),"exp3_sf_16.8",'epsc')


%% Oxgyen Delivery
f(5) = figure;
plot(22.75, 7.191, '-ro', Rp_vec, qs_potts_shunt_one.*oxy_sv_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sv_vsd_one,'-ko', Rp_vec, qs_potts_shunt_one.*oxy_sa_potts_shunt_one, '-.bo', Rp_vec, qs_vsd_one.*oxy_sa_vsd_one,'-.ko', 'linewidth', 1.8,'MarkerSize', 8)
yline(0, '--b','linewidth', 1.2) %-2.03
%yline(19.84, '-r','linewidth', 1.2)
yline(7.191, '-r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Oxygen Delivery (m = 33.44)','FontWeight','Normal')
legend({'pre-intervention','PS 0.3cm^2', 'VSD 0.3cm^2'},'Location', 'northeast','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen delivery (moml/min)')
xlim([3.25 22.75])
ylim([-10 60])
grid on
saveas(f(5),"exp3_od_16.8",'epsc')


figure(6)
plot(Rp_vec, qs_pre_intervention_rph.*oxy_sa_pre_intervention_rph, '-ro', Rp_vec, qs_potts_shunt_one.*oxy_sa_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sa_vsd_one,'-ko', Rp_vec, qs_pre_intervention_rph.*oxy_sv_pre_intervention_rph, '-ro', Rp_vec, qs_potts_shunt_one.*oxy_sv_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sv_vsd_one,'-ko', 'linewidth', 1.8,'MarkerSize', 8)
yline(0, '--b','linewidth', 1.2)
%yline(-5.951, '-r','linewidth', 1.2)
%yline(19.84, '-r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Oxygen Delivery','FontWeight','Normal')
legend({'pre-intervention','PS 0.3cm^2', 'VSD 0.3cm^2'},'Location', 'northeast','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen delivery (moml/min)')
xlim([3.25 22.75])
ylim([-40 80])
grid on



