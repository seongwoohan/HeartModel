% Excercise equation
% HR = 0.94 * (M - M0) + 80 (beats/min)
% M0 = 16.8 (mmol/min)
% 100 (mmHg) / (0.07 * HR) = Rs

M = (16.8 : 4.16 : 100) % roughly gives 20 data points 
HR = 0.94 * (M - 16.8) + 80
Rs = 100 ./ (0.07 * HR)

figure(1000)
plot(M, HR, '-ro','linewidth', 2)
set(gca,'FontSize',25)
title('Oxygen delivery vs Heart rate','FontSize',22,'FontWeight','Normal')                 
xlabel('Oxgyen consumption (mmol/min)','FontSize', 22) 
ylabel('Heart rate (beat/min)','FontSize', 22)
xlim([16.8 100])
grid on

figure(2000)
plot(HR, Rs, '-bo','linewidth', 2)
set(gca,'FontSize',25)
title('Heart rate vs Systemic resistance','FontSize',22,'FontWeight','Normal')               
xlabel('Heart rate (beat/min)','FontSize', 22) 
ylabel('Systemic resistance (mmHg/(L/min)','FontSize', 22)
grid on
