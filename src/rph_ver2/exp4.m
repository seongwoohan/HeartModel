%% elastance function 16.8, 33.44
jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44; 
num_cycles_for_mean = 5

disease_state_pre = false
disease_state = true;
Rp_state = false;
do_exercise = true;

if (disease_state == true) 
    Ashunt = 0;  
    j_shunt = jd;
    for iEE = 1:length(m_vec)
        m_set = m_vec(iEE);
        HR_set = 0.94 * (m_set - 16.8) + 80;
        Rs_set = (17.5 * 80)/HR_set;
        circ;
        ns = floor((T/dt)*10);
    end  
end


figure(1)
%plot(t_plot((klokmax-((T/dt))+1):klokmax), 1./C_plot(iLV,(klokmax-((T/dt))+1):klokmax), t_plot((klokmax-((T/dt))+1):klokmax), 1./C_plot(iRV,(klokmax-((T/dt))+1):klokmax),t_plot((klokmax-((T/dt))+1):klokmax), 1./C_plot(iLA,(klokmax-((T/dt))+1):klokmax),t_plot((klokmax-((T/dt))+1):klokmax), 1./C_plot(iRA,(klokmax-((T/dt))+1):klokmax),'linewidth', 1.8);
plot(t_plot((klokmax-((T/dt)*100)+1):klokmax), 1./C_plot(iLV,(klokmax-((T/dt)*100)+1):klokmax), '-.', t_plot((klokmax-((T/dt)*100)+1):klokmax), 1./C_plot(iRV,(klokmax-((T/dt)*100)+1):klokmax), '-.',t_plot((klokmax-((T/dt)*100)+1):klokmax), 1./C_plot(iLA,(klokmax-((T/dt)*100)+1):klokmax),t_plot((klokmax-((T/dt)*100)+1):klokmax), 1./C_plot(iRA,(klokmax-((T/dt)*100)+1):klokmax),'linewidth', 1.8);
title('Elastance function (exercise)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Elastance (mmHg/L)')
%xlim([6.188 6.25])
xlim([5.176, 5.228])
%xlim([5.176, 5.33])
legend({'LV','RV', 'LA','RA'},'Location', 'northeast') 
legend boxoff
ax = gca;
ax.YAxis.Exponent = 3;
set(gca,'FontSize',18)
%ylim([-3 3])
grid on

%% VSD 33.44

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8; 

disease_state_pre = false
Rp_state = false;
disease_state = true;
do_exercise = true;
if (disease_state == true) 
    v_vec = 0.3 / 100;    
    for iVV = 1:length(v_vec)
        j_shunt = jvsd;
        Ashunt = v_vec(iVV);
        
        %num_cylces_for_mean = 5;
        
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = floor((T/dt)*10); 
        end
    end  
end 
% meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean)
figure(2)
plot(t_plot((klokmax-((T/dt)*100)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*100)+1):klokmax)),'linewidth', 1.8);
title('Ventricular Septal Defect (rest)','FontWeight','Normal')
%title('Ventricular Septal Defect (exercise)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
yline(0, '--b','linewidth', 2)
yline(meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean), '-k','linewidth', 2)
xlim([5.176, 5.228])
%xlim([6.188 6.25])
ylim([-2 1.5])
%ylim([-0.5 2])
grid on

%% PS 33.44

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8%33.44; 

disease_state_pre = false
Rp_state = false;
disease_state = true;
do_exercise = true;
if (disease_state == true) 
    v_vec = 0.3 / 100;    
    for iVV = 1:length(v_vec)
        j_shunt = jd;
        Ashunt = v_vec(iVV);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = floor((T/dt)*10); 
        end
    end  
end 

figure(2)
plot(t_plot((klokmax-((T/dt)*100)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*100)+1):klokmax)),'linewidth', 1.8);
title('Potts Shunt (rest)','FontWeight','Normal')
%title('Potts Shunt (rest)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
yline(0, '--b','linewidth', 2)
yline(meanvalue(Q_plot(jd,:), klokmax, T, dt, num_cycles_for_mean), '-k','linewidth', 2)
xlim([5.176, 5.228])
%xlim([6.188 6.25])
ylim([-2.5 1.5])
grid on

%% asd 16.8

jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44;
num_cycles_for_mean = 5

disease_state_pre = false;
disease_state = true;
Rp_state = false;
do_exercise = true;
if (disease_state == true) 
    d_vec = 0.3 / 100;  
    for iDD = 1:length(d_vec)
        j_shunt = jasd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = floor((T/dt)*10);
        end
    end  
end

figure(10)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jasd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 1.8);
%title('Atrial Septal Defect (rest)','FontWeight','Normal')
title('Atrial Septal Defect (exercise)','FontWeight','Normal')
yline(0, '--b','linewidth', 2)
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
yline(meanvalue(Q_plot(jasd,:), klokmax, T, dt, num_cycles_for_mean), '-k','linewidth', 2)
set(gca,'FontSize',18)
%xlim([6.188 6.25])
xlim([5.176, 5.228])
ylim([-0.8 0.8]) 
grid on



