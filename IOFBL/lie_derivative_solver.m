clear all;clc
syms x1 x2 x3 x4 u1 u2 u3 v1 v2 v3 tau_h2 tau_o2 Kh2 Ko2 No R T F B C Rint Kr Eo

f=[-x1/tau_h2; 
    -x2/tau_o2;
    0;
    0];  

g1=[1/(Kh2*tau_h2);
    0;
    0;
    0];

g2=[0;
    1/(Ko2*tau_o2);
    1;
    0];

g3=[-2*Kr/(Kh2*tau_h2);
    -Kr/(Ko2*tau_o2);
    0;
    1];

h1= No*(Eo + (R*T*log(x1))/(2*F) + (R*T*log(x2))/(4*F)) - u3*Rint - B*log(C) - B*log(u3);
h2 = x3;
h3 = x4;

X=[x1;
    x2;
    x3;
    x4];

L_f_h1=   jacobian(h1,X) * f;
L_f_h2=   jacobian(h2,X) * f;
L_f_h3=   jacobian(h3,X) * f;


L_g1_h1=  jacobian(h1,X) * g1;
L_g2_h1=  jacobian(h1,X) * g2;
L_g3_h1=  jacobian(h1,X) * g3;

L_g1_h2=  jacobian(h2,X) * g1;
L_g2_h2=  jacobian(h2,X) * g2;
L_g3_h2=  jacobian(h2,X) * g3;

L_g1_h3=  jacobian(h3,X) * g1;
L_g2_h3=  jacobian(h3,X) * g2;
L_g3_h3=  jacobian(h3,X) * g3;


L = [L_f_h1;L_f_h2;L_f_h3];
E = [L_g1_h1, L_g2_h1, L_g3_h1;L_g1_h2, L_g2_h2,L_g3_h2;L_g1_h3, L_g2_h3,L_g3_h3];
invE = inv(E);

U = -invE*L + invE*[v1;v2;v3]

%{
U =
 
(Kr*v3*(Kh2*tau_h2*x1 + 4*Ko2*tau_o2*x2))/(2*Ko2*tau_o2*x2) - (Kh2*tau_h2*v2*x1)/(2*Ko2*tau_o2*x2) + (2*F*Kh2*tau_h2*v1*x1)/(No*R*T) + (2*F*Kh2*tau_h2*x1*((No*R*T)/(2*F*tau_h2) + (No*R*T)/(4*F*tau_o2)))/(No*R*T)
                                                                                                                                                                                                                 v2
                                                                                                                                                                                                                 v3
 
%}
