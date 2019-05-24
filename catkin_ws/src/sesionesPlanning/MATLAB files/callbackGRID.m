function callbackGRID(msg,grid)

global map

map = readBinaryOccupancyGrid(grid);


global left_x
global left_y
global right_x
global right_y

left_x = 0;
left_y = 0;

right_x = 0;
right_y = 0;


%x = -12.10;
%y = 11.70;

x = map.XWorldLimits(1);
y = map.YWorldLimits(1);

%% 11.70 and -12.10
while x < map.XWorldLimits(2) 
    while y < map.YWorldLimits(2)
      occupied = getOccupancy(map,[x y]);
      if occupied == 1
        if y > left_y
         left_y = y;
        end
        if y < right_y
         right_y = y;
        end
        if x > left_x
         left_x = x;
        end
        if x < right_x
         right_x = x;
        end
      end
      y = y + 0.05;
    end
    x = x + 0.05;
    y = map.YWorldLimits(1);
end



chatpub = rospublisher('/limits','geometry_msgs/Quaternion');

msg = rosmessage(chatpub);
msg.X = left_x;
msg.Y = left_y;
msg.Z = right_x;
msg.W = right_y;

send(chatpub,msg);

end

