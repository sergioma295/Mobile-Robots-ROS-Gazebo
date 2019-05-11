classdef point
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x
        y
        father
    end
    
    methods
        function x = getX(obj)
            x = obj.x;
        end
        
        function y = getY(obj)
            y = obj.y;
        end
        
        function f = getFather(obj)
            f = obj.father;
        end
        
        function children = generate_children(obj)
            children = [];
            global map
            global left_x
            global right_x
            global left_y
            global right_y
            
            if obj.x-1 >= right_x && obj.x-1 <= left_x && freePath(obj,1) == 0
               child1 = point;
               child1.x = obj.x-1;
               child1.y = obj.y;
               child1.father = obj;
               
               children = [children;child1];
            end
            
            if obj.x+1 >= right_x && obj.x+1 <= left_x && freePath(obj,2) == 0
               child1 = point;
               child1.x = obj.x+1;
               child1.y = obj.y;
               child1.father = obj;
               
               children = [children;child1];
            end
            
            if obj.y-1 >= right_y && obj.y-1 <= left_y && freePath(obj,4) == 0
               child1 = point;
               child1.x = obj.x;
               child1.y = obj.y-1;
               child1.father = obj;
               
               children = [children;child1];
            end
            
            if obj.y+1 >= right_y && obj.y+1 <= left_y && freePath(obj,3)  == 0
               child1 = point;
               child1.x = obj.x;
               child1.y = obj.y+1;
               child1.father = obj;
               
               children = [children;child1];
            end
        end
        
    end
end

