scanPath=['/Users/nivtik/Research/Urine/Task_analysis/SPM12/Minimal_PreProc/Motor_L/rp_CAD_MOTOR_L.txt'];
file=textread(scanPath);
figure
plot(file(:,1),'b')
hold on
plot(file(:,2),'g')
hold on
plot(file(:,3),'r')
legend('x','y','z')