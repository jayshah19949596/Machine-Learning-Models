function [cost_value] = dist(x1, y1, x2, y2)
    distance = (x1-y1)^2 + (x2-y2)^2;
    cost_value = sqrt(distance);   
end