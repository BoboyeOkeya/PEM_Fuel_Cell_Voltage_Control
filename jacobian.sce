function J = jacobian_matrix(x)
    syms x1 x2 x3
    f1 = x1^2 + x2^2 + x3^2;
    f2 = x1*x2 + x2*x3;
    f3 = x1*x3 + x2*x3;
    F = [f1; f2; f3];
    X = [x1; x2; x3];
    J = jacobian(F,X);
endfunction
