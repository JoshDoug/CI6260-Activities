function [ xy ] = circleJDS( cx, cy, r, n)
%circleJDS Calculate x and y coordinates for a circle
%   Takes cx (center x coord), cy (center y coord), r (radius),
%   n (number of plot points) parameters

t = linspace(2*pi, 0, n+1);
x = (cos(t) * r) + cx;
y = (sin(t) * r) + cy;
xy = [x;y];

end