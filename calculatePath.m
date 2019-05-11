function [path] = calculatePath(origin,destiny)

p = [];
d = bfs(origin,destiny);
path = [];

if(length(d) ~= 0)
    % Ordering path
    while isempty(d.father) == 0
        p = [d;p];
        d = d.father;
    end

p = [d;p];

path = [];

    % Calculating poses for path
    for i=1:length(p)-1
        if (p(i).x - p(i+1).x) == 1
            path = [path; 6];
        elseif (p(i).x - p(i+1).x) == -1
            path = [path; 2];
        elseif (p(i).y - p(i+1).y) == 1
            path = [path; 4];
        else
            path = [path;0];
        end
    end
end
end

