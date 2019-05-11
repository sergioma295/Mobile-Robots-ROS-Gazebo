global map
global left_x
global left_y
global right_x
global right_y

left_x = 0;
left_y = 0;

right_x = 0;
right_y = 0;


x = -12.10;
y = 11.70;

while x < 11.70 
    while y > -12.10
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
      y = y - 0.1;
    end
    x = x + 0.1;
    y = 11.70;
end
