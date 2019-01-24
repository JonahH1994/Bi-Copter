% Equilibrium_InitialConditions % Load the constants for the quad
format long
% Find the rotor speed required to counteract gravity
r_poly = [c d (e-m*ga/2)] % Rotor Speed for both props
r = roots(r_poly)
rspeed = r(2)

% Calculate the voltages for each Rotor
v_poly_1 = (rspeed -b1)/a1 
v_poly_2 = (rspeed -b2)/a2 


