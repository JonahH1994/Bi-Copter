%% Function Definition
function [V1, V2] = getVoltages(inputs)

%% Input Processing
force = inputs(1);
delta = inputs(2);
gamma = inputs(3);

%% Case selection
r_poly = [c d (e-force)];
r = roots(r_poly);
rspeed = r(2);

a1 = 16.235;            % Motor 1 Volts-to-Rotor Speed (r/s), 1st const
b1 = -0.5036;           % Motor 1 Volts-to-Rotor Speed (r/s), 2nd const

a2 = a1;            % Motor 2 Volts-to-Rotor Speed (r/s), 1st const
b2 = b1;      

V1 = (rspeed -b1)/a1;
V2 = (rspeed -b2)/a2; 