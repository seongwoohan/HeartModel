%% VSD 16.8

jasd=7;
jvsd=8;
jd=9;

disease_state_pre = false;
disease_state = false;
do_exercise = true;
Rp_state = true;

if (Rp_state == true) 
    v_vec = 0.3 / 100;
    for iVV = 1:length(v_vec)
        j_shunt = jvsd;
        Ashunt = v_vec(iVV);
        
        m_set = 16.8 
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        
        Rp_vec = (3.25 : 3.9 : 22.75) 
        ncase_dm = length(Rp_vec);
        
        q_vsd_mean_vecV = zeros(1, ncase_dm);
        q_vsd_plus_vecV = zeros(1, ncase_dm);
        q_vsd_minus_vecV = zeros(1, ncase_dm);
        
        num_cycles_for_mean = 5;
        
        for iRR = 1:length(Rp_vec)
            Rp = Rp_vec(iRR);  
            circ;
            
            ns = (T/dt)*10; 
            q_vsd_mean_vecV(iRR) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_plus_vecV(iRR) = meanvalue(max(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_minus_vecV(iRR) = meanvalue(min(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
        end
    end
end 

%% VSD 33.44

jasd=7;
jvsd=8;
jd=9;

disease_state_pre = false;
disease_state = false;
do_exercise = true;
Rp_state = true;

if (Rp_state == true) 
    v_vec = 0.3 / 100;
    for iVV = 1:length(v_vec)
        j_shunt = jvsd;
        Ashunt = v_vec(iVV);
        
        m_set = 33.44
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        
        Rp_vec = (3.25 : 3.9 : 22.75)
        ncase_dm = length(Rp_vec);
        
        q_vsd_mean_vecV_one = zeros(1, ncase_dm);
        q_vsd_plus_vecV_one = zeros(1, ncase_dm);
        q_vsd_minus_vecV_one = zeros(1, ncase_dm);
        
        num_cycles_for_mean = 5;
        
        for iRR = 1:length(Rp_vec)
            Rp = Rp_vec(iRR);  
            circ;
            
            ns = (T/dt)*10; 
            q_vsd_mean_vecV_one(iRR) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_plus_vecV_one(iRR) = meanvalue(max(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_minus_vecV_one(iRR) = meanvalue(min(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
        end
    end
end 

%% Potts Shunt 16.8

jasd=7;
jvsd=8;
jd=9;

disease_state_pre = false;
disease_state = false;
do_exercise = true;
Rp_state = true;

if (Rp_state == true) 
    d_vec = 0.3 / 100;
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        
        m_set = 16.8
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        
        Rp_vec = (3.25 : 3.9 : 22.75)
        ncase_dm = length(Rp_vec);
        
        q_d_mean_vecD = zeros(1, ncase_dm);
        q_d_plus_vecD = zeros(1, ncase_dm);
        q_d_minus_vecD = zeros(1, ncase_dm);
        
        num_cycles_for_mean = 5;
        
        for iRR = 1:length(Rp_vec)
            Rp = Rp_vec(iRR);  
            circ;
            
            ns = (T/dt)*10; 
            q_d_mean_vecD(iRR) = meanvalue(Q_plot(jd,:), klokmax, T, dt, num_cycles_for_mean);
            q_d_plus_vecD(iRR) = meanvalue(max(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
            q_d_minus_vecD(iRR) = meanvalue(min(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
        end
    end
end 

%% Potts Shunt 33.44

jasd=7;
jvsd=8;
jd=9;

disease_state_pre = false;
disease_state = false;
do_exercise = true;
Rp_state = true;

if (Rp_state == true) 
    d_vec = 0.3 / 100;
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        
        m_set = 33.44
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        
        Rp_vec = (3.25 : 3.9 : 22.75)
        ncase_dm = length(Rp_vec);
        
        q_d_mean_vecD_one = zeros(1, ncase_dm);
        q_d_plus_vecD_one = zeros(1, ncase_dm);
        q_d_minus_vecD_one = zeros(1, ncase_dm);
        
        num_cycles_for_mean = 5;
        
        for iRR = 1:length(Rp_vec)
            Rp = Rp_vec(iRR);  
            circ;
            
            ns = (T/dt)*10; 
            q_d_mean_vecD_one(iRR) = meanvalue(Q_plot(jd,:), klokmax, T, dt, num_cycles_for_mean);
            q_d_plus_vecD_one(iRR) = meanvalue(max(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
            q_d_minus_vecD_one(iRR) = meanvalue(min(Q_plot(jd,:),0), klokmax, T, dt, num_cycles_for_mean);
        end
    end
end 

f(1) = figure
plot(Rp_vec, q_d_mean_vecD_one, '-.b^', Rp_vec, q_vsd_mean_vecV_one,'-.k^', Rp_vec, q_d_mean_vecD, '-bo', Rp_vec, q_vsd_mean_vecV,'-ko','linewidth', 1.8,'MarkerSize', 8) 
yline(0, '--b','linewidth', 1.2)
legend({'PS (exercise)', 'VSD (exercise)','PS (rest)','VSD (rest)'},'Location', 'east','FontSize',15)
legend boxoff
title('Mean Shunt Flow ','FontWeight','Normal')
xlabel('Pulmonary resistance (mmHg/(liter/minute))')
ylabel('Flow (L/min)')
xlim([3.25 22.75])
%ylim([-6 3])
set(gca,'FontSize',18)
saveas(f(1),"exp5",'epsc')


