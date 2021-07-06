%% VSD 

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8%50.08;
ncase_dm = length(m_vec);
num_cycles_for_mean = 5;

disease_state_pre = false
disease_state = true;
Rp_state = false;
do_exercise = true;
if (disease_state == true) 
    v_vec = 0.3;
    ppa_vsd_vecV = zeros(1, ncase_dm);
    ppv_vsd_vecV = zeros(1, ncase_dm);
    oxy_sv_vsd_one = zeros(1, ncase_dm);
    oxy_sa_vsd_one = zeros(1, ncase_dm);
    qs_vsd_one = zeros(1, ncase_dm);
    q_vsd_mean_vecV_one = zeros(1,ncase_dm);
    q_vsd_plus_vecV_one = zeros(1,ncase_dm);
    q_vsd_minus_vecV_one = zeros(1,ncase_dm);
    
    for iVV = 1:length(v_vec)
        j_shunt = jvsd;
        Ashunt = v_vec(iVV);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = floor((T/dt)*10);  
            ppa_vsd_vecV(iVV) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
            ppv_vsd_vecV(iVV) = meanvalue(P_plot(ipv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sv_vsd_one(iVV) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_vsd_one(iVV) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_vsd_one(iVV) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_mean_vecV_one(iVV) = meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_plus_vecV_one(iVV) = meanvalue(max(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean);
            q_vsd_minus_vecV_one(iVV) = meanvalue(min(Q_plot(jvsd,:),0), klokmax, T, dt, num_cycles_for_mean); 
        end
    end  
end 




figure(1006)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 2);
set(gca,'FontSize',23)
title('Ventricular Septal Defect','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
ylim([-60 30])




