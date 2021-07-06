clear all
close all

%% normal case
tic

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8%50.08;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

Rp_state = false;
disease_state_pre = false
disease_state = false;
do_exercise = true;
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



%% pre-intervention rph case

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8%50.08;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = false;
Rp_state = true;
do_exercise = true;
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
       Rp_vec = (1.3*0.2 : 0.26 : 1.3)*Rs_set;
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

m_vec = 16.8%50.08;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = false;
Rp_state = true;
do_exercise = true;
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
            Rp_vec = (1.3*0.2 : 0.26 : 1.3)*Rs_set;
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

m_vec = 16.8%50.08;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = false;
Rp_state = true;
do_exercise = true;
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
            Rp_vec = (1.3*0.2 : 0.26 : 1.3)*Rs_set;
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
plot(Rp_vec, 10*oxy_sa_pre_intervention_rph, '-ro', Rp_vec, 10*oxy_sa_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sa_vsd_one,'-go', Rp_vec, 10*oxy_sv_pre_intervention_rph, '-ro', Rp_vec, 10*oxy_sv_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sv_vsd_one,'-go', 'linewidth', 1.5)
%yline(0, '--b','linewidth', 1.2)
%yline(1.773, '--r','linewidth', 1.2)
yline(54.19, '--r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Rp vs Oxygen saturation','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'east','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen Saturation (%)')
%xlim([3.271 16.3547])
xlim([4.55 22.75])
grid on

figure(100)
plot(Rp_vec, 10*oxy_sa_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sa_vsd_one,'-go', Rp_vec, 10*oxy_sv_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sv_vsd_one,'-go', 'linewidth', 1.5)
%yline(0, '--b','linewidth', 1.2)
%yline(1.773, '--r','linewidth', 1.2)
yline(54.19, '--r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Rp vs Oxygen saturation','FontWeight','Normal')
legend({'potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'east','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen Saturation (%)')
%xlim([3.271 16.3547])
xlim([4.55 22.75])
grid on

figure(2)
plot(Rp_vec, 10*oxy_sv_pre_intervention_rph, '-ro', Rp_vec, 10*oxy_sv_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sv_vsd_one,'-go', 'linewidth', 1.5)
yline(0, '--b','linewidth', 1.2)
set(gca,'FontSize',20)
title('Systemic vein','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen Saturation (%)')
%xlim([3.271 16.354])
%xlim([4.55 22.75])
grid on

figure(3)
plot(Rp_vec, 10*oxy_sa_pre_intervention_rph, '-ro', Rp_vec, 10*oxy_sa_potts_shunt_one, '-bo', Rp_vec, 10*oxy_sa_vsd_one,'-go', 'linewidth', 1.5)
%yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Systemic artery','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen Saturation (%)')
%xlim([3.271 16.354])
%xlim([4.55 22.75])
%ylim([80 105])
grid on

figure(4)
plot(Rp_vec, qs_pre_intervention_rph, '-ro', Rp_vec, qs_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one,'-go', 'linewidth', 1.5)
%yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Rp vs Systemic flow','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Systemic flow (L/min)')
%xlim([3.271 16.354])
%xlim([4.55 22.75])
grid on

figure(5)
plot(Rp_vec, qs_pre_intervention_rph.*oxy_sv_pre_intervention_rph, '-ro', Rp_vec, qs_potts_shunt_one.*oxy_sv_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sv_vsd_one,'-go', 'linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Rp vs Oxygen delivery','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen delivery (moml/min)')
%xlim([3.271 16.354])
%xlim([4.55 22.75])
grid on

figure(6)
plot(Rp_vec, qs_pre_intervention_rph.*oxy_sa_pre_intervention_rph, '-ro', Rp_vec, qs_potts_shunt_one.*oxy_sa_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sa_vsd_one,'-go', Rp_vec, qs_pre_intervention_rph.*oxy_sv_pre_intervention_rph, '-ro', Rp_vec, qs_potts_shunt_one.*oxy_sv_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sv_vsd_one,'-go', 'linewidth', 1.5)
%yline(0, '--b','linewidth', 1.2)
%yline(0.9026, '--r','linewidth', 1.2)
%yline(19.84, '--r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Rp vs Oxygen delivery','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'northeast','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen delivery (moml/min)')
%xlim([3.271 16.3547])
xlim([4.55 22.75])
ylim([15 60])
grid on

figure(600)
plot(Rp_vec, qs_potts_shunt_one.*oxy_sa_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sa_vsd_one,'-go', Rp_vec, qs_potts_shunt_one.*oxy_sv_potts_shunt_one, '-bo', Rp_vec, qs_vsd_one.*oxy_sv_vsd_one,'-go', 'linewidth', 1.5)
%yline(0, '--b','linewidth', 1.2)
%yline(0.9026, '--r','linewidth', 1.2)
yline(19.84, '--r','linewidth', 1.2)
set(gca,'FontSize',20)
title('Rp vs Oxygen delivery','FontWeight','Normal')
legend({'potts shunt 0.3cm^2', 'vsd 0.3cm^2'},'Location', 'northeast','FontSize',15)
legend boxoff
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Oxygen delivery (moml/min)')
%xlim([3.271 16.3547])
xlim([4.55 22.75])
ylim([15 60])
grid on


