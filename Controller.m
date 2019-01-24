% c_y = 10;
% c_z = .9;
% 
% k_y = 1;
% k_z = 1;
% f
% eta_y = 1;
% eta_z = 1;

if (1)
    c_y = .3;
    c_z = 1;
 
    k_y = .3;
    k_z = 1;

    eta_y = .3;
    eta_z = 1;
else 
    c_y = 0;
    c_z = 0;

    k_y = 0;
    k_z = 0;

    eta_y = 0;
    eta_z = 0;
end


%% Sliding Mode for Psi
if (1)
    c_psi = 1;
    k_psi = 1;
    eta_psi = 1;
else
    c_psi = 0;
    k_psi = 0;
    eta_psi = 0;
end

%% Gain on psi_desired_vel
k_psiErr_vel = .3;

% INput vector [G1... fill in later]

U_psiRot = [
    -0.1694
    -0.0950
    -0.1694
     0.0950];
U_gain_w = [U_psiRot(2)/U_psiRot(1)];