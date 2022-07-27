tic
clear all % clear all variables
close all  

%% normal & pre-intervention rph table
jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8;
ncase_dm = length(m_vec);

num_cycles_for_mean = 5;

disease_state = true;
do_exercise = true;
disease_state_pre = false;
Rp_state = false

% mean value for above variables
if (disease_state == true) 
    int_vec = 0 / 100;
    qs_asd_vecA = zeros(1,ncase_dm);
    ppa_asd_vecA = zeros(1,ncase_dm);
    ppv_asd_vecA = zeros(1,ncase_dm);
    psa_asd_vecA = zeros(1,ncase_dm);
    oxy_sa_asd_vecA = zeros(1,ncase_dm);
    oxy_pa_asd_vecA = zeros(1,ncase_dm);
    
    for iA = 1:length(int_vec)
        j_shunt = jasd
        Ashunt = int_vec(iA);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;     
            qs_asd_vecA(iA) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);            
            ppa_asd_vecA(iA) = meanvalue(P_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
            ppv_asd_vecA(iA) = meanvalue(P_plot(ipv,:), klokmax, T, dt, num_cycles_for_mean);         
            psa_asd_vecA(iA) = meanvalue(P_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_asd_vecA(iA) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_pa_asd_vecA(iA) = meanvalue(O2_plot(ipa,:), klokmax, T, dt, num_cycles_for_mean);
        end
    end
end


ns = (T/dt)*10;
Vtot = sum(V_plot, 1);      
fprintf('\n%s %f %s\n','Total blood volume is ', Vtot(end), ' liters');
fprintf('%s %f %s\n\n','Cardiac ouput is ', qs_asd_vecA(end), ' (L/min)');
fprintf('%s %f %s\n','Stroke volume from LV is ', 1000*(max(V_plot(iLV,(klokmax-ns+1):klokmax)) - min(V_plot(iLV,(klokmax-ns+1):klokmax))), ' mL');
fprintf('%s %f %s\n','Stroke volume from RV is ', 1000*(max(V_plot(iRV,(klokmax-ns+1):klokmax)) - min(V_plot(iRV,(klokmax-ns+1):klokmax))), ' mL');

fprintf('%s %f %s\n','Diastolic systemic arterial pressure is ', min(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n','Systolic systemic arterial pressure is ', max(P_plot(isa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n','Mean systemic arterial pressure is ', psa_asd_vecA(1), ' mmHg');

fprintf('%s %f %s\n','Diastolic pulmonary arterial pressure is ', min(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n','Systolic pulmonary arterial pressure is ', max(P_plot(ipa,(klokmax-ns+1):klokmax)), ' mmHg');
fprintf('%s %f %s\n\n','Mean pulmonary arterial pressure is ', ppa_asd_vecA(1), ' mmHg');

