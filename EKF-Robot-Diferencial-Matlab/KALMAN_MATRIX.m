function [A,B,H] = KALMAN_MATRIX(x1,x2,x3,Ts,u1,u2,b,R_wr,R_wl)
    
    A = [1, 0, (u2*cos(x3)*(R_wl*u2 - R_wr*u1)*Ts^2)/(4*b) - sin(x3)*((R_wl*u2)/2 + (R_wr*u1)/2)*Ts;
         0, 1, (u2*sin(x3)*(R_wl*u2 - R_wr*u1)*Ts^2)/(4*b) + cos(x3)*((R_wl*u2)/2 + (R_wr*u1)/2)*Ts;
         0, 0,                                                                                    1];

    B = [(R_wr*Ts*cos(x3))/2 - (R_wr*Ts^2*u2*sin(x3))/(4*b), (R_wl*Ts*cos(x3))/2 + (Ts^2*sin(x3)*(R_wl*u2 - R_wr*u1))/(4*b) + (R_wl*Ts^2*u2*sin(x3))/(4*b);
         (R_wr*u2*cos(x3)*Ts^2)/(4*b) + (R_wr*sin(x3)*Ts)/2, (R_wl*Ts*sin(x3))/2 - (Ts^2*cos(x3)*(R_wl*u2 - R_wr*u1))/(4*b) - (R_wl*Ts^2*u2*cos(x3))/(4*b);
                                            (R_wr*Ts)/(2*b),                                                                              -(R_wl*Ts)/(2*b)];

    H = [1 0 0;
         0 1 0;
         0 0 1]; 


end

