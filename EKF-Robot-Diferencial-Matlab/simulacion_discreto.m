function [x_vector_d,y_vector_d,r_vector_d] = simulacion_discreto(x0,y0,theta0,Ts,Tt,t,v_t,v_r,P_xd,P_yd,P_rd,Q1,Q2,Q3,R1,R2,R3)
        
%% Simulation kinematics
        x_old = x0;
        y_old = y0;
        r_old = theta0;

        % Representation vector.
        x_vector_d = [x0];
        y_vector_d = [y0];
        r_vector_d = [theta0];


    for t_i = Ts:Ts:Tt

        % Mode l.
        x_new = x_old + Ts * v_t * cos(r_old) - (1/2) * (Ts^2) * v_t * v_r * sin(r_old) + Q1;
        y_new = y_old + Ts * v_t * sin(r_old) + (1/2) * (Ts^2) * v_t * v_r * cos(r_old) + Q2;
        r_new = r_old + Ts * v_r + Q3;




        % Update x,y,r vector.
        x_vector_d = [x_vector_d;x_new];
        y_vector_d = [y_vector_d;y_new];
        r_vector_d = [r_vector_d;r_new];

        % Update. 
        x_old = x_new;
        y_old = y_new;
        r_old = r_new;



    end


    %% Representación Gráfica de los resultados.
    figure(1)
    subplot(311),plot(t,P_xd,'k'),ylabel('x'),xlabel('time(s)'),legend('x'),title('Robot Model ideal (Discrete) .slx');
    subplot(312),plot(t,P_yd,'k'),ylabel('y'),xlabel('time(s)'),legend('y');
    subplot(313),plot(t,(180/pi)*P_rd,'k'),ylabel('phi(º)'),xlabel('time(s)'),legend('phi');

    figure(2)
    subplot(311),plot(t,x_vector_d,'k',t,P_xd,'--r'),ylabel('x'),xlabel('time(s)'),legend('x real', 'x ideal'),title('Robot Model ideal vs noise (Discrete)');
    subplot(312),plot(t,y_vector_d,'k',t,P_yd,'--r'),ylabel('y'),xlabel('time(s)'),legend('y real','y ideal');
    subplot(313),plot(t,(180/pi)*r_vector_d,'k',t,(180/pi)*P_rd,'--r'),ylabel('phi(º)'),xlabel('time(s)'),legend('phi real','phi ideal');

    figure(3)
    plot(x_vector_d(1,1),y_vector_d(1,1),'-s',x_vector_d(length(x_vector_d),1),y_vector_d(length(y_vector_d),1),'-s',x_vector_d,y_vector_d,'k');
    ylabel('y'),xlabel('x'), legend('initial position', 'final position','robot movement'),title('Robot Movement real (Discrete)');

    figure(4)
    plot(x_vector_d(1,1),y_vector_d(1,1),'-s',x_vector_d(length(x_vector_d),1),y_vector_d(length(y_vector_d),1),'-s',P_xd,P_yd,'b',P_xd(1,1),P_yd(1,1),'-s',P_xd(length(P_xd),1),P_yd(length(P_yd),1),'-s',x_vector_d,y_vector_d,'r');
    xlim([-20 20]),ylim([-20,20]),ylabel('y'),xlabel('x'), grid on, legend('initial position real', 'final position real','mov ideal','initial position ideal', 'final position ideal','mov real'),title('Robot Movement (Discrete)');

end

