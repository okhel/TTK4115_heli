= TTK4115 Helicopter Lab Prep

== Part II - Multivariable Control

=== Problem 1 - State space formulation
Bring the system

$
  dot.double(p) &= K_1 V_d \
  dot.double(e) &= K_2 tilde(V)_s
$

On the form

$
  dot(x) = A x + B u
$

with 

$
  x = mat(p; dot(p); dot(e)) quad and quad u = mat(tilde(V_s), V_d)
$

which becomes

$
  mat(dot(p); dot.double(p); dot.double(e)) = mat(0, 1, 0; 0, 0, 0; 0, 0, 0) mat(p; dot(p); dot(e)) + mat(0,0; 0, K_1; K_2, 0) mat(tilde(V_s), V_d)
$

with the matrices

$
  A = mat(0, 1, 0; 0, 0, 0; 0, 0, 0) quad and quad B = mat(0,0; 0, K_1; K_2, 0)
$

=== Problem 2 - Controllability

Examining the controllability matrix $cal(C)$

$
  #let dict1 = (
    vline: (1,2),
  )
  #let dict2 = (
    vline: (2,4),
  )

  cal(C)&= mat(B, A B, A^2 B; augment: dict1) \
  &= mat(0,0,0,K_1,0,0; 0,K_1,0,0,0,0; K_2,0,0,0,0,0; augment: dict2)
$

and since $"rank"(cal(C)) = 3$, the system is controllable.

Checking in `MATLAB` using ```matlab ctrb(A,B)``` gives the same matrix, with rank 3.


=== Problem 3 - Feedback and feedforward

Track the reference $r = mat(p_c; dot(e_c))$

with the control law

$
  u = F r -K x
$

where

$
  K = mat(k_11, k_12, k_13; k_21, k_22, k_23) quad and quad F = mat(F_11, F_12; F_21, F_22)
$

Inserting this into the system gives

$
  mat(dot(p); dot.double(p); dot.double(e)) =& mat(0, 1, 0; 0, 0, 0; 0, 0, 0) mat(p; dot(p); dot(e)) + mat(0,0; 0, K_1; K_2, 0) (mat(F_11, F_12; F_21, F_22) mat(p_c; dot(e)_c) - mat(k_11, k_12, k_13; k_21, k_22, k_23) mat(p; dot(p); dot(e)))\
  =& mat(0, 1, 0; 0, 0, 0; 0, 0, 0) mat(p; dot(p); dot(e)) + mat(0,0; 0, K_1; K_2, 0) (mat(p_c F_11 + p_c F_12; dot(e)_c F_21 + dot(e)_c F_22) - mat(k_11 p + k_12 dot(p) + k_13 dot(e); k_21 p + k_22 dot(p) + k_23 dot(e)))\
  =& mat(0, 1, 0; 0, 0, 0; 0, 0, 0) mat(p; dot(p); dot(e)) + mat(0; K_1( dot(e)_c F_21 + dot(e)_c F_22) - K_1( k_21 p + k_22 dot(p) + k_23 dot(e)); K_2 (p_c F_11 + p_c F_12) - K_2( k_11 p + k_12 dot(p) + k_13 dot(e)))\
  =& mat(0, 1, 0; -K_1 k_21, -K_1 k_22, -K_1 k_23; -K_2 k_11, -K_2 k_12, -K_2 k_13) mat(p; dot(p); dot(e)) + mat(0; K_1( dot(e)_c F_21 + dot(e)_c F_22); K_2 (p_c F_11 + p_c F_12))
$

as $t -> infinity$, this becomes
$
0 =& mat(0, 1, 0; -K_1 k_21, -K_1 k_22, -K_1 k_23; -K_2 k_11, -K_2 k_12, -K_2 k_13) mat(p; 0; dot(e)) + mat(0; K_1 dot(e)_c (F_21 + F_22); K_2 p_c (F_11 + F_12))\
=& mat(-K_1 k_21 -K_1 k_23; -K_2 k_11 -K_2 k_13) mat(p; dot(e)) + mat(0, K_1 (F_21 + F_22); K_2 (F_11 + F_12), 0) mat(p_c; dot(e)_c)
$

for $p -> p_c$ and $dot(e) -> dot(e)_c$:

$
  F_21 + F_22 = k_23 quad and quad F_11 + F_12 = k_11
$

so $F$ becomes, for instance:

$
  F = mat(k_11, 0; 0, k_23)
$

=== Problem 4

Larger "Q" matrix will lead to more aggressive control, and larger "R" matrix will lead to more smooth control.

=== Problem 5

The new $A$, $B$, and $G$ matrices are simply:

$
  A = mat(0, 1, 0, 0, 0; 0, 0, 0, 0, 0; 0, 0, 0, 0, 0; -1, 0, 0, 0, 0; 0, 0, -1, 0, 0) quad and quad
  B = mat(0,0; 0, K_1; K_2, 0; 0, 0; 0, 0) quad and quad
  G = mat(0, 0; 0, 0; 0, 0; 1, 0; 0, 1)
$

with the added states $gamma$ and $zeta$ the $Q$ matrix will also penalize the error in the states, hence helping drive them to 0. The $G$ matrix will help drive the states to the reference. The introduction of integral effect makes it less important to choose $F$ appropriately