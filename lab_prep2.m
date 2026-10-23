syms p Dp De p_c De_c k_1 k_2 k_3 k_4 k_5 k_6 K_1 K_2 F

x = [p; Dp; De];
A = [0 1 0; 0 0 0; 0 0 0];
B = [0 0; 0 K_1; K_2 0];

r = [p_c; De_c];
K = [k_1 k_2 k_3; k_4 k_5 k_6];
u = F * r - K * x;

Dx = A*x + B * u