function [ cylinderTop, cylinderMiddle, cylinderBase ] = filledCylinder( radius, numSides, zHeights )
%FILLEDCYLINDER Creates a solid cylinder (cylinder with a circle at top and base)
%   Creates a solid cylinder at coordinates 0,0 for x,y.

% Create top
cylinderTop = circleJDS(0, 0, radius, numSides);
cylinderTop(3,:) = (cylinderTop(1,:) * 0) + zHeights(1);

% Draw cylinder
[cx, cy, cz] = cylinder(5, numSides);
cz(1,:) = zHeights(1);
cz(2,:) = zHeights(2);
cylinderMiddle.x = cx;
cylinderMiddle.y = cy;
cylinderMiddle.z = cz;

% Draw base
cylinderBase = cylinderTop(:,:);
cylinderBase(3,:) = (cylinderBase(1,:) * 0) + zHeights(2);

end