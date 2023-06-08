# SLIDING MODE CONTROLLER FOR THE VOLTAGE CONTROL OF A FUEL CELL.


## Brief Description
This folder contains the sliding mode control (SMC) designed for a PEM fuel cell model based on the [Padulles Model1](https://github.com/BoboyeOkeya/PEM_Fuel_Cell_Voltage_Control). 

The SMC control is designed to act as the non-linear controller for the linearized system. The control diagram is as shown below:

XXXXX

Furthermore, I have designed two main types of SMC-based controllers in the repository:

**a. The conventional sliding mode control[1][2]:** Where I used two types of switching function, namely, the signum of the sliding manifold (`sign(s)`) and a saturation function. The details of these two switching functions are provided in the sections below.

**b. The integral terminal sliding mode control[2]:** Where I also used two types of switching functions as mentioned above.

## A.0 The Design of the Conventional Sliding Mode Control
The steps for are as shown below:

**1. Linearize the Fuel Cell model using Input-Output Linearization**: Refer to to the linearization process as shown in the [IOFBL README](https://github.com/BoboyeOkeya/PEM_Fuel_Cell_Voltage_Control/blob/main/IOFBL/README.md), where you will see the equations for $y_1$ and $\dot{y_1}$ as described in equation 9, 11 and 15. This is written explicitly below.

$$
 y_1 = V_{FC}...(1)
$$

$$
  \dot{y_1} = L_fh_1 + L_{g_1}h_1.u_1 + L_{g_2}h_1.u_2 + L_{g_3}h_1.u_3...(2) = v_1
$$

These equations represent the output voltage and its derivative. And this will form the basis of the nonlinear controller since v1 is the only new control input signal that can be used for setpoint tracking as also described in the [IOFBL README](https://github.com/BoboyeOkeya/PEM_Fuel_Cell_Voltage_Control/blob/main/IOFBL/README.md).

**2. Define a new state-space coordinate based on equations 1 and 2 above**: This is as shown below

$$
\begin{bmatrix}
  {z_1}\\
  {z_2}\\
\end{bmatrix} = \begin{bmatrix}
  y_1\\
  \dot{y_1}\\
\end{bmatrix}...(3)
$$

$$
\begin{bmatrix}
  \dot{z_1}\\
  \dot{z_2}\\
\end{bmatrix} = \begin{bmatrix}
  z_2\\
  \ddot{{y_1}}\\
\end{bmatrix}= \begin{bmatrix}
  v_1\\
  0\\
\end{bmatrix}...(4)
$$


**3. Define the Sliding manifold `s`**: This is shown by the equation below [1][2]

$$
    s= \dot{e} + \lambda e = (\dot{y_1}-\dot{y_1^d}) + \lambda({y_1}-{y_1^d})...(5)
$$

where $\lambda$ is a strictly positive constant[1] related to the control bandwidth[2].

Take its derivative as shown below

$$
    \dot{s}= \ddot{e} + \lambda\dot{e}  = (\ddot{y_1}-\ddot{y_1^d}) + \lambda(\dot{y_1}-\dot{y_1^d})...(6)
$$

Substituting $\ddot{y_1}$ from equation 4 into 6 gives

$$
    \dot{s}= 0-\ddot{y_1^d} + \lambda(\dot{y_1}-\dot{y_1^d})...(7)
$$

Substituting $\dot{y_1}$ from equation 2 into 7 gives

$$
  \dot{s}= -\ddot{y_1^d} +\lambda(L_fh_1 + L_{g_1}h_1.u_1 + L_{g_2}h_1.u_2 + L_{g_3}h_1.u_3) -\lambda\dot{y_1^d}...(8)
$$

**4. Define the sliding mode control input**
From equation 8 above, u1 is the control signal that will be used for the setpoint tracking hence it will also be used to define the sliding mode control input. 

The control input has two components the equivalent term ($\hat{u_{eq}}$) and the switching term (${u_{s}}$) as shown below:

$$
{u_1} = \hat{u}_{eq} + u_s ...(9)
$$

The equivalent term is derived from equation 8 and it is as shown below

$$
\hat{u}_{eq}= \frac{-1}{\lambda L_{g_1}h_1}\left[\lambda(L_fh_1 + L_{g_2}h_1.u_2 + L_{g_3}h_1.u_3)\right] -\lambda\dot{y_1^d} - \ddot{y_1^d} ...(10)
$$

The switching term can be defined using a [signum function](https://en.wikipedia.org/wiki/Sign_function) as shown in equation 11 below. This is a discontinous switching function and it causes a lot of chattering which can destroy the actuator or the fuel cell's fuel injector.

$$
{u_{s}} = \frac{-1}{\lambda L_{g_1}h_1}(\eta. sgn(s))...(11)
$$

Where $\eta$ is also a strictly positive constant.

In addition, the switching term can also be defined using a saturation function defined as shown in equation 12 below. The saturation function reduces chattering significantly as will be seen in subsequent sections below.

$$
{u_{s}} = \frac{-1}{\lambda L_{g_1}h_1}(\eta. sat(\frac{s}{\phi}))...(12)
$$

The saturation function is expressed as shown below

$$
sat(\frac{s}{\phi}) = \begin{cases}
\frac{s}{\phi} & \quad if\;|\frac{s}{\phi}| \leq 1\\
sgn(\frac{s}{\phi}) & \quad if\;|\frac{s}{\phi}|>1
\end{cases}
$$


## A.1 The Lyapunov Stability Analysis of the Designed Conventional Sliding Mode Controller

The process of of linearization means that our control system can only be locally stable or locally asymptotically stable at most. 

To assess the stability of the sliding mode controlled system designed in section A.0, we can use the Lyapunov function $V(s)$.

Let us define the function as shown below:

$$V(s) = \frac{1}{2}s^2 = \frac{1}{2}(\dot{e} + \lambda e)^2...(13)$$

It can be seen that $V(0) = 0$, $V(\infty) = \infty$, and $V(s) >0$ for all $s\neq 0$. Hence V(s) is positive definite (PD).

Next, let's check the derivative $\dot{V}(s)$ as follows
$$\dot{V}(s) = (s.\dot{s})...(14)
$$ 

Substituting equation 8 into equation 14 above gives 

$$
\dot{V}(s) = s[-\ddot{y_1^d} +\lambda(L_fh_1 + L_{g_1}h_1.u_1 + L_{g_2}h_1.u_2 + L_{g_3}h_1.u_3) -\lambda\dot{y_1^d}]...(15)
$$ 

Furthermore, if we substitute the control input (equations 10 and 11) into equation 15 above, we get the following: 

$$
\dot{V}(s) = \frac{-1}{\lambda L_{g_1}h_1}(\eta.s. sgn(s))...(16)
$$ 

This can be further simplified since $s. sgn(s) = |s|$, which turns equation 16 into the following:

$$
\dot{V}(s) = \frac{-1}{\lambda L_{g_1}h_1}(\eta.|s|)...(17).
$$ 

Equation 17 above shows that as long as $\lambda$ and $\eta$ are positive constants, then $\dot{V}(s)\leq 0$, hence $\dot{V}(s)$ is negative semi-definite(NSD).

Therefore, it has been proved that the control system mis locally asymptotically stable (L.A.S) since $V(s)$ is PD and $\dot{V(s)}$ is NSD.

Furthermore, for a saturation function as shown in equation 12

if $|\frac{s}{\phi}| \leq 1$, 


$$
\dot{V}(s) = \frac{-1}{\lambda L_{g_1}h_1}s. \frac{s}{\phi} = \frac{-1}{\lambda L_{g_1}h_1}\frac{s^2}{\phi} ...(18).
$$ 

Hence, from equation 18 it can be seen that $\dot{V}(s)\leq 0$ if $\phi>0$.

Next, if $|\frac{s}{\phi}| > 1$, 

$$
\dot{V}(s) = \frac{-1}{\lambda L_{g_1}h_1}s. sgn(\frac{s}{\phi})...(19)
$$ 

Hence, from equation 19 it can be seen that $\dot{V}(s)\leq 0$ if $\phi>0$.

Therefore, equation 18 and 19 shows that the sliding mode control system is L.A.S as well.

## B.0 The Design of the Integral Terminal Sliding Mode Control
The steps include the steps 1 and 2 of section A.0. The subsequent steps are as follows:

**1. Define the Sliding manifold `s`**: This is shown by the equation below [2]

$$
    s= e + \lambda \left(\int e dt\right)^\frac{p}{q}...(20)
$$

where $\lambda$ is a strictly positive constant[1] related to the control bandwidth[2].

Take its derivative as shown below

$$
    \dot{s}= \dot{e} + \lambda \left(\frac{p}{q}\right)e\left(\int e dt\right)^{\frac{p}{q}-1}\\
    = \dot{y_1}-\dot{y_1^d} + \lambda \left(\frac{p}{q}\right)e\left(\int e dt\right)^{\frac{p}{q}-1}\\
    = L_fh_1 + L_{g_1}h_1.u_1 + L_{g_2}h_1.u_2 + L_{g_3}h_1.u_3-\dot{y_1^d} + \lambda \left(\frac{p}{q}\right)e\left(\int e dt\right)^{\frac{p}{q}-1}...(21)
$$

**2. Define the sliding mode control input**
As in step 4 of A.0, the control input has two components the equivalent term ($\hat{u_{eq}}$) and the switching term (${u_{s}}$) as shown in equation 9

The equivalent term is derived from equation 21 and it is as shown below

$$
\hat{u}_{eq.int} = \frac{-1}{L_{g_1}h_1}\left[L_fh_1 + L_{g_2}h_1.u_2 + L_{g_3}h_1.u_3 - \dot{y_1^d} +  \lambda \left(\frac{p}{q}\right)e\left(\int e dt\right)^{\frac{p}{q}-1}\right]...(22)
$$

The switching term can be defined using a [signum function](https://en.wikipedia.org/wiki/Sign_function) as shown in equation 23 below. This is also a discontinous switching function that causes chattering.

$$
{u_{s,int}} = \frac{-1}{L_{g_1}h_1}(k. sgn(s))...(23)
$$

Where $k$ is also a strictly positive constant.

In addition, the switching term can also be defined using a saturation function defined as shown in equation 24 below.

$$
{u_{s,int}} = \frac{-1}{L_{g_1}h_1}(k. sat(\frac{s}{\phi}))...(24)
$$


## B.1 The Lyapunov Stability Analysis of the Designed Conventional Sliding Mode Controller
The process of the analysis is similar to that of A.1. 

The Lyapunov function is as shown below:

$$V(s) = \frac{1}{2}s^2 = \frac{1}{2}\left[e + \lambda \left(\int e dt\right)^\frac{p}{q}\right]^2...(25)$$

It can be seen that $V(0) = 0$, $V(\infty) = \infty$, and $V(s) >0$ for all $s\neq 0$. Hence V(s) is positive definite (PD).

Next, let's check the derivative $\dot{V}(s)$ as follows

$$
  \dot{V}(s) = (s.\dot{s})\\
  = s\left[L_fh_1 + L_{g_1}h_1.u_1 + L_{g_2}h_1.u_2 + L_{g_3}h_1.u_3-\dot{y_1^d} + \lambda \left(\frac{p}{q}\right)e\left(\int e dt\right)^{\frac{p}{q}-1}\right]...(26)
$$ 

Substituting the control input (equations 22 and 23) into equation 26 above, we get the following: 

$$
  \dot{V}(s) = \frac{-1}{L_{g_1}h_1}(k.s. sgn(s))...(27)
$$


From equation 27, just like equation 17, the $\dot{V}(s)$ is therefore negative semi-definite(NSD). Hence, it has been proved that the control system is locally asymptotically stable (L.A.S) since $V(s)$ is PD and $\dot{V(s)}$ is NSD.

Furthermore, for a saturation function as shown in equation 24

if $|\frac{s}{\phi}| \leq 1$, 

$$\dot{V}(s) = \frac{-1}{L_{g_1}h_1}s. \frac{s}{\phi} = \frac{-1}{L_{g_1}h_1}\frac{s^2}{\phi} ...(28).
$$ 

Hence, from equation 28 it can be seen that $\dot{V}(s)\leq 0$ if $\phi>0$.

Next, if $|\frac{s}{\phi}| > 1$, 

$$
  \dot{V}(s) = \frac{-1}{L_{g_1}h_1}s. sgn(\frac{s}{\phi})...(29)
$$ 

Hence, from equation 29 it can be seen that $\dot{V}(s)\leq 0$ if $\phi>0$.

Therefore, equation 28 and 29 shows that the sliding mode control system is L.A.S as well.

In conclusion, the stability analysis shows that conventional and integral terminal sliding mode control systems are L.A.S. Therefore, we will be able to design a control system that will locally stablize the fuel cell voltage at a desired value.



## The Scilab/Xcos Simulation  How to Use them

The computer simulation of the control systems mentioned above are contained in the repo. The description of the files and how to use them are described below:

a. `padulles1_model_smc.zcos` and `smc_law.sci`: This runs the conventional SMC using a **signum function**. The .zcos file contains the xcos model and the sliding mode control law is in the scilab script. To run this simulation, **save and execute** the `.sci` file first, after which you can then **start** the simulation in the xcos file.


b. `padulles1_model_smc_sat.zcos` and `smc_sat_law.sci`: This runs the conventional SMC using a **saturation function**. The .zcos file contains the xcos model and the sliding mode control law is in the scilab script. To run this simulation, **save and execute** the `.sci` file first, after which you can then **start** the simulation in the xcos file.

c. `padulles1_model_itsmc.zcos` and `itsmc_law.sci`: This runs the integral terminal SMC using a **signum function**. The .zcos file contains the xcos model and the sliding mode control law is in the scilab script. To run this simulation, **save and execute** the `.sci` file first, after which you can then **start** the simulation in the xcos file.

c. `padulles1_model_itsmc_sat.zcos` and `itsmc_sat_law.sci`: This runs the integral terminal SMC using a **saturation function**. The .zcos file contains the xcos model and the sliding mode control law is in the scilab script. To run this simulation, **save and execute** the `.sci` file first, after which you can then **start** the simulation in the xcos file.

## The Results

## References
[1]  J. J. E. Slotine and W. Li, “Applied Nonlinear Control." Englewood 
Cliffs, NJ: Prentice-Hall, 1991. 

[2] Napole, C., Derbeli, M., & Barambones, O. (2021). A global integral terminal sliding mode control based on a novel reaching law for a proton exchange membrane fuel cell system. Applied Energy, 301, 117473. doi:10.1016/j.apenergy.2021.117473 

