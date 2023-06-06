
//Voltage plot
subplot(4,1,1)
plot(itsmc.time,itsmc.values(:,2),'r')
set(gca(),"auto_clear","off")
plot(smc.time,smc.values(:,2),'g')
set(gca(),"auto_clear","off")
plot(smc.time,smc.values(:,1),'b')
legend('ITSMC','CSMC','Reference')
title('Fuel Cell Stack Voltage(V)')

////Nominal Component of the Control Input
//subplot(4,1,2)
//plot(itsmc.time,itsmc.values(:,3),'r')
//set(gca(),"auto_clear","off")
//plot(smc.time,smc.values(:,3),'g')
//set(gca(),"auto_clear","off")
//legend('ITSMC','CSMC')
//title('Nominal Component of the Control Input')
//
////Switching Component of the Control Input
//subplot(4,1,3)
//plot(itsmc.time,itsmc.values(:,4),'r')
//set(gca(),"auto_clear","off")
//plot(smc.time,smc.values(:,4),'g')
//set(gca(),"auto_clear","off")
//legend('ITSMC','CSMC')
//title('Switching Component of the Control Input')

//Control Input- Hydrogen Flow Rate
subplot(4,1,2)
plot(itsmc.time,itsmc.values(:,5),'r')
set(gca(),"auto_clear","off")
plot(smc.time,smc.values(:,5),'g')
set(gca(),"auto_clear","off")
legend('ITSMC','CSMC')
title('Control Input- Hydrogen Flow Rate')

//Control Input- Hydrogen Flow Rate
subplot(4,1,3)
plot(itsmc.time,itsmc.values(:,6),'r')
set(gca(),"auto_clear","off")
plot(smc.time,smc.values(:,6),'g')
set(gca(),"auto_clear","off")
legend('ITSMC','CSMC')
title('Control Input- Oxygen Flow Rate')

//Sliding Manifold
subplot(4,1,4)
plot(itsmc.time,itsmc.values(:,9),'r')
set(gca(),"auto_clear","off")
plot(smc.time,smc.values(:,9),'g')
set(gca(),"auto_clear","off")
legend('ITSMC','CSMC')
title('The Sliding Manifold')
