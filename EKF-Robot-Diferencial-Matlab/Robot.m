%% Workspace initialization.
clc, close all, clear all;

%% Supress warnings
warning('off')

%% Parameters of robot.

% Pyshique parameters.
R_wr = 0.35;                 % Right wheel radius (m)
R_wl = 0.35;                 % Left wheel radius (m)
b = 0.5;                     % Distance between wheels (m)
x0 = 0;                      % Initial position, x (m)
y0 = 0;                      % Initial position, y (m)
theta0 = pi/4;                 % Initial position, phi

% Kinematic parameters
u_wr = pi/2;                 % Angular velocity of right wheel (rad/s)
u_wl = pi/2;                 % Angular velocity of left wheel (rad/s)

v_wr = R_wr * u_wr;          % Linear velocity of right wheel (m/s)
v_wl = R_wl * u_wl;          % Linear velocity of right wheel (m/s)

v_t = (v_wr + v_wl) / 2;     % Linear velocity of robot. (m/s)
v_r = (v_wr - v_wl) / (2*b); % Angular velocity of robot (rad/s)

% Noise parameters
% Process noise
Q1 = 0.00^2;                % Process noise x
Q2 = 0.00^2;                % Process noise y
Q3 = 0.00^2;                % Process noise r

% Measurement noise
R1 = 0.00^2;                 % Measurement noise x
R2 = 0.00^2;                 % Measurement noise y
R3 = 0.00^2;                 % Measurement noise phi

%% Simulation parameters
% Total time simulation. Must be the same value than simulink 
Tt=25;

% Temporal interval in each iteration. (s)
Ts = 0.01;

t1 = [0:Ts:Tt]';

%% Noise variables

% Generation of measurement and process noise vectors.
rng(10,'twister'); % andom number of seed 10 of Mersenne twister.

r_w1 = [t1,sqrt(Q1)*randn(length(t1),1)];     % x process noise [simulink]. 
r_w2 = [t1,sqrt(Q2)*randn(length(t1),1)];     % y process noise [simulink].
r_w3 = [t1,sqrt(Q3)*randn(length(t1),1)];     % r process noise [simulink].

r_v1 = [t1,sqrt(R1)*randn(length(t1),1)];     % x measurement noise [simulink].
r_v2 = [t1,sqrt(R2)*randn(length(t1),1)];     % y measurement noise [simulink].
r_v3 = [t1,sqrt(R3)*randn(length(t1),1)];     % r measurement noise [simulink].


%% Run simulink model discrete and its representation.
sim('Robot_Simulink_Discrete');
[x_vector_d_d,y_vector_d,r_vector_d] = simulacion_discreto(x0,y0,theta0,Ts,Tt,t,v_t,v_r,P_xd,P_yd,P_rd,Q1,Q2,Q3,R1,R2,R3);


%% Run simulink model continous and its representation.
sim('Robot_Simulink_Continous');
[x_vector_c,y_vector_c,r_vector_c] = simulacion_continuo(x0,y0,theta0,Ts,Tt,t,v_t,v_r,P_xc,P_yc,P_rc,Q1,Q2,Q3,R1,R2,R3);



