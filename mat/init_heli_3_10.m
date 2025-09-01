% FOR HELICOPTER NR 3-10
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]


%%%%%%%%%% DAY ONE %%%%%%%%%%

% Calculation of K_f
V_s0 = 7.65; % Measured value [V]
K_f = (2*l_h*m_p-l_c*m_c)*g / (l_h*V_s0);

% Poles of closed loop
lambda_1 = -2;
lambda_2 = -2;

% Constants
L_1 = l_p * K_f;
J_p = 2*m_p*l_p^2;
K_1 = L_1 / J_p;

% Pitch PD-controller gains
K_pp = -(lambda_1 + lambda_2) / K_1;
K_pd = (lambda_1 * lambda_2) / K_1;

% Pitch reference
datavals = [0, 0, pi/6, pi/6, 0, 0];
timevals = [0, 10, 10, 25,  25, 35];
P_c = timeseries(datavals,timevals);


