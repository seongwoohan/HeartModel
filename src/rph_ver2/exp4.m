%% VSD 33.44

jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44; 

disease_state_pre = false
Rp_state = false;
disease_state = true;
do_exercise = true;
if (disease_state == true) 
    v_vec = 0.3 / 100;    
    for iVV = 1:length(v_vec)
        j_shunt = jvsd;
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

%% VSD 33.44

jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44; 

disease_state_pre = false
Rp_state = false;
disease_state = true;
do_exercise = true;
if (disease_state == true) 
    v_vec = 0.3 / 100;    
    for iVV = 1:length(v_vec)
        j_shunt = jvsd;
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
%% asd 16.8

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8; 

disease_state_pre = false
disease_state = true;
Rp_state = false;
do_exercise = true;
if (disease_state == true) 
    d_vec = 1 / 100;  
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

plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jasd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 1.8);
yline(0, '--b','linewidth', 2)
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
xlim([6.188 6.25])
ylim([-3 4])
grid on



%% elastance function 33.44
jasd=7;
jvsd=8;
jd=9;

m_vec = 33.44; 

disease_state_pre = false
disease_state = true;
Rp_state = false;
do_exercise = true;
if (disease_state == true) 
    Ashunt = 0;  
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = floor((T/dt)*10);
            dt=0.01*T
            klokmax=floor(10*T/dt)
            for klock=1:klokmax
                t=klock*dt;
                ELV(klock)=elastance(t,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum);
                ERV(klock)=elastance(t,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
                tsave(klock) = t;
            end
        end
    end  
end
%plot(tsave, ELV)
%plot(tsave((clockmax-((T/dt)*5)+1):clockmax), ELV((clockmax-((T/dt)*5)+1):clockmax), 'linewidth', 1.8);
plot(tsave((klokmax-((T/dt)*5)+1):klokmax), ELV((klokmax-((T/dt)*5)+1):klokmax), 'linewidth', 1.8);


%% VSD 16.8
%{
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
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = floor((T/dt)*10); 
        end
    end  
end 

%% potts shunt 16.8

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8; 

disease_state_pre = false
disease_state = true;
Rp_state = false;
do_exercise = true;
if (disease_state == true) 
    d_vec = 0.3 / 100;  
    for iDD = 1:length(d_vec)
        j_shunt = jd;
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
%}

f(1) = figure;
subplot(3,1,1),plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 1.8);
title('Ventricular Septal Defect (m = 33.44)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
yline(0, '--b','linewidth', 2)
xlim([5.176, 5.228])
%xlim([6.188 6.25])
ylim([-2 1.5])
subplot(3,1,2),plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*5)+1):klokmax)), 'linewidth', 1.8);
set(gca,'FontSize',23)
title('Potts Shunt (m = 16.8)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
xlim([5.176, 5.228])
%xlim([6.188 6.25])
ylim([-3 1.5])
subplot(3,1,3),

figure(100)
plot(tsave((clockmax-((T/dt)*5)+1):clockmax), ELV((clockmax-((T/dt)*5)+1):clockmax), 'linewidth', 1.8);


f(2) = figure
subplot(5,1,1), plot(O2_plot(iRA,:))
title('RA')
ylim([5 10])
subplot(5,1,2), plot(O2_plot(iLA,:))
title('LA')
ylim([5 10])
subplot(5,1,3), plot(O2_plot(ipv,:))
title('pv')
ylim([5 10])
subplot(5,1,4), plot(O2_plot(isv,:))
title('sv')
ylim([5 10])
subplot(5,1,5), plot(O2_plot(isa,:))
title('sa')
ylim([5 10])

f(3) = figure
plot(O2_plot(iLA,:)); hold on 
plot(O2_plot(isa,:));
plot(O2_plot(iLV,:));
legend({'LA','sa','LV'},'Location', 'best', 'Box','off')
set(gca,'FontSize',10)



sub


