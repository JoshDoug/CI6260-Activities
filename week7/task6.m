% Week 7 - Task 6
% Object following a more complex orbit - basic Lissajou curve/figure of 8

% Set up Lissajou Curve
circuits = 2; % Number of circuits
t = 0:0.005:circuits*2; % Generate a range of numbers
x = sin(pi * t) * 8; % Generate x coordinates of curve
i = 4; % Increase i by multiples of 2 to increase the complexity of the curve, use 2 for a figure of 8
y = sin(i * pi * t) * 8; % Generate y coordinates of curve

%comet(x, y); % Helpful for viewing the curve being plotted and seeing the
% number of circuits that are made

% Set up graphical object - simple plane
ax = axes('xlim', [-2 2], 'ylim', [-2 10], 'zlim', [-1.5 1.5]); % Set graphical container axes
view(3); grid on; axis([-10 10 -10 10 -1 2])
[xcyl, ycyl, zcyl]=cylinder([0.2 0.2]);
[xcone, ycone, zcone]=cylinder([0.1 0]);

% create a simple aeroplane shape
h(1)=surface(xcone, zcone, -ycone, 'FaceColor', 'red');
h(2)=surface(zcyl, ycyl, 0.5*xcyl, 'FaceColor', 'blue');
h(3)=surface(-zcyl, ycyl, 0.5*xcyl, 'FaceColor', 'yellow');
h(4)=surface(xcyl, -1.5*zcyl, 0.5*ycyl, 'FaceColor', 'red');
h(5)=surface(xcone, (1.5*ycone)-1.3, zcyl, 'FaceColor', 'red');

% create group object and parent surfaces
t = hgtransform('parent', ax);
set(h, 'parent', t);

hold on
plot(x,y); % Plot curve that plane will follow
xlabel('x'); % Label axes for convenience
ylabel('y');
zlabel('z');

for i=2:length(x) % Walk through curve coordinates and transform plane
    Tx = makehgtform('translate', [x(i) y(i) 0.5]); % Create translation matrix for current coordinates
    r = atan2(y(i) - y(i -1), x(i) - x(i -1)) - pi/2; % Work out angle of line and -90 degrees to account for plane rotation
    Rx = makehgtform('zrotate', r); % Create rotation matrix
    set(t, 'matrix', Tx * Rx) % Apply transforms
    pause(0.05)
    drawnow
end