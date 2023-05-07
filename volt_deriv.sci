function x4d = volt_deriv(x1,x2,x3,u)
tau_h = 3.37 //hydrogen flow rise time(s)
a1 = -1/tau_h
N = 500 //Number of cells in series
F = 96.485e6 //Faraday's constant Ckmol
Kr = N/(4*F)
Kh2 = 5.28e-5 //valve molar constants for hydrogen(kmol/s atm)
a2 = (-2*Kr)/(tau_h*Kh2)
b1 = 1/(Kh2*tau_h)
tau_o = 6.74 //response time(s) for oxygen flow
a3 = -1/tau_o
Ko2 = 10.55e-5 //valve molar constants for oxygen
a4 = -Kr/(Ko2*tau_o)
Rho = 1.145 //ratio of oxygen/hydrogen consumption
b2 = 1/(Ko2*Rho*tau_o)


R = 8314//universal gas constant J/kmol/K
Tc = 70 //celsius value of temperature
T = 273.15+Tc//absolute temperatue(K)celsuis to kelvin K
K1 = (N*R*T)/(2*F)
A = 0.03 //a constant value with units of Volts
K2 = N*A
m = 2.11e-5 //a constant value unit of volts(V)
K3 = N*m
R_load = 1 //Kohms the load resistance
r = 2.45e-4 //Kohms.cm^2 the resistance of each fuel cell cell's electrical circit including the mebrane and various interconnections
a = 400 //cm^2 the active surface area of the cell
K4 = (N*r)/(R_load*a)
n = 8e-3 //a constant value cm^2/mA

io = 0.04 //mA/cm^2 the density of some reference current
Eo = (N*1.229)+(K2*log(io*a))//(V)Standard open circuit voltage (V)
Io = 47e3 //initial current(A)    


[i, inf, nan] = (%i, %inf, %nan);

    first_num = 1
    first_denum = 1 + K4 + (K2/(R_load*x3)) + (K3*n*exp(n*x3/a))/(R_load*a)
    first = first_num/(first_denum)
    second = (K1*a1)+(K1*a2*x3/x1) + (K1*b1*u/x1) + (K1*a3/2) + (K1*a4*x3/(2*x2)) + (K1*b2*u/(2*x2))
    x4d = first*second
    fallback = 1e-10
    if isinf(x4d) | isnan(x4d)  then
        x4d = fallback
    end
    
endfunction
