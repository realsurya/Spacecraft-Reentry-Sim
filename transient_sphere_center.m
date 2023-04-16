% Transient Heat Conduction Model 

function output = transient_sphere_center(A_1, lambda_1,alpha, radius, T_init, T_final, t_init, t_final, precision)

% tspan: 2 element row matrix that

% defining time steps from initial to final times of interest  
time = linspace(t_init,t_final,precision);

% Nondimensionalizing time variable 
tau = alpha.*time./(radius^2);

% Nondimensionalized temperature variable
tau_center = A_1 * exp(-lambda_1^2*tau); 

% Dimensional temperature at center of sphere
T_center = tau_center .* (T_init - T_final) + T_final;

output = [time',T_center']