function [current] =  bfs(origin,destiny)

global map
global inflateMap
global matrix_visited

if inflateMap == 0
    inflate(map,0.2);
    inflateMap = 1;
end

matrix_visited = zeros(100,100);

% Restando 2 puesto que la posicion (0,0) 
% se corresponde a (2,2) en Gazebo
matrix_visited(origin(1)+3,origin(2)+3);

q = CQueue();

p = point;

% origin = checkLimits(origin);

p.x = origin(1);
p.y = origin(2);

q.push(p);

j = 1;
while q.size() ~= 0
    
    current = q.front();
    q.pop();
    
    
    j = j+1;
    
    if current.getX == destiny(1) && current.getY == destiny(2)       
        break
    end
    
    children = current.generate_children();
    
    for i=0:length(children)-1
       
        if (children(i+1).x+1 > 0 && children(i+1).y+1 > 0) == 1
            if matrix_visited(children(i+1).x+3,children(i+1).y+3) == 0
         
                q.push(children(i+1))
                matrix_visited(children(i+1).x+3,children(i+1).y+3) = 1;
            end
        end
    end
    
end


%     if (current.x ~=0 || current.y ~=0)
%         current = [];
%     end

end

