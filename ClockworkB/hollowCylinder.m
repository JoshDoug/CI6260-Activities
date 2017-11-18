function [ x, y, z ] = hollowCylinder( outerRadius, innerRadius, numSides, zHeights )
%HOLLOWCYLINDER Summary of this function goes here
%   Detailed explanation goes here

% Add option to set height

[a, b, c] = cylinder(outerRadius, numSides);
[d, e, f] = cylinder(innerRadius, numSides);

c(1,:) = zHeights(1);
f(1,:) = zHeights(1);
c(2,:) = zHeights(2);
f(2,:) = zHeights(2);

topx = [a(1,:); d(1,:)];
topy = [b(1,:); e(1,:)];
topz = [c(1,:); f(1,:)];

basex = [a(2,:); d(2,:)];
basey = [b(2,:); e(2,:)];
basez = [c(2,:); f(2,:)];

x = [topx a d basex];
y = [topy b e basey];
z = [topz c f basez];

end