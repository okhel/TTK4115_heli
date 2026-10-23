clc; clear;

% syms K_1 K_2 K_3
K_1 = 1;
K_2 = 1;
K_3 = 1;

A = [0 1 0 0 0;
     0 0 0 0 0;
     0 0 0 1 0;
     0 0 0 0 0;
     K_3 0 0 0 0];

B = [0 0;
     0 K_1;
     0 0;
     K_2 0;
     0 0];

C = [1 0 0 0 0;
     0 0 0 0 0;
     0 0 1 0 0;
     0 0 0 0 0;
     0 0 0 0 1];

rank(obsv(A, C))

n = 5;
r = -2;
theta = pi/6;
p = [r*exp(1i*theta), r*exp(1i*theta/2), r, r*exp(-1i*theta/2), r*exp(-1i*theta)];

L = place(A', C', p).'