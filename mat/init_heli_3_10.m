% FOR HELICOPTER NR 3-10
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert h�sten 2006 av Jostein Bakkeheim
% Oppdatert h�sten 2008 av Arnfinn Aas Eielsen
% Oppdatert h�sten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -2;


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

% Constants
L_1 = l_p * K_f;
J_p = 2*m_p*l_p^2;
J_e = m_c*l_c^2 + 2*m_p*l_h^2;
K_1 = L_1 / J_p;

K_2 = l_h * K_f / J_e;

L_4 = l_h * K_f;
K_3 = L_4 * V_s0 / (m_c*l_c^2 + 2*m_p*(l_h^2 + l_p^2));

% Poles of closed loop
lambda_1 = -2;
lambda_2 = -2;

% Pitch PD-controller gains
% K_pd = -(lambda_1 + lambda_2) / K_1;
% K_pp = (lambda_1 * lambda_2) / K_1;

% Pitch reference
datavals = [0, 0, pi/6, pi/6, 0, 0];
timevals = [0, 10, 10, 25,  25, 35];
P_c = timeseries(datavals,timevals);


colors = {[0.83 0.14 0.14], [0.47 0.25 0.80], [0.25 0.80 0.54]};



Q = [1 0 0 0 0;
     0 1 0 0 0;
     0 0 1 0 0;
     0 0 0 1 0;
     0 0 0 0 1];
R = [1 0;
     0 1];
 
A = [0 1 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0;
     -1 0 0 0 0;
     0 0 -1 0 0];
 
 B = [0 0;
      0 K_1;
      K_2 0;
      0 0;
      0 0];
  

Q = Q*10;
R = R*1;
[K, S, CLP] = lqr(A,B,Q,R);

F = [K(1,1) K(1,3);
     K(2,1) K(2,3)];

G = [0 0;
     0 0;
     0 0;
     1 0;
     0 1];
 
% K = K.';
% F = F.';
 

PORT = 3;

A_hat = [0 1 0 0 0;
         0 0 0 0 0;
         0 0 0 1 0;
         0 0 0 0 0;
         K_3 0 0 0 0];

B_hat = [0 0;
         0 K_1;
         0 0;
         K_2 0;
         0 0];
     
C_hat = [1 0 0 0 0;
         0 1 0 0 0;
         0 0 1 0 0;
         0 0 0 1 0;
         0 0 0 0 1];
 
 r = -500;
 theta = pi/12;
 p = [r*exp(1i*theta), r*exp(1i*theta/2), r, r*exp(-1i*theta), r*exp(-1i*theta/2)];
 
%p = [0.2*r, 0.4*r, 0.6*r, 0.8*r, r];
 
 L = place(A_hat', C_hat', p).'
 
