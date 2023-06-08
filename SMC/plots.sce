//First Figure
scf(1)
clf(1)
//Fuel Cell Load Current Plot
plot(smc.time,smc.values(:,7),'r', 'LineWidth',3)
h = gca();
h.box = 'on';
h.data_bounds = [0,15;100,35]
title('Fuel Cell Load Current Profile (A)','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('Current(A)','fontname',4)


//Second Figure
scf(2)
clf(2)
//PLOTS FOR THE CONVENTIONAL SMC
//Voltage plots comparison between signum and saturation based switching
subplot(4,1,1)
plot(smc.time,smc.values(:,2),'r','LineWidth',3)
a = gca()
zoom_rect(a,[10,23.8,100,24.2]) //zooms into plot
set(gca(),"auto_clear","off")

plot(smc_sat.time,smc_sat.values(:,2),'g','LineWidth',4)
set(gca(),"auto_clear","off")

plot(smc.time,smc.values(:,1),'b','LineWidth',1)
legend('$sgn(s)$','$sat\frac{s}{\phi}$','$Reference$')
title('Fuel Cell Stack Voltage(V)','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('Voltage(V)','fontname',4)

//Error plots comparison between signum and saturation based switching
subplot(4,1,2)
plot(smc.time,smc.values(:,8),'r','LineWidth',3)
b = gca()
set(gca(),"auto_clear","off")
zoom_rect(b,[10,-0.15,100,0.1]) //zooms into plot
plot(smc_sat.time,smc_sat.values(:,8),'g','LineWidth',4)
set(gca(),"auto_clear","off")
plot(smc.time,smc.values(:,1)*0,'black','LineWidth',1)
legend('$sgn(s)$','$sat\frac{s}{\phi}$')
title('Error','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('Error','fontname',4)

//Control Input- Hydrogen Flow Rate
subplot(4,1,3)
plot(smc.time,smc.values(:,5),'r','LineWidth',2)
set(gca(),"auto_clear","off")
plot(smc_sat.time,smc_sat.values(:,5),'g','LineWidth',4)
legend('$sgn(s)$','$sat\frac{s}{\phi}$')
title('Control Input u1 - Molar Flow of Hydrogen','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('u1(kmol/s)','fontname',4)

//Control Input- Oxygen Flow Rate
subplot(4,1,4)
plot(smc.time,smc.values(:,6),'r','LineWidth',2)
set(gca(),"auto_clear","off")
plot(smc_sat.time,smc_sat.values(:,6),'g','LineWidth',4)
legend('$sgn(s)$','$sat\frac{s}{\phi}$')
title('Control Input u2 - Molar Flow of Oxygen','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('u2(kmol/s)','fontname',4)


//Third Figure
scf(3)
clf(3)
//PLOTS FOR THE INTEGRAL TERMINAL SMC
//Voltage plots comparison between signum and saturation based switching
subplot(4,1,1)
plot(itsmc.time,itsmc.values(:,2),'r','LineWidth',3)
c = gca()
zoom_rect(c,[10,23.7,100,24.3]) //zooms into plot
set(gca(),"auto_clear","off")

plot(itsmc_sat.time,itsmc_sat.values(:,2),'g','LineWidth',4)
set(gca(),"auto_clear","off")

plot(itsmc.time,itsmc.values(:,1),'b','LineWidth',1)
legend('$sgn(s)$','$sat\frac{s}{\phi}$','$Reference$')
title('Fuel Cell Stack Voltage(V)','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('Voltage(V)','fontname',4)

//Error plots comparison between signum and saturation based switching
subplot(4,1,2)
plot(itsmc.time,itsmc.values(:,8),'r','LineWidth',3)
d = gca()
set(gca(),"auto_clear","off")
zoom_rect(d,[10,-0.2,100,0.25]) //zooms into plot
plot(itsmc_sat.time,itsmc_sat.values(:,8),'g','LineWidth',4)
set(gca(),"auto_clear","off")
plot(itsmc.time,itsmc.values(:,1)*0,'black','LineWidth',1)
legend('$sgn(s)$','$sat\frac{s}{\phi}$')
title('Error','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('Error','fontname',4)

//Control Input- Hydrogen Flow Rate
subplot(4,1,3)
plot(itsmc.time,itsmc.values(:,5),'r','LineWidth',2)
set(gca(),"auto_clear","off")
plot(itsmc_sat.time,itsmc_sat.values(:,5),'g','LineWidth',4)
legend('$sgn(s)$','$sat\frac{s}{\phi}$')
title('Control Input u1- Molar Flow of Hydrogen}','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('u1(kmol/s)','fontname',4)

//Control Input- Oxygen Flow Rate
subplot(4,1,4)
plot(itsmc.time,itsmc.values(:,6),'r','LineWidth',2)
set(gca(),"auto_clear","off")
plot(itsmc_sat.time,itsmc_sat.values(:,6),'g','LineWidth',4)
legend('$sgn(s)$','$sat\frac{s}{\phi}$')
title('Control Input u2 - Molar Flow of Oxygen','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('u2(kmol/s)','fontname',4)



//Fourth Figure
scf(4)
clf(4)
//Error Comparison between CSMC AND ITSMC
plot(smc_sat.time,smc_sat.values(:,8),'r','LineWidth',3)
c = gca()
zoom_rect(c,[10,-0.2,100,0.25]) //zooms into plot
set(gca(),"auto_clear","off")

plot(itsmc_sat.time,itsmc_sat.values(:,8),'g','LineWidth',4)
set(gca(),"auto_clear","off")

plot(itsmc.time,itsmc.values(:,1)*0,'black','LineWidth',1)
legend('conventional SMC',' integral SMC')
title('Error Comparison between saturation switched conventional and integral SMC','fontname',4)
xlabel('Time(s)','fontname',4)
ylabel('Error','fontname',4)
