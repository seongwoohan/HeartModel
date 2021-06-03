clear all
close all

%% normal case
tic

jasd=7;
jvsd=8;
jd=9;

Rp_vec = (1.3*0.2 : 0.208 : 1.3)*Rs;
m_vec = (16.8 : 16.64 : 100);
ncase_dm = length(m_vec);

num_cycles_for_mean = 5;

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
       circ;
       ns = (T/dt)*10; 
       oxy_sv_normal(iNN) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
       oxy_sa_normal(iNN) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
       qs_normal(iNN) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    end
end    

%clearvars -except oxy_sv_normal oxy_sa_normal
%disp('done with normal case');


%% pre-intervention rph case


jasd=7;
jvsd=8;
jd=9;

m_vec = (16.8 : 16.64 : 100);
ncase_dm = length(m_vec);

num_cycles_for_mean = 5;

disease_state_pre = true;
disease_state = false;
do_exercise = true;
if (disease_state_pre == true) 
    oxy_sv_pre_intervention_rph = zeros(1, ncase_dm);
    oxy_sa_pre_intervention_rph = zeros(1, ncase_dm);
    qs_pre_intervention_rph = zeros(1, ncase_dm);
    Ashunt = 0;   
    for iPP = 1:length(m_vec)
       j_shunt = jd;
       m_set = m_vec(iPP);
       HR_set = 0.94 * (m_set - 16.8) + 80;
       Rs_set = (17.5 * 80)/HR_set;
       circ;
       ns = (T/dt)*10; 
       oxy_sv_pre_intervention_rph(iPP) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
       oxy_sa_pre_intervention_rph(iPP) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
       qs_pre_intervention_rph(iPP) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
    end    
end 

%clearvars -except oxy_sv_normal oxy_sa_normal oxy_sv_pre_intervention_rph oxy_sa_pre_intervention_rph
%disp('done with pre-intervention case');


%% potts shunt 0.1cm^2 rph case


jasd=7;
jvsd=8;
jd=9;

%Rp_vec = (1.3*0.2 : 0.104 : 1.3)*Rs;
m_vec = (16.8 : 16.64 : 100);
ncase_dm = length(m_vec);

