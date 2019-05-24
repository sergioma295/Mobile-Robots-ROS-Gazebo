%% Inicializacion workspace
clear all, close all, clc;

%% Declaración variables simbólicas
syms x1 x2 x3 u1 u2 Ts b z1 z2 z3 R_wr R_wl

v_wr = R_wr * u1;          
v_wl = R_wl * u2;  

vt = (v_wr + v_wl)/2;
vr = (v_wr - v_wl)/(2*b);

%% Ecuación en espacio de estados. 
% Matriz de proceso
f1 = x1+Ts*vt*cos(x3)-(1/2)*Ts^2*vr*u2*sin(x3);
f2 = x2+Ts*vt*sin(x3)+(1/2)*Ts^2*vr*u2*cos(x3);
f3 = x3 + Ts*vr;
X = [f1;f2;f3]

% Matriz de medidas
z1 = 0;
z2 = 0;
z3 = x3;

Z = [z1;z2;z3]


%% Matrices EKF
% Matriz A
f1_1a = diff(f1,x1);
f1_2a = diff(f1,x2);
f1_3a = diff(f1,x3);

f2_1a = diff(f2,x1);
f2_2a = diff(f2,x2);
f2_3a = diff(f2,x3);

f3_1a = diff(f3,x1);
f3_2a = diff(f3,x2);
f3_3a = diff(f3,x3);

% Matriz B
f1_1b = diff(f1,u1);
f1_2b = diff(f1,u2);

f2_1b = diff(f2,u1);
f2_2b = diff(f2,u2);

f3_1b = diff(f3,u1);
f3_2b = diff(f3,u2);

% Matriz H.
z1_1h = diff(z1,x1);
z1_2h = diff(z1,x2);
z1_3h = diff(z1,x3);

z2_1h = diff(z2,x1);
z2_2h = diff(z2,x2);
z2_3h = diff(z2,x3);

z3_1h = diff(z3,x1);
z3_2h = diff(z3,x2);
z3_3h = diff(z3,x3);


A = [f1_1a f1_2a f1_3a;
    f2_1a f2_2a f2_3a;
    f3_1a f3_2a f3_3a]

B = [f1_1b f1_2b;
    f2_1b f2_2b;
    f3_1b f3_2b]

H = [z1_1h z1_2h z1_3h;
    z2_1h z2_2h z2_3h;
    z3_1h z3_2h z3_3h] 


