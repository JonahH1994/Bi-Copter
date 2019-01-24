% -------------------------------------------------------------------------
% --------------------------- Initial conditions --------------------------
% -------------------------------------------------------------------------

% ----------------- WP: [0 0 0] & [0 0 30] ------------
% -----------------------------------------------------
%$rrrrqq
V1_WP = 13.133293860393252;               % WP - hovering
% V2_WP = 13.133293860393252;
V2_WP = 12.586167140659024;    

% Now in master

% d_omega_R10=9.1275;          % motor 1. rotor
% d_omega_R20=8.955;           % motor 2. rotor
% d_omega_R30=8.61;            % motor 3. rotor
% d_omega_R40=8.543;
%% Props and Servos
omega0_P1 = 212.7154258234844;          % motor 1. rotor
omega0_S1 = 0;           % motor 2. rotor
omega0_P2 = 212.7154258234844;            % motor 3. rotor
omega0_S2 = 0;           % motor 4. rotor

gamma1_0 = deg2rad(0);
gamma2_0 = deg2rad(0);

%% Position and Velocity
dx_0=0;                     % linear velocity in x - axis
x_0=0;                      % position in x - axis

dy_0=0;                     % linear velocity in y - axis
y_0=0;                      % position in y - axis

dz_0=0;                     % linear velocity in z - axis
z_0=.5;                     % position in z - axis


%% Attitude and Rates
% Q0_N_B = eye(3);
% Q0_N_B = [0 1 0;-1 0 0;0 0 1]';
% Q0_N_B = sqrt(2)/2*[[1;1;0],[-1;1;0],[0;0;sqrt(2)]];
psi_0 = 0*pi/2;
quat4_0 = [0 0 sin(psi_0/2) cos(psi_0/2)]';
quat1_0 = [cos(psi_0/2) 0 0 sin(psi_0/2)]';
Q0_N_B = quat2dcm(quat1_0')';

w0n1 = 0 ;
w0n2 = 0 ;
w0n3 = 0 ;
w0_N = [w0n1; w0n2; w0n3 ] ;
w0_B = Q0_N_B.' * w0_N;

% Desired states for path planning:
desiredPoints = [ -4, 3, 0.3 ; ...
                  -5,-8,0.5 ; ...
                  3, 7, 3 ; ...
                  8, 3, 3 ; ...
                  4, 4, 0.5 ] ;
