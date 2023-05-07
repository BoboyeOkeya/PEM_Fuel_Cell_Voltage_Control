clear;clc
//This function needs to be executed first, since the Xcos file needs it to run
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
R_load = 1e3 //Kohms the load resistance
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


//define the objective function where the design variables are the PID gains
function cost = objective_func(params)
    
    // Extract the PID gains from the parameters vector
//    Kp = params(1)
//    Ki = params(2)
//    Kd = params(3)
    
    //Assign the params to their optimal values in the workspace
    global Kp_opt
    global Ki_opt
    global Kd_opt
    Kp_opt = params(1)
    Ki_opt = params(2)
    Kd_opt = params(3)
    
    
    //Set the gains that will be sent to the Xcos simulator
    global time
    global Kp
    global Ki
    global Kd
len_time = length(time)
Kp.time = time
Kp.values = Kp_opt*ones(len_time,1)
Ki.time = time
Ki.values = Ki_opt*ones(len_time,1)
Kd.time = time
Kd.values = Kd_opt*ones(len_time,1)
    
    //Simulate the Xcos diagram
    importXcosDiagram('fuel_cell.zcos')
    typeof(scs_m) //The diagram data structure
    [Info, status] = xcos_simulate(scs_m, 4)
    
    //calculate the mean square error MSE
    squared_error = PID_error.values
    sys_time = PID_error.time
    cost = sum(squared_error)/(length(squared_error)) //sum_of_sqaure_error    
disp(cost)
    //
    
endfunction





//define the global gains to sent to Xcos
global Kp
global Ki
global Kd
//Define global optimal values
global Kp_opt
global Ki_opt
global Kd_opt
//Initialize these optimal values
Kp_opt=0
Ki_opt=0
Kd_opt=0

//Define the gains in a structure that aligns with Xcos
global time
sim_time = 100//THIS SHOULD BE CHANGED EACH TIME you change simulation time
time = (0:0.1:sim_time)'
//len_time = length(time)
//Kp.time = time
//Kp.values = Kp_opt*ones(len_time,1)
//Ki.time = time
//Ki.values = Ki_opt*ones(len_time,1)
//Kd.time = time
//Kd.values = Kd_opt*ones(len_time,1)

//Define the PID error
global PID_error

//-((a2*1e4)+(b1*1e4))/a1
//-((a4*1e4)+(b2*1e4))/a3


//////////////////////////////////
//Testing The objective function
//test = [1,2,3]
//f = objective_func(test);
//////////////////////////////////////


// Define the genetic algorithm parameters
PopSize     = 100;
Proba_cross = 0.7;
Proba_mut   = 0.1;
NbGen       = 10;
NbCouples   = 110;
Log         = %T;


// Parameters to control the initial population.
//ga_params = init_param(['Kp_opt',Kp_opt,'Ki_opt',Ki_opt,'Kd_opt',Kd_opt]);
ga_params = init_param();
//ga_params = add_param(ga_params);
ga_params = add_param(ga_params,'minbound',[0;0;0]);
ga_params = add_param(ga_params,'maxbound',[1;10;10]);
ga_params = add_param(ga_params,'dimensions',3);

// Run the genetic algorithm optimization
[pop_opt, fobj_pop_opt] = optim_ga(objective_func,PopSize,NbGen,Proba_mut,Proba_cross,Log,ga_params)

//Run the simulation again with the optimized parameters


// Load the Xcos diagram containing the plant and PID controller blocks
//importXcosDiagram('fuel_cell.zcos')
//typeof(scs_m) //The diagram data structure
//[Info, status] = xcos_simulate(scs_m, 4)


