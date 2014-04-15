% James Lamberti
%
% Solution to Cops-Robber Problem:
%   4 cops A,B,C and D chase after the criminal E, where E maintains
%   a steady velocity in the X direction, such that x˙E = 0.5. Each of
%   the cops, at every point in time are heading in the direction of 
%   the straight line that connects their individual positions with 
%   the present position of E. Let the velocity of each cop be 0.2 
%   times the distance between the cop and the criminal.

clc;
clear;

syms R;
syms C;
syms L;
syms s;
syms t;

A = [-2/(5*R*C) 4/(5*C); -4/(5*L) -2*R/(5*L)];
C = 10^3*[1/5 -2*R/5; -2/5 R/5];
C_mod = [1/5 0; -2/5 0]; % to apply to vt
vt = [1; R*0];
Vs = laplace(vt);
sI = s*eye(length(A));
sI_minus_A = sI-A;

X_zs_s = sI_minus_A\Vs;
x_zs_t = ilaplace(X_zs_s);

y_zs_t_sub = subs(subs(subs(C_mod*vt-C*(x_zs_t)/5, 'R', 2000), 'C', 10^-6), 'L', 10000);
t = 0:0.0001:0.04;
y1_t = zeros(1,length(t));
y2_t = zeros(1,length(t));
for i=1:length(t)
    y1_t(i) = subs(y_zs_t_sub(1), 't', t(i));
    y2_t(i) = subs(y_zs_t_sub(2), 't', t(i));

end

figure(1);
hold on;
h = subplot(2,1,1);
plot(t, y1_t);
title('Y1');
subplot(2,1,2);
plot(t, y2_t);
title('Y2');
hold off;

