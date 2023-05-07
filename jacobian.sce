//function J = jacobian_matrix(x)
//    syms x1 x2 x3
//    f1 = x1^2 + x2^2 + x3^2;
//    f2 = x1*x2 + x2*x3;
//    f3 = x1*x3 + x2*x3;
//    F = [f1; f2; f3];
//    X = [x1; x2; x3];
//    J = jacobian(F,X);
//endfunction
function y=f(x)
  y = sum(x.^2)
endfunction

PopSize     = 100;
Proba_cross = 0.7;
Proba_mut   = 0.1;
NbGen       = 10;
Log         = %T;

ga_params = init_param();
// Parameters to control the initial population.
ga_params = add_param(ga_params,"dimension",3);

[pop_opt, fobj_pop_opt] = ..
  optim_ga(f, PopSize, NbGen, Proba_mut, Proba_cross, Log, ga_params);
 
 
