% Testing

% Create a Bezel - a hollow cylinder that still has width
figure(1)
[a, b, c] = cylinder(2, 50);
[d, e, f] = cylinder(1, 50);

topx = [a(1,:); d(1,:)];
topy = [b(1,:); e(1,:)];
topz = [c(1,:); f(1,:)];

basex = [a(2,:); d(2,:)];
basey = [b(2,:); e(2,:)];
basez = [c(2,:); f(2,:)];

x = [topx a d basex];
y = [topy b e basey];
z = [topz c f basez];

surface(x, y, z)

% Create a filled cylinder
figure(2)

% Create top
circleTest = circleJDS(0, 0, 5, 20);
circleTest(3,:) = (circleTest(1,:) * 0) + 1;
fill3(circleTest(1,:), circleTest(2,:), circleTest(3,:), 'r')

hold on

% Draw cylinder
[cx, cy, cz] = cylinder(5);
surface(cx, cy, cz);

% Draw base
circleTest(3,:) = (circleTest(1,:) * 0);
fill3(circleTest(1,:), circleTest(2,:), circleTest(3,:), 'r')

% Use filled cylinder function
figure(3)
[cylinderTop, cylinderMiddle, cylinderBase] = filledCylinder(5, 50, [0 0.5]);

hold on

fill3(cylinderTop(1,:), cylinderTop(2,:), cylinderTop(3,:), 'r')
surface(cylinderMiddle.x, cylinderMiddle.y, cylinderMiddle.z);
fill3(cylinderBase(1,:), cylinderBase(2,:), cylinderBase(3,:), 'r')
view(3)

% Use hollow cylinder function
figure(4)
[x, y, z] = hollowCylinder(2, 1, 20, [0 5]);
surface(x, y, z)

% Use alternate filled cylinder function
figure(5)
[x, y, z] = filledCylinderAlt(5, 50, [0 1]);
surface(x, y, z)

hold on

plot3([0 0], [0 5], [1.5 1.5], 'Color', 'r', 'LineWidth', 4);
