//Observer Hurtwitz Polynomial as a function of the bandwidth
p = poly([-18.26,-18.26], 's') //result => p  = 333.4276 +36.52s +s^2
// Coefficients of the Observer polynomial l1 = co(2) = 36.52, l2 = co(1) = 333.4276
co = coeff(p) 

//Controller bandwidth/gain
Kp = -17.19

// Coefficient of the input and its inverse
bo = 6.399e7
bo_inv = 1/bo





//p = poly([-18.2434,-18.2434], 's')
//co = coeff(p)
//Kp = -17.171
//bo = 6.399e7
//bo_inv = 1/bo

