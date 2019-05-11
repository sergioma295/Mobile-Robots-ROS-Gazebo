function callbackMOVEMENT(msg,m)

pause(1);

global x
global y

chatpub = rospublisher('/executePlan','std_msgs/UInt8MultiArray');
msg = rosmessage(chatpub);
p = calculatePath([x,y],[0,0]);

if length(p) ~= 0
    msg.Data = p;
    msg.Layout.DataOffset = length(msg.Data);
    send(chatpub,msg);
    pause(0.5);
else
    p = calculatePath([x-1,y],[0,0]);
    if length(p) ~= 0
        p = [p;6];
        msg.Data = p;
        msg.Layout.DataOffset = length(msg.Data);
        send(chatpub,msg);
        pause(1);
        disp('Path approximated');
    else
        p = calculatePath([x+1,y],[0,0]);
        if length(p) ~= 0
            p = [p;2];
            msg.Data = p;
            msg.Layout.DataOffset = length(msg.Data);
            send(chatpub,msg);
            pause(1);

            disp('Path approximated');
        else
            p = calculatePath([x,y-1],[0,0]);
            if length(p) ~= 0
                p = [p;4];
                msg.Data = p;
                msg.Layout.DataOffset = length(msg.Data);
                send(chatpub,msg);
                pause(1);

                disp('Path approximated');
            else
                p = calculatePath([x,y+1],[0,0]);
                if length(p) ~= 0
                    p = [p;0];
                    msg.Data = p;
                    msg.Layout.DataOffset = length(msg.Data);
                    send(chatpub,msg);
                    pause(1);

                    disp('Path approximated');
                else
                    disp('Path not found');
                end
            end
        end
            
            
    end
end


end

