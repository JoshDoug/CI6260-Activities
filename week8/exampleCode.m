% Example Code

% axis([-10 10 -10 10 -10 10])
myaxes=axes('xlim', [-2 2], 'ylim', [-2 10], 'zlim', [-1.5 1.5]);
view(3); grid on; axis([-5 5 -5 10 -5 5]) %axis equal
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

% create a single transformation
Rz=makehgtform('xrotate',-0.5*pi);
% apply transforms and set the transform matrix property
set(t, 'matrix', Rz);
drawnow

longitude=0:10;
latitude=[0 1 1 1 0 0 -1 -1 -1 -1];
bearing=[0 -0.5 0 0 0.5 0 0.5 0 0 0];

% animate simple aeroplane object
for i=1:numel(latitude)
    trans=makehgtform('translate', [latitude(i) longitude(i) 0]);
    rotz=makehgtform('zrotate', bearing(i));
    set(t, 'matrix', trans*rotz);
    pause(0.3)
end
