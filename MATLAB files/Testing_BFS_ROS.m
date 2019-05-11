global x
global y

chatpub = rospublisher('/executePlan','std_msgs/UInt8MultiArray');
msg = rosmessage(chatpub);
destiny = [0,0];
p = calculatePath([x,y],destiny);

if length(p) ~= 0
    msg.Data = p;
    msg.Layout.DataOffset = length(msg.Data);
    send(chatpub,msg);
else
    p = calculatePath([x-1,y],destiny);
    if length(p) ~= 0
        p = [p;6];
        msg.Data = p;
        msg.Layout.DataOffset = length(msg.Data);
        send(chatpub,msg);
        disp('Path approximated');
    else
        p = calculatePath([x+1,y],destiny);
        if length(p) ~= 0
            p = [p;2];

            msg.Data = p;
            msg.Layout.DataOffset = length(msg.Data);
            send(chatpub,msg);
            disp('Path approximated');
        else
            p = calculatePath([x,y-1],destiny);
            if length(p) ~= 0
                p = [p;4];

                msg.Data = p;
                msg.Layout.DataOffset = length(msg.Data);
                send(chatpub,msg);
                disp('Path approximated');
            else
                p = calculatePath([x,y+1],destiny);
                if length(p) ~= 0
                    p = [p;0];

                    msg.Data = p;
                    msg.Layout.DataOffset = length(msg.Data);
                    send(chatpub,msg);
                    disp('Path approximated');
                else
                    disp('Path not found');
                end
            end
        end
            
            
    end
end

