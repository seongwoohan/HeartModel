%% elastance function 16.8, 33.44
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
            ELV(iDD) = meanvalue(ELV(clock), klokmax, T, dt, num_cycles_for_mean);
%             tmax=10*T;
%             klockmax =3000;
%             dt=tmax/klockmax;
%             for klock=1:klockmax
%                 t=klock*dt;
%                 ELV(klock)=elastance(t,T,0,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum);
%                 ERV(klock)=elastance(t,T,0,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
%                 ELA(klock)=elastance(t,T,t_atrial_delay,tau1A,tau2A,m1A,m2A,EminLA,EmaxLA,maxnumA);
%                 ERA(klock)=elastance(t,T,t_atrial_delay,tau1A,tau2A,m1A,m2A,EminRA,EmaxRA,maxnumA);
%                 tsave(klock) = t;
%             end
        end
    end  
end
plot(tsave((clockmax-((T/dt)*5)+1):clockmax), ELV((clockmax-((T/dt)*5)+1):clockmax), 'linewidth', 1.8);
figure(1)
plot(tsave((klokmax-((T/dt)*5)+1):klokmax), ELV((klokmax-((T/dt)*5)+1):klokmax), 'linewidth', 1.8);
title('Elastance LV (exercise)','FontWeight','Normal')
yline(0, '--b','linewidth', 2)
xlabel('Time (min)') 
ylabel('Elastance (mmHg/L)')
set(gca,'FontSize',18)
%xlim([6.188 6.25])
%xlim([5.176, 5.228])
%ylim([-3 3])
grid on

figure(2)
plot(tsave((klokmax-((T/dt)*5)+1):klokmax), ERV((klokmax-((T/dt)*5)+1):klokmax), 'linewidth', 1.8);
title('Elastance RV (exercise)','FontWeight','Normal')
yline(0, '--b','linewidth', 2)
xlabel('Time (min)') 
ylabel('Elastance (mmHg/L)')
set(gca,'FontSize',18)
%xlim([6.188 6.25])
xlim([5.176, 5.228])
grid on

figure(3)
plot(tsave((klokmax-((T/dt)*5)+1):klokmax), ELA((klokmax-((T/dt)*5)+1):klokmax), 'linewidth', 1.8);
title('Elastance LA (exercise)','FontWeight','Normal')
yline(0, '--b','linewidth', 2)
xlabel('Time (min)') 
ylabel('Elastance (mmHg/L)')
set(gca,'FontSize',18)
%xlim([6.188 6.25])
xlim([5.176, 5.228])
grid on

figure(4)
plot(tsave((klokmax-((T/dt)*5)+1):klokmax), ERA((klokmax-((T/dt)*5)+1):klokmax), 'linewidth', 1.8);
title('Elastance RA (exercise)','FontWeight','Normal')
yline(0, '--b','linewidth', 2)
xlabel('Time (min)') 
ylabel('Elastance (mmHg/L)')
set(gca,'FontSize',18)
%xlim([6.188 6.25])
xlim([5.176, 5.228])
grid on

%%%%%%%%%%
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
        
        num_cylces_for_mean = 5;
        
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
figure(1)
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jvsd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 1.8);
title('Ventricular Septal Defect (rest)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
yline(0, '--b','linewidth', 2)
yline(meanvalue(Q_plot(jvsd,:), klokmax, T, dt, num_cycles_for_mean), '-k','linewidth', 2)
%xlim([5.176, 5.228])
xlim([6.188 6.25])
%ylim([-0.5 2.5])
ylim([-2 2])
grid on

%% PS 33.44

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
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*5)+1):klokmax)),'linewidth', 1.8);
title('Potts Shunt (exercise)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
yline(0, '--b','linewidth', 2)
yline(meanvalue(Q_plot(jd,:), klokmax, T, dt, num_cycles_for_mean), '-k','linewidth', 2)
xlim([5.176, 5.228])
%xlim([6.188 6.25])
ylim([-2.5 1.5])
grid on

%% elastance function 

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8; 

disease_state_pre = false;
disease_state = true;
Rp_state = false;
do_exercise = true;
if (disease_state == true) 
    d_vec = 0 / 100;  
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

figure(99)
subplot(2,1,1),plot(tsave,ELV,tsave,ERV,'linewidth', 1.5)
title('Elastance: RPH','FontWeight','Normal') %,'FontWeight','Normal'
ylim([0 3000]) 
xlim([0.085 0.125])
legend({'LV','RV'},'Location', 'northeast') 
legend boxoff
ylabel('Elastance (mmHg/L)')
set(gca,'FontSize',17)
subplot(2,1,2),plot(tsave,ELA,tsave,ERA,'linewidth', 1.5)
ylim([0 3000]) 
xlim([0.085 0.125])
legend({'LA','RA'},'Location', 'best') 
legend boxoff
xlabel('Time (min)') 
<<<<<<< HEAD
ylabel('Elastance (mmHg/L)')
set(gca,'FontSize',17)
=======
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',18)
xlim([6.188 6.25])
ylim([-3 3])
grid on

>>>>>>> 1ceb2fd9229b3cfd925e0d4f2ea2cc251f22dd0f

figure(100)
plot(tsave,ELV,tsave,ERV,tsave,ELA,tsave,ERA,'linewidth', 1.5)
title('Elastance: RPH','FontWeight','Normal') %,'FontWeight','Normal'
ylim([0 3000]) 
xlim([0.085 0.125])
legend({'LV','RV', 'LA', 'RA'},'Location', 'northeast') 
legend boxoff
ylabel('Elastance (mmHg/L)')
set(gca,'FontSize',17)
%% asd 16.8

jasd=7;
jvsd=8;
jd=9;

m_vec = 16.8;

disease_state_pre = false;
disease_state = false;
Rp_state = false;
do_exercise = true;
if (disease_state == false) 
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
title('Atrial Septal Defect (rest)','FontWeight','Normal')
yline(0, '--b','linewidth', 2)
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
yline(meanvalue(Q_plot(jasd,:), klokmax, T, dt, num_cycles_for_mean), '-k','linewidth', 2)
set(gca,'FontSize',18)
xlim([6.188 6.25])
%xlim([5.176, 5.228])
%ylim([-3 3]) -1.1, -1.6
ylim([-1.6 0.1])
grid on




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

f(2) = figure;
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jd,((klokmax-((T/dt)*5)+1):klokmax)), 'linewidth', 1.8);
set(gca,'FontSize',23)
title('Potts Shunt (m = 16.8)','FontWeight','Normal')
xlabel('Time (min)') 
ylabel('Blood Flow (L/min)')
set(gca,'FontSize',20)
yline(0, '--b','linewidth', 2)
xlim([5.176, 5.228])
%xlim([6.188 6.25])
ylim([-3 1.5])


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
set(gca,'FontSize',10)


f(3) = figure
plot(O2_plot(iLA,:)); hold on 
plot(O2_plot(isa,:));
plot(O2_plot(iLV,:));
legend({'LA','sa','LV'},'Location', 'best', 'Box','off')
set(gca,'FontSize',10)



f(4) = figure
plot(t_plot((klokmax-((T/dt)*5)+1):klokmax), Q_plot(jMi,((klokmax-((T/dt)*5)+1):klokmax)), 'linewidth', 1.8);



