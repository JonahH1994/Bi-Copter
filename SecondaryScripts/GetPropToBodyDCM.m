%% File Description
%{
Author:     Aaron Sandoval
Course:     MAE 6780 - Multivariable Control
Created:    2018-02-19
Updated:    2018-02-19

Description:
This function creates a DCM relating the main body-fixed basis and the
propeller bases.

Args:
fromBasis:  int representing basis name. One of the following:
            {'B', 'P1', 'P2'}
toBasis:    int representing basis name. One of the following:
            {'B', 'P1', 'P2'}
delta:      Fixed rotor tilt angle defined in LoadQuadrotorConsts_XPro1a.m
gamma:      Servo angle from vertical for P1 or P2 as defined in sketches.
%}

%% Function Definition
function Q = GetPropToBodyDCM(inputs)

%% Input Processing
fromBasis = inputs(1);
delta = inputs(2);
gamma = inputs(3);

%% Case selection
switch(fromBasis)
    case 1
%         fprintf('From P1\n'); %DEBUG
    case 2
%         fprintf('From P2\n'); %DEBUG
        delta = -delta; % Outward tilt in opposite direction for prop2.
        gamma = -gamma; % Defined as opposite rotation for prop2.
end

%% DCM Computation
cosG = cos(gamma); sinG = sin(gamma);
cosD = cos(delta); sinD = sin(delta);
Q_delta1_B = [cosD 0 -sinD; 0 1 0; sinD 0 cosD]; % Intermediate basis
Q_gamma1_delta1 = [1 0 0; 0 cosG sinG; 0 -sinG cosG]; % Intermediate basis
Q_gamma1_B = Q_delta1_B*Q_gamma1_delta1; % From body to prop basis
Q = Q_gamma1_B'; % Transpose, from prop to body basis
end