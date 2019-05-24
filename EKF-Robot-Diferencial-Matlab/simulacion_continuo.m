function [x_vector_c,y_vector_c,r_vector_c] = simulacion_continuo(x0,y0,theta0,Ts,Tt,t,v_t,v_r,P_xc,P_yc,P_rc,Q1,Q2,Q3,R1,R2,R3)
    
    %% Simulation kinematics
    x_old_c = x0;
    y_old_c = y0;
    r_old_c = theta0;

    % Representation vector.
    x_vector_c = [x0];
    y_vector_c = [y0];
    r_vector_c = [theta0];


    for t_i = Ts:Ts:Tt

        % Mode l.
        x_new_c = x_old_c + Ts * v_t * cos(r_old_c) - (1/2) * (Ts^2) * v_t * v_r * sin(r_old_c) + Q1;
        y_new_c = y_old_c + Ts * v_t * sin(r_old_c) + (1/2) * (Ts^2) * v_t * v_r * cos(r_old_c) + Q2;
        r_new_c = r_old_c + Ts * v_r + Q3;




        % Update x,y,r vector.
        x_vector_c = [x_vector_c;x_new_c];
        y_vector_c = [y_vector_c;y_new_c];
        r_vector_c = [r_vector_c;r_new_c];

        % Update. 
        x_old_c = x_new_c;
        y_old_c = y_new_c;
        r_old_c = r_new_c;



    end


    %% Representación Gráfica de los resultados.
    figure(5)
    subplot(311),plot(t,P_xc,'k'),ylabel('x'),xlabel('time(s)'),legend('x'),title('Robot Model ideal (Continous) .slx');
    subplot(312),plot(t,P_yc,'k'),ylabel('y'),xlabel('time(s)'),legend('y');
    subplot(313),plot(t,(180/pi)*P_rc,'k'),ylabel('phi(º)'),xlabel('time(s)'),legend('phi');

    figure(6)
    subplot(311),plot(t,x_vector_c,'k',t,P_xc,'--r'),ylabel('x'),xlabel('time(s)'),legend('x real', 'x ideal'),title('Robot Model ideal vs noise (Continous)');
    subplot(312),plot(t,y_vector_c,'k',t,P_yc,'--r'),ylabel('y'),xlabel('time(s)'),legend('y real','y ideal');
    subplot(313),plot(t,(180/pi)*r_vector_c,'k',t,(180/pi)*P_rc,'--r'),ylabel('phi(º)'),xlabel('time(s)'),legend('phi real','phi ideal');

    figure(7)
    plot(x_vector_c(1,1),y_vector_c(1,1),'-s',x_vector_c(length(x_vector_c),1),y_vector_c(length(y_vector_c),1),'-s',x_vector_c,y_vector_c,'k');
    ylabel('y'),xlabel('x'), legend('initial position', 'final position','robot movement'),title('Robot Movement real (Continous)');

    figure(8)
    plot(x_vector_c(1,1),y_vector_c(1,1),'-s',x_vector_c(length(x_vector_c),1),y_vector_c(length(y_vector_c),1),'-s',P_xc,P_yc,'b',P_xc(1,1),P_yc(1,1),'-s',P_xc(length(P_xc),1),P_yc(length(P_yc),1),'-s',x_vector_c,y_vector_c,'r');
    xlim([-20 20]),ylim([-20,20]),ylabel('y'),xlabel('x'), grid on, legend('initial position real', 'final position real','mov ideal','initial position ideal', 'final position ideal','mov real'),title('Robot Movement (Continous)');

end

