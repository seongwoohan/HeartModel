%script to plot results of computer simulation 
%of the entire circulation.
%left ventricular compliance, pressures, and flows:

figure(1);
subplot(3,1,1),plot(t_plot, C_plot(iLV,:));
title('Left Ventricular Compliance')
xlabel('Time (min)') 
ylabel('Compliance')

subplot(3,1,2),plot(t_plot, P_plot([ipv,iLV,isa],:));
title('Left Ventricular Pressure')
legend({'pulmonary vein P','left ventricular P','systemic arteria'},'Location', 'southwest')
xlabel('Time (min)')
ylabel('Pressure')

subplot(3,1,3),plot(t_plot,Q_plot([jMi,jAo],:));
title('Left Ventricular Blood Flow')
legend({'mitral valve Q','aortic valve Q'},'Location', 'northeast')
xlabel('Time (min)')
ylabel('Blood Flow')

%right ventricular compliance, pressures, and flows:
figure(2);
subplot(3,1,1),plot(t_plot,C_plot(iRV,:));
title('Right Ventricular Compliance')
xlabel('Time (min)')
ylabel('Compliance')

subplot(3,1,2),plot(t_plot,P_plot([isv,iRV,ipa],:));
legend({'systemic vein P','rigt ventricular P','pulmanory arteria'},'Location', 'southwest')
title('Right Ventricular Pressure')
xlabel('Time (min)')
ylabel('Pressure')

subplot(3,1,3),plot(t_plot,Q_plot([jTr,jPu],:));
title('Right Ventricular BloodFlow')
legend({'tricuspid valve Q','pulmonic valve Q'},'Location', 'northeast') 
xlabel('Time (min)') 
ylabel('Blood Flow')

%systemic and pulmonary flows:
figure(3);
plot(t_plot, Q_plot([js,jp],:));
title('Systemic and Pulmonary Blood Flow')
legend({'systemic circulation','pulmonary circulation'},'Location', 'northeast') 
xlabel('Time (min)') 
ylabel('Blood Flow')

%pressure-volume loops for both ventricles
figure(4);
subplot(2,1,1),plot(V_plot(iLV,:),P_plot(iLV,:));
title('Left Ventricular Pressure-Volume Loops')
xlabel('Volume') 
ylabel('Pressure')

subplot(2,1,2),plot(V_plot(iRV,:),P_plot(iRV,:));
title('Right Ventricular Pressure-Volume Loops')
xlabel('Volume') 
ylabel('Pressure')

