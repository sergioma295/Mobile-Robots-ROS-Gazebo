function X = robot_diferencial(x_old,y_old,r_old,Ts,v_t,v_r,Q1,Q2,Q3)
    X = [x_old + Ts * v_t * cos(r_old) - (1/2) * (Ts^2) * v_t * v_r * sin(r_old)+Q1;
         y_old + Ts * v_t * sin(r_old) + (1/2) * (Ts^2) * v_t * v_r * cos(r_old)+Q2;
         r_old + Ts * v_r + Q3];
end

