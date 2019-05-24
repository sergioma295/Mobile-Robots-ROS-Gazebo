%% Workspace initialization.
clc, close all, clear all;

%% Supress warnings
warning('off')

%% Message
disp('... Wait please...');
%% Parameters of robot.

% Pyshique parameters.
R_wr = 0.5;                  % Right wheel radius (m)
R_wl = 0.5;                  % Left wheel radius (m)
b = 0.25;                     % Distance between wheels (m)

%% Initial Conditions
x0 = 0;                      % Initial position, x (m)
y0 = 0;                      % Initial position, y (m)
theta0 = pi/2;                 % Initial position, phi

% Kinematic parameters
u_wr = pi/4;                 % Angular velocity of right wheel (rad/s)
u_wl = pi/2;                 % Angular velocity of left wheel (rad/s)

u1 = u_wr;                   % Input variable control, u_wr
u2 = u_wl;                   % Input variable control, u_wl

v_wr = R_wr * u1;          % Linear velocity of right wheel (m/s)
v_wl = R_wl * u2;          % Linear velocity of right wheel (m/s)

v_t = (v_wr + v_wl) / 2;     % Linear velocity of robot. (m/s)
v_r = (v_wr - v_wl) / (2*b); % Angular velocity of robot (rad/s)




% Noise parameters
% System noise covariance we have assumed:
Q1=0.00001;
Q2=0.00001;
Q3=0.01;

rng(10,'twister'); %random number de semilla 5 de tornado de Mersenne



% Measurement noise covariance
sigma1=0.0001;
sigma2=0.0001;
sigma3=0.01;


input_noise=1e-6; % input noise covariance



%% Simulation parameters
% Total time simulation. Must be the same value than simulink 
Tt=10;

% Temporal interval in each iteration. (s)
Ts = 0.05;    % 20 Hz

t = [0:Ts:Tt]';

        
% Simulation of robot
x1 = x0;
x2 = y0;
x3 = theta0;




% Initialization of state vector
X_ideal = [x0;y0;theta0];




% Contador
k = 1;
for t_i = Ts:Ts:Tt  

    
    % Movement
    X_current_ideal = [x1 + Ts * v_t * cos(x3) - (1/2) * (Ts^2) * v_t * v_r * sin(x3);
                       x2 + Ts * v_t * sin(x3) + (1/2) * (Ts^2) * v_t * v_r * cos(x3);
                       x3 + Ts * v_r];
    
      
    % Trajectory
    X_ideal = [X_ideal,X_current_ideal];
    
    % Update position
    x1 = X_ideal(1,k+1);
    x2 = X_ideal(2,k+1);
    x3 = X_ideal(3,k+1);
    
    
    k=k+1;
    

end