num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = true;
do_exercise = true;
if (disease_state == true) 
  d_vec = 0.1 /100;
    oxy_sv_potts_shunt = zeros(1, ncase_dm);
    oxy_sa_potts_shunt = zeros(1, ncase_dm);
    qs_potts_shunt = zeros(1, ncase_dm);
    q_d_mean_vecD = zeros(1,ncase_dm);
    q_d_plus_vecD = zeros(1,ncase_dm);
    q_d_minus_vecD = zeros(1,ncase_dm);
    
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
            qs_potts_shunt(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
            q_d_mean_vecD(iEE) = meanvalue(Q_plot(jd,:), klokmax, T, dt, num_cycles_for_mean);
            q_d_plus_vecD(iEE) = meanvalue(max(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
            q_d_minus_vecD(iEE) = meanvalue(min(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
        end
    end  
end 

%clearvars -except oxy_sv_normal oxy_sa_normal oxy_sv_pre_intervention_rph oxy_sa_pre_intervention_rph oxy_sv_potts_shunt oxy_sa_potts_shunt
%disp('done with potts case');



%% vsd 0.5cm^2 rph case


jasd=7;
jvsd=8;
jd=9;

m_vec = (16.8 : 16.64 : 100);
ncase_dm = length(m_vec);

num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = true;
do_exercise = true;
if (disease_state == true) 
  v_vec = 0.5 /100;
    oxy_sv_vsd = zeros(1, ncase_dm);
    oxy_sa_vsd = zeros(1, ncase_dm);
    qs_vsd = zeros(1, ncase_dm);
    q_vsd_mean_vecV = zeros(1,ncase_dm);
    q_vsd_plus_vecV = zeros(1,ncase_dm);
    q_vsd_minus_vecV = zeros(1,ncase_dm);
    
    for iDD = 1:length(v_vec)
        j_shunt = jvsd;
        Ashunt = v_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_vsd(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_vsd(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_vsd(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_mean_vecV(iEE) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_plus_vecV(iEE) = meanvalue(max(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_minus_vecV(iEE) = meanvalue(min(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);    
        end
    end  
end 

%clearvars -except m_vec oxy_sv_normal oxy_sa_normal oxy_sv_pre_intervention_rph oxy_sa_pre_intervention_rph oxy_sv_potts_shunt oxy_sa_potts_shunt oxy_sv_vsd oxy_sa_vsd
%disp('done with vsd case');
toc



%%

figure(1)
plot3(m_vec, 10*oxy_sv_normal, Rp_vec,'-o', m_vec, 10*oxy_sv_pre_intervention_rph, Rp_vec,'-ro', m_vec, 10*oxy_sv_potts_shunt, Rp_vec,'-bo', m_vec, 10*oxy_sv_vsd, Rp_vec,'-go', m_vec, 10*oxy_sa_normal, Rp_vec,'-o',  m_vec, 10*oxy_sa_pre_intervention_rph, Rp_vec,'-ro', m_vec, 10*oxy_sa_potts_shunt, Rp_vec,'-bo', m_vec, 10*oxy_sa_vsd, Rp_vec,'-go','linewidth', 1.5)
set(gca,'FontSize',15)
legend({'normal','pre-intervention','potts shunt 0.1cm^2', 'vsd 0.5cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
zlabel('Pulmonary resistance')
xlim([16.8 100])
grid on

figure(1000)
plot(m_vec, 10*oxy_sv_normal, '-mo', m_vec, 10*oxy_sv_pre_intervention_rph, '-ro', m_vec, 10*oxy_sv_potts_shunt, '-bo', m_vec, 10*oxy_sv_vsd,'-go', m_vec, 10*oxy_sa_normal, '-o',  m_vec, 10*oxy_sa_pre_intervention_rph, '-ro', m_vec, 10*oxy_sa_potts_shunt, '-bo', m_vec, 10*oxy_sa_vsd,'-go','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Systemic vein & artery oxgyen','FontWeight','Normal')
legend({'normal','pre-intervention','potts shunt 0.1cm^2', 'vsd 0.5cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
ylim([-65 110])
grid on


figure(1001)
plot(m_vec, qs_normal.*oxy_sv_normal, '-mo', m_vec, qs_pre_intervention_rph.*oxy_sv_pre_intervention_rph, '-ro', m_vec, qs_potts_shunt.*oxy_sv_potts_shunt, '-bo', m_vec, qs_vsd.*oxy_sv_vsd,'-go', m_vec, qs_normal.*oxy_sa_normal, '-mo',  m_vec, qs_pre_intervention_rph.*oxy_sa_pre_intervention_rph, '-ro', m_vec, qs_potts_shunt.*oxy_sa_potts_shunt, '-bo', m_vec, qs_vsd.*oxy_sa_vsd,'-go','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Systemic artery & vein exercise torlerance','FontWeight','Normal')
legend({'normal','pre-intervention','potts shunt 0.1cm^2', 'vsd 0.5cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen delivery (moml/min)')
xlim([16.8 100])
%ylim([-65 110])
grid on

%{
figure(1002)
plot(m_vec, (qs_normal.*oxy_sa_normal - qs_normal.*oxy_sv_normal), '-mo', m_vec, (qs_pre_intervention_rph.*oxy_sa_pre_intervention_rph - qs_pre_intervention_rph.*oxy_sv_pre_intervention_rph), '-ro', m_vec, (qs_potts_shunt.*oxy_sa_potts_shunt - qs_potts_shunt.*oxy_sv_potts_shunt), '-bo', m_vec, (qs_vsd.*oxy_sa_vsd - qs_vsd.*oxy_sv_vsd),'-go','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Exercise difference: systemic artery and vein','FontWeight','Normal')
legend({'normal','pre-intervention','potts shunt 0.1cm^2', 'vsd 0.5cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen delivery (moml/min)')
xlim([16.8 100])
%ylim([-65 110])
grid on

figure(1003)
plot(m_vec, 10*oxy_sv_pre_intervention_rph, '-ro', m_vec, 10*oxy_sv_potts_shunt, '-bo', m_vec, 10*oxy_sv_vsd,'-go',  m_vec, 10*oxy_sa_pre_intervention_rph, '-ro', m_vec, 10*oxy_sa_potts_shunt, '-bo', m_vec, 10*oxy_sa_vsd,'-go','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Systemic artery & vein oxygen saturation','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.1cm^2', 'vsd 0.5cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
ylim([-65 110])
grid on

figure(1004)
plot(m_vec, qs_pre_intervention_rph.*oxy_sv_pre_intervention_rph, '-ro', m_vec, qs_potts_shunt.*oxy_sv_potts_shunt, '-bo', m_vec, qs_vsd.*oxy_sv_vsd,'-go', m_vec, qs_pre_intervention_rph.*oxy_sa_pre_intervention_rph, '-ro', m_vec, qs_potts_shunt.*oxy_sa_potts_shunt, '-bo', m_vec, qs_vsd.*oxy_sa_vsd,'-go','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Systemic artery & vein exercise tolerance','FontWeight','Normal')
legend({'pre-intervention','potts shunt 0.1cm^2', 'vsd 0.5cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen delivery (moml/min)')
xlim([16.8 100])
%ylim([-65 110])
grid on

figure(1005)
plot(m_vec, (qs_normal.*oxy_sa_normal - qs_normal.*oxy_sv_normal), '-mo', m_vec, (qs_pre_intervention_rph.*oxy_sa_pre_intervention_rph - qs_pre_intervention_rph.*oxy_sv_pre_intervention_rph), '-ro', m_vec, (qs_potts_shunt.*oxy_sa_potts_shunt - qs_potts_shunt.*oxy_sv_potts_shunt), '-bo', m_vec, (qs_vsd.*oxy_sa_vsd - qs_vsd.*oxy_sv_vsd),'-go','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Exercise difference: systemic artery and vein','FontWeight','Normal')
legend({'normal','pre-intervention','potts shunt 0.1cm^2', 'vsd 0.5cm^2'},'Location', 'best','FontSize',15)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen delivery (moml/min)')
xlim([16.8 100])
%ylim([-65 110])
grid on

figure(1006)
plot(t_plot((klokmax-((T/dt)*10)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*10)+1):klokmax)),'linewidth', 2.5);
title('Potts Shunt Flow','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
%ylim([-2 10])
yline(0, '--b','linewidth', 2)

figure(1007)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 2.5);
set(gca,'FontSize',23)
title('Ventricular Septal Defect','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
%xlim([12.4375 12.5])
%ylim([-4 8])

figure(1008)
plot(v_vec*100, q_vsd_mean_vecV, '-o',v_vec*100, q_vsd_plus_vecV,'-o', v_vec*100, q_vsd_minus_vecV, '-o','linewidth', 2)


figure(1009)
plot(d_vec, q_d_mean_vecD, '-o',d_vec*100, q_d_plus_vecD,'-o', d_vec*100, q_d_minus_vecD, '-o','linewidth', 2)
%}

