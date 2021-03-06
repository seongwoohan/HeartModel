tic

jasd=7;
jvsd=8;
jd=9;

m_vec = (16.8 : 16.64 : 100);
ncase_dm = length(m_vec);

num_cycles_for_mean = 5;

disease_state = true;
do_exercise = true;
if (disease_state == true) 
  d_vec = 0.01 / 100;
    oxy_sv_ps_one = zeros(1, ncase_dm);
    oxy_sa_ps_one = zeros(1, ncase_dm); 
    qs_ps_one = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_one(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_one(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_one(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end

if (disease_state == true)
  d_vec = 0.02 / 100;
    oxy_sv_ps_two = zeros(1, ncase_dm);
    oxy_sa_ps_two = zeros(1, ncase_dm); 
    qs_ps_two = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_two(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_two(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_two(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end

if (disease_state == true)
  d_vec = 0.03 / 100;
    oxy_sv_ps_three = zeros(1, ncase_dm);
    oxy_sa_ps_three = zeros(1, ncase_dm); 
    qs_ps_three = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_three(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_three(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_three(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end 
end

if (disease_state == true)
  d_vec = 0.04 / 100;
    oxy_sv_ps_four = zeros(1, ncase_dm);
    oxy_sa_ps_four = zeros(1, ncase_dm); 
    qs_ps_four = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_four(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_four(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_four(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end 
end

if (disease_state == true)
  d_vec = 0.05 / 100;
    oxy_sv_ps_five = zeros(1, ncase_dm);
    oxy_sa_ps_five = zeros(1, ncase_dm); 
    qs_ps_five = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_five(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_five(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_five(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end

if (disease_state == true)
  d_vec = 0.06 / 100;
    oxy_sv_ps_six = zeros(1, ncase_dm);
    oxy_sa_ps_six = zeros(1, ncase_dm); 
    qs_ps_six = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_six(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_six(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_six(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end

if (disease_state == true)
  d_vec = 0.07 / 100;
    oxy_sv_ps_seven = zeros(1, ncase_dm);
    oxy_sa_ps_seven = zeros(1, ncase_dm); 
    qs_ps_seven = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_seven(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_seven(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_seven(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end

if (disease_state == true)
  d_vec = 0.08 / 100;
    oxy_sv_ps_eight = zeros(1, ncase_dm);
    oxy_sa_ps_eight = zeros(1, ncase_dm); 
    qs_ps_eight = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_eight(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_eight(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_eight(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end

if (disease_state == true)
  d_vec = 0.09 / 100;
    oxy_sv_ps_nine = zeros(1, ncase_dm);
    oxy_sa_ps_nine = zeros(1, ncase_dm); 
    qs_ps_nine = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_nine(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_nine(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_nine(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end

if (disease_state == true)
  d_vec = 0.1 / 100;
    oxy_sv_ps_ten = zeros(1, ncase_dm);
    oxy_sa_ps_ten = zeros(1, ncase_dm); 
    qs_ps_ten = zeros(1, ncase_dm);
    for iDD = 1:length(d_vec)
        j_shunt = jd;
        Ashunt = d_vec(iDD);
        for iEE = 1:length(m_vec)
            m_set = m_vec(iEE);
            HR_set = 0.94 * (m_set - 16.8) + 80;
            Rs_set = (17.5 * 80)/HR_set;
            circ;
            ns = (T/dt)*10;  
            oxy_sv_ps_ten(iEE) = meanvalue(O2_plot(isv,:), klokmax, T, dt, num_cycles_for_mean);
            oxy_sa_ps_ten(iEE) = meanvalue(O2_plot(isa,:), klokmax, T, dt, num_cycles_for_mean);
            qs_ps_ten(iEE) = meanvalue(Q_plot(js,:), klokmax, T, dt, num_cycles_for_mean);
        
        end
    end
end
toc

figure(2000)
plot(m_vec, 10*oxy_sa_ps_one, '-o', m_vec, 10*oxy_sa_ps_two, '-o', m_vec, 10*oxy_sa_ps_three, '-o', m_vec, 10*oxy_sa_ps_four, '-o', m_vec, 10*oxy_sa_ps_five, '-o', m_vec, 10*oxy_sa_ps_six, '-o', m_vec, 10*oxy_sa_ps_seven, '-o', m_vec, 10*oxy_sa_ps_eight, '-o', m_vec, 10*oxy_sa_ps_nine, '-o', m_vec, 10*oxy_sa_ps_ten, '-o','linewidth', 1.5)
set(gca,'FontSize',20)
title('Potts shunt systemic artery','FontWeight','Normal')
legend({'0.01cm^2','0.02cm^2','0.03cm^2','0.04cm^2','0.05cm^2','0.06cm^2','0.70cm^2','0.08cm^2','0.09cm^2','0.1cm^2'},'Location', 'best','FontSize',12)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
ylim([98 100.2])
grid on

figure(2001)
plot(m_vec, 10*oxy_sv_ps_one, '-o', m_vec, 10*oxy_sv_ps_two, '-o', m_vec, 10*oxy_sv_ps_three, '-o', m_vec, 10*oxy_sv_ps_four, '-o', m_vec, 10*oxy_sv_ps_five, '-o', m_vec, 10*oxy_sv_ps_six, '-o', m_vec, 10*oxy_sv_ps_seven, '-o', m_vec, 10*oxy_sv_ps_eight, '-o', m_vec, 10*oxy_sv_ps_nine, '-o', m_vec, 10*oxy_sv_ps_ten, '-o','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Potts shunt systemic vein','FontWeight','Normal')
legend({'0.01cm^2','0.02cm^2','0.03cm^2','0.04cm^2','0.05cm^2','0.06cm^2','0.70cm^2','0.08cm^2','0.09cm^2','0.1cm^2'},'Location', 'best','FontSize',12)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen Saturation (%)')
xlim([16.8 100])
grid on

figure(2002)
plot(m_vec, qs_ps_one.*oxy_sa_ps_one, '-o', m_vec, qs_ps_two.*oxy_sa_ps_two, '-o', m_vec, qs_ps_three.*oxy_sa_ps_three, '-o', m_vec, qs_ps_four.*oxy_sa_ps_four, '-o', m_vec, qs_ps_five.*oxy_sa_ps_five, '-o', m_vec, qs_ps_six.*oxy_sa_ps_six, '-o', m_vec, qs_ps_seven.*oxy_sa_ps_seven, '-o', m_vec, qs_ps_eight.*oxy_sa_ps_eight, '-o', m_vec, qs_ps_nine.*oxy_sa_ps_nine, '-o', m_vec, qs_ps_ten.*oxy_sa_ps_ten, '-o','linewidth', 1.5)
set(gca,'FontSize',20)
title('Potts shunt systemic artery','FontWeight','Normal')
legend({'0.01cm^2','0.02cm^2','0.03cm^2','0.04cm^2','0.05cm^2','0.06cm^2','0.70cm^2','0.08cm^2','0.09cm^2','0.1cm^2'},'Location', 'best','FontSize',12)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen delivery (moml/min)')
xlim([16.8 100])
grid on

figure(2003)
plot(m_vec, qs_ps_one.*oxy_sv_ps_one, '-o', m_vec, qs_ps_two.*oxy_sv_ps_two, '-o', m_vec, qs_ps_three.*oxy_sv_ps_three, '-o', m_vec, qs_ps_four.*oxy_sv_ps_four, '-o', m_vec, qs_ps_five.*oxy_sv_ps_five, '-o', m_vec, qs_ps_six.*oxy_sv_ps_six, '-o', m_vec, qs_ps_seven.*oxy_sv_ps_seven, '-o', m_vec, qs_ps_eight.*oxy_sv_ps_eight, '-o', m_vec, qs_ps_nine.*oxy_sv_ps_nine, '-o', m_vec, qs_ps_ten.*oxy_sv_ps_ten, '-o','linewidth', 1.5)
yline(0, '--b','linewidth', 2)
set(gca,'FontSize',20)
title('Potts shunt systemic vein','FontWeight','Normal')
legend({'0.01cm^2','0.02cm^2','0.03cm^2','0.04cm^2','0.05cm^2','0.06cm^2','0.70cm^2','0.08cm^2','0.09cm^2','0.1cm^2'},'Location', 'best','FontSize',12)
legend boxoff
xlabel('Oxgyen consumption (mmol/min)')
ylabel('Oxygen delivery (moml/min)')
xlim([16.8 100])
grid on