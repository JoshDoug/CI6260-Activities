% Week 7

% Task 3
myaxes=axes('xlim', [-2 2], 'ylim', [-2 10], 'zlim', [-1.5 1.5]);
view(3); grid on; axis equal %axis([-5 5 -5 10 -5 5])
[xcyl, ycyl, zcyl]=cylinder([0.2 0.2]);
[xcone, ycone, zcone]=cylinder([0.1 0]);

xlabel('x');
ylabel('y');
zlabel('z');

 % create a simple aeroplane shape
h(1)=surface(xcone, zcone, -ycone, 'FaceColor', 'red');
h(2)=surface(zcyl, ycyl, 0.5*xcyl, 'FaceColor', 'blue');
h(3)=surface(-zcyl, ycyl, 0.5*xcyl, 'FaceColor', 'yellow');
h(4)=surface(xcyl, -1.5*zcyl, 0.5*ycyl, 'FaceColor', 'red');
h(5)=surface(xcone, (1.5*ycone)-1.3, zcyl, 'FaceColor', 'red');

%create group object and parent surfaces
t=hgtransform('parent', myaxes);
set(h, 'parent', t);
set(gcf, 'Renderer', 'opengl');

for r = 1:.1:2*pi
    % Z-axis rotation matrix
    Rz = makehgtform('zrotate',r);
    % set the transform Matrix property
    set(t,'Matrix',Rz)
    drawnow
end