figure(1),
subplot(311),plot(t',X_ideal(1,:),'k','LineWidth',1),ylabel('x(m)'),xlabel('time(s)'),legend('x'),grid minor
subplot(312),plot(t',X_ideal(2,:),'k','LineWidth',1),ylabel('y(m)'),xlabel('time(s)'),legend('y'),grid minor
subplot(313),plot(t,X_ideal(3,:),'k','LineWidth',1),ylabel('r(rad)'),xlabel('time(s)'),legend('r'),grid minor,title('Movement real')

figure(2),
plot(X_ideal(1,:),X_ideal(2,:),'k',X_ideal(1,1),X_ideal(2,1),'*g',X_ideal(1,length(X_ideal)),X_ideal(2,length(X_ideal)),'*m'),
ylabel('x(m)'),xlabel('y(m)'),legend('trajectory','initial position','final position'),grid minor,title('Traectory')

figure(3),plot3(X_ideal(1,:),X_ideal(2,:),X_ideal(3,:),'k',X_ideal(1,1),X_ideal(2,1),X_ideal(3,1),'*g',X_ideal(1,length(X_ideal)),X_ideal(2,length(X_ideal)),X_ideal(3,length(X_ideal)),'*m'),
ylabel('x(m)'),xlabel('y(m)'),zlabel('r(rad)'),legend('trajectory','initial position','final position'),grid minor,title('ideal Trajectory 3D');
%% Filtro de Kalman
% Implementación del filtro del kalman mediante la odometría.
% Predición de estados según la odometría.
% 'x_(k) = f(x_(k-1),u_(k))
% 'C_(k) = F_(x)C_(k)F_(x)'+F_(u)U_(k)F_(u)'

x1 = x0;
x2 = y0;
x3 = theta0;
% Initialization of state vector
X = [x0;y0;theta0];
X_KALMAN = X;

% Contador
k = 1;

% Error covariance matrix:
P_initial=eye(3);




for t_i = Ts:Ts:Tt  

    
    % Random noise of process
    w1 = sqrt(Q1)*randn(1,1); 
    w2 = sqrt(Q2)*randn(1,1); 
    w3 = sqrt(Q3)*randn(1,1); 
    Q=diag([w1,w2,w3]);
    
    % Random noise of measurements
    v1 = sqrt(sigma1)*randn(1,1);
    v2 = sqrt(sigma2)*randn(1,1);
    v3 = sqrt(sigma3)*randn(1,1);
    SensorCov=[v1,v2,v3];

    R=[];
    R=diag([SensorCov]);

    %% Movement of robot
    X_current = [x1 + Ts * v_t * cos(x3) - (1/2) * (Ts^2) * v_t * v_r * sin(x3) + w1;
                 x2 + Ts * v_t * sin(x3) + (1/2) * (Ts^2) * v_t * v_r * cos(x3) + w2;
                 x3 + Ts * v_r + w3];    
             
   [A,B,H] = KALMAN_MATRIX(x1,x2,x3,Ts,u1,u2,b,R_wr,R_wl);
    % Measurement vector
    z = H*(X_current) + R*randn(3,1);
    

    
 
    %% EKF
    
    % Prediccion
    xPred= A*X(:,k)+B*input_noise*[u1;u2]; 
    P=A*P_initial*A'+input_noise*B*eye(2,2)*B'+Q;
 
    
    % Update
    K=P*H'*inv(H*P*H'+R);
    xEst = xPred + K*(z - H*xPred); 
    P = (eye(size(K,1)) - K*H)*P;

    X_KALMAN = [X_KALMAN xEst];
%     X_KALMAN = [X_KALMAN xEst];
    
    %% Trajectory
    % Trajectory
    X = [X,X_current];
    % Position
    x1 = X(1,k+1);
    x2 = X(2,k+1);
    x3 = X(3,k+1);
    
    if rem(k,3)==0
        figure(4), hold on
        plot(t(1:k)',X_KALMAN(3,1:k),'r','LineWidth',1)
        plot(t(1:k)',X(3,1:k),'k','LineWidth',1),
        plot(t(1:k)',X_ideal(3,1:k),'b',t(1)',X_ideal(3,1),'*g'),
        ylabel('angle (rad)'),xlabel('time(s)'),legend('filter','real','ideal','initial position'),title('EKF angle sensor real time'),
    end

    k=k+1;
    

end

figure(4), hold on
plot(t',X_KALMAN(3,:),'r','LineWidth',1)
plot(t',X(3,1:k),'k','LineWidth',1),
plot(t',X_ideal(3,:),'b',t(1)',X_ideal(3,1),'*g',t(length(t)),X_ideal(3,length(X_ideal)),'*m'),
ylabel('angle (rad)'),xlabel('time(s)'),legend('filter','real','ideal','initial position','final position'),title('EKF angle sensor real time'),

figure(5), hold on
plot(t',X_KALMAN(1,:),'r','LineWidth',1)
plot(t',X(1,:),'k','LineWidth',1),
plot(t',X_ideal(1,:),'b',t(1)',X_ideal(1,1),'*g',t(length(t)),X_ideal(1,length(X_ideal)),'*m'),
ylabel('x (m)'),xlabel('time(s)'),legend('filter','real','ideal','initial position','final position'),title('EKF position x sensor real time'),grid minor

figure(6), hold on
plot(t',X_KALMAN(2,:),'r','LineWidth',1)
plot(t',X(2,:),'k','LineWidth',1),
plot(t',X_ideal(2,:),'b',t(1)',X_ideal(2,1),'*g',t(length(t)),X_ideal(2,length(X_ideal)),'*m'),
ylabel('y (m)'),xlabel('time(s)'),legend('filter','real','ideal','initial position','final position'),title('EKF position y sensor real time'),grid minor

figure(7),
plot(X_KALMAN(1,:),X_KALMAN(2,:),'r',X(1,:),X(2,:),'k',X_ideal(1,:),X_ideal(2,:),'b',X_ideal(1,1),X_ideal(2,1),'*g',X_ideal(1,length(X_ideal)),X_ideal(2,length(X_ideal)),'*m'),
ylabel('y (m)'),xlabel('x(m)'),legend('filter','real','ideal','initial position','final position'),title('Sensor real vs EKF'),grid minor

  
figure(8),
plot3(X_KALMAN(1,:),X_KALMAN(2,:),X_KALMAN(3,:),'r',X(1,:),X(2,:),X(3,:),'k',X_ideal(1,:),X_ideal(2,:),X_ideal(3,:),'b',X_ideal(1,1),X_ideal(2,1),X_ideal(3,1),'*g',X_ideal(1,length(X_ideal)),X_ideal(2,length(X_ideal)),X_ideal(3,length(X_ideal)),'*m'),
legend('EKF','REAL','IDEAL','initial position','final position'),xlabel('x(m)'),ylabel('y(m)'),zlabel('r(rad)'),grid minor,title('Sensor real vs EKF 3D')

