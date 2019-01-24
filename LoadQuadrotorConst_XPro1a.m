% LoadQuadrotorConsts_XPro1a.m
%
% Load electro-mechanical constants for X-Pro specific parameters
% into general quadrotor model:  EPA_Quadrotor_v2b.mdl
%

% This is control_dev 2

%% Library Imports
addpath('SecondaryScripts\');

%% Test Selection
symMotors = 0; % 0:Motors are different; 1: Treat motors as identical
motorDragMoment = 1; % Turns on/off motor drag moment in motor blocks
bodyRotationDrag = 1 ; % Turns on/off body drag in the rotation blocks
disturbance = 1; % Turn on disturbances

%% Parameters
ga = 9.807;             % grav. accel. (m/s^2)
m = 2.1;                % total mass (kg)
   
Jr=4.86851*0.1;         % rotor inertia (kgm^2)
L = 0.422;              % BICOPTER: moment arm CG to rotor (m)
delta = deg2rad(0);    % BICOPTER: fixed outward rotor tilt angle
zG = .2;                 % BICOPTER: body 3 distance from CG to servo axis
r_P1_G = [L;0;zG];      % BICOPTER: position vector of prop1 in B basis
r_P2_G = [-L;0;zG];     % BICOPTER: position vector of prop2 in B basis

inertiaMult = 1e3;
Ixx = 0.00005586 * inertiaMult;  % Phi (x-axis) Inertia (kgm^2)
Iyy = 0.00024844 * inertiaMult;  % Theta (y-axis) Inertia (kgm^2)     
Izz = 0.00029633 * inertiaMult;  % Psi (z-axis) Inertia (kgm^2)
I_B = [Ixx 0 0; 0 Iyy 0; 0 0 Izz];
invI_B = inv(I_B);

Tau = 0.1;              % Motor/Rotor time const (s)
% Rotor Speed -to- Lift & Drag Functions:
% Lift (N) = c*(r/s)^2+d*(r/s)+e
c = 0.0002;             % Rotor Speed (r/s)-to-Lift (N), 1st const
d = 0.0071;             % Rotor Speed (r/s)-to-Lift (N), 2nd const
e = -0.2625;            % Rotor Speed (r/s)-to-Lift (N), 3rd const
% Drag (Nm) = f*(r/s)^2+g*(r/s)+h
f = 5e-6;               % Rotor Speed (r/s)-to-Drag (Nm), 1st const
g = 0.0008;             % Rotor Speed (r/s)-to-Drag (Nm), 2nd const
h = -0.0282;            % Rotor Speed (r/s)-to-Drag (Nm), 3rd const

% Specific Motor/Rotor Speed Constants: (r/s) = a*(Volts)+b
a1 = 16.235;            % Motor 1 Volts-to-Rotor Speed (r/s), 1st const
b1 = -0.5036;           % Motor 1 Volts-to-Rotor Speed (r/s), 2nd const
if(symMotors)
    a2 = a1;            % Motor 2 Volts-to-Rotor Speed (r/s), 1st const
    b2 = b1;           % Motor 2 Volts-to-Rotor Speed (r/s), 2nd const
else
    a2 = 17.912;            % Motor 2 Volts-to-Rotor Speed (r/s), 1st const
    b2 = -12.728;           % Motor 2 Volts-to-Rotor Speed (r/s), 2nd const
end

co_x=1.7;
co_y=1.7;
co_z=1.7;               %ORIGINAL: 90.7

% c_mi_x=170;
% c_mi_y=170;
% c_mi_z=40;
c_m_drag = 1;

%% DC Motor Parameters
motorAeroScaleFactor = 2; % Multiplier for motor and aero parameters from
% base values
% motorSaturation = 500; % rad/s

%% Servo Motor Properties
% Servo Test 60 deg/0.15 s
% Treat test as 4*tau => ~98% final value

% Tau constants for a 1st order system
Tau_1 = .0375; 
Tau_2 = .0375;

%% Noise
forceNoiseGain = 0.1;
torqueNoiseGain = 0.1;
windNoiseGain = 0.5;

% Tolerance for the path planning block:
tolerance = 0.3;
