function u1 = nonlinear_control_law(v1,x1,x2,v2,v3)
No = 88; //Number of cells
Kh2 = 0.0000422; //Hydrogen valve constant kmol/(atm.s)
Ko2 = 0.0000211;//Oxygen valve constant kmol/ (atm.s)
tau_h2 =  3.37; //Hydrogen time constant(s)
tau_o2 =  6.74;//Oxygen time constant(s)
Rint = 0.00303;//Fuel cell internal resistance(ohms)
B = 0.04777;//Activation voltage constant(V)
C = 0.0136;//Activation constant parameter(1/A)
Eo = 0.6;//No load energy voltage associated with the reaction free-energy (V)
T = 343;//Fuel cell stack temperature (K)
F = 96.485e6;//Faraday's constant C/kmol
rho = 1.168;//Hydrogen-Oxygen flow ratio
Kr = No/(4*F);//Modelling constant kmol/(s.A)
R = 8314;//the universal gas constant that is equal to  J/(kmol.K)
HHV = 1.482 //Higher heating value potential (V)
uF = 0.95 //The fuel utilization
q_h2_in = 0.0004 //Molar flow of hydrogen kmol/s
q_o2_in = q_h2_in/rho //Molar flow of oxygen kmol/s

//reformer parmeters
U = 0.8 //Utilization factor
tau1 = 2 //reformer time constant(s)
tau2 = 2 //reformer time constant(s)
CV = 2 //conversion factor
Qmethref = 0.000015 //methane reference signal Kmol/s
k3 = 1/(2*CV)
k4 = k3/tau1

    u1 = (Kr*v3*(Kh2*tau_h2*x1 + 4*Ko2*tau_o2*x2))/(2*Ko2*tau_o2*x2) - (Kh2*tau_h2*v2*x1)/(2*Ko2*tau_o2*x2) + (2*F*Kh2*tau_h2*v1*x1)/(No*R*T) + (2*F*Kh2*tau_h2*x1*((No*R*T)/(2*F*tau_h2) + (No*R*T)/(4*F*tau_o2)))/(No*R*T)
endfunction
