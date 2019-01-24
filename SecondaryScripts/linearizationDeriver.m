clear all ;
clc ;

%addpath('Active Branch\bicopter_control\');
initial_conditions ;
LoadQuadrotorConst_XPro1a ;

% Create numeric array of the drag constants
c0 = [co_x; co_y; co_z] ;

% Create the Inertia matrix:
I = eye(3) ;
I(1,1) = Ixx ;
I(2,2) = Iyy ;
I(3,3) = Izz ;

% Define state variables and inputs
Q = sym('Q',[3,3]) ;
w = sym('w', [3,1]) ; % Omega matrix
W = sym('W', [3,1]) ; % Wind velocity
syms x y z dx dy dz ;
syms Fp1 Fp2 gam1 gam2 om1 om2 tau1 tau2 ; % inputs

% Initial Conditions:
ic = [x_0 y_0 z_0 dx_0 dy_0 dz_0 w0_N(:).' Q0_N_B(:).'] ;

% skew-symmetric matrix for omega
skewW = [    0, -w(3),  w(2); ...
          w(3),     0, -w(1); ...
         -w(2),  w(1),     0] ;

% Create rotation matrices for Prop 1 and Prop 2:
Qp1 = [     1,         0,          0; ...
            0, cos(gam1), -sin(gam1); ...
            0, sin(gam1),  cos(gam1) ] ;
        
Qp2 = [     1,          0,          0; ...
            0,  cos(gam1),  sin(gam1); ...
            0, -sin(gam1),  cos(gam1) ] ;
        
% Define the derivatives of the states:

% ddr signifies [ddx; ddy; ddz]:
ddr = Q*(Qp1*[0;0;Fp1] + Qp2*[0;0;Fp2]) -c0.*([dx;dy;dz] - W) + [0;0;-m*ga] ;

% dw signifies [dw1; dw2; dw3]:
dw = I\(Q*(cross([L;0;zG],Qp1*[0;0;Fp1])+cross([-L;0;zG],Qp2*[0;0;Fp2])) + ...
    Qp1*[0;0;-tau1] + Qp2*[0;0;tau2] -c_m_drag*w + skewW*I*w) ;

% Sub in the expressions for Fp1, Fp2, Tau1, Tau2 in terms of om1 and om2:
ddr = subs( ddr, [Fp1, Fp2], [c*om1^2+d*om1+e,c*om2^2+d*om2+e] ) ;
dw = subs( dw, [Fp1, Fp2, tau1, tau2], [c*om1^2+d*om1+e,c*om2^2+d*om2+e, ...
    f*om1^2+g*om1+h, f*om2^2+g*om2+h]) ;

% dQ signifies the derivative of the DCM:
dQ = skewW * Q ;

% Take Jacobian to form A matrix
A = jacobian( [dx;dy;dz;ddr;dw;dQ(:)],[x y z dx dy dz w(:).' Q(:).']) ;

% Sub in state equilibrium conditions:
A = subs( A, [x y z dx dy dz w(:).' Q(:).'], ic) ;

% Sub in input equilibrium conditions:
A = subs( A, [ om1 om2 gam1 gam2 ], [ omega0_P1 omega0_P2  gamma1_0 gamma2_0]) ;

% Convert to a numeric Matrix:
A = double(A) ;

% Display A matrix:
disp(A) ;