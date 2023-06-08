clear all;clc
syms x1 x2 x3 x4 u1 u2 u3 v1 v2 v3 tau_h2 tau_o2 Kh2 Ko2 No R T F B C Rint Kr Eo

f=[-x1/tau_h2; 
    -x2/tau_o2];  

g1=[1/(Kh2*tau_h2);
    0];

g2=[0;
    1/(Ko2*tau_o2)];

g3=[-2*Kr/(Kh2*tau_h2);
    -Kr/(Ko2*tau_o2)];

h= No*(Eo + (R*T*log(x1))/(2*F) + (R*T*log(x2))/(4*F)) - u3*Rint - B*log(C) - B*log(u3);

X=[x1;
    x2];

L_f_h=   jacobian(h,X) * f;


L_g1_h=  jacobian(h,X) * g1;
L_g2_h=  jacobian(h,X) * g2;
L_g3_h=  jacobian(h,X) * g3;

L_f_2_h = jacobian(L_f_h,X) * f;
L_g1_L_f_h = jacobian(L_f_h,X)*g1;
L_g2_L_f_h = jacobian(L_f_h,X)*g2;
L_g3_L_f_h = jacobian(L_f_h,X)*g3;

y_dot = L_f_h + L_g1_h*u1 + L_g2_h*u2 + L_g3_h*u3;
y_ddot = L_f_2_h + L_g1_L_f_h*u1 + L_g2_L_f_h*u2 + L_g3_L_f_h*u3;