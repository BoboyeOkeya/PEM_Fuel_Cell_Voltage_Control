function [z1_hat_dot,z2_hat_dot] = ESO(b,u1,z1,z1_hat,z2_hat,L1,L2)

z1_hat_dot = z2_hat + L1*(z1-z1_hat) + b*u1;
z2_hat_dot = L2*(z1 - z1_hat);


endfunction
