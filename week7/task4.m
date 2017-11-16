% Week 7, Task 4 - Second MatLab Example
% Alter MatLab example to rotate one object differently and have it orbit
% another object

ax = axes('XLim',[-3 1],'YLim',[-3 1],'ZLim',[-1 1]);
view(3)
grid on
axis([-3 3 -3 3 -1 1])

[x,y,z] = cylinder([.2 0]);
h(1) = surface(x,y,z,'FaceColor','red');
h(2) = surface(x,y,-z,'FaceColor','green');
h(3) = surface(z,x,y,'FaceColor','blue');
h(4) = surface(-z,x,y,'FaceColor','cyan');
h(5) = surface(y,z,x,'FaceColor','magenta');
h(6) = surface(y,-z,x,'FaceColor','yellow');

t1 = hgtransform('Parent',ax); % Create transform object 1
t2 = hgtransform('Parent',ax); % Create transform object 2

set(h, 'Parent',t1) % Initialise transform obj 1
h2 = copyobj(h,t2); % Create a copy of the h graphics object, and add them to t2?
% The h2 is just a handle that is unused and unneccessary..

Txy = makehgtform('translate',[-1.5 -1.5 0]); % Create a transform in x and y by -1.5
set(t2,'Matrix',Txy) % Initialise t2

drawnow % Force draw

% Rotate 10 times (2pi radians = 1 rotation)
for r = 1:.05:5*pi
    Rz = makehgtform('zrotate', r); % Form z-axis rotation matrix
    Ry = makehgtform('yrotate', r); % Form y-axis rotation matrix
    Rx = makehgtform('xrotate', r); % Form x-axis rotation matrix
    % Set transforms for both transform objects
    set(t1,'Matrix',Ry * Rx * Rz)
    %set(t2,'Matrix',Txy * inv(Rz))
    set(t2,'Matrix',Rz * Txy / Ry) % Matlab complains about use of inv
    drawnow
end