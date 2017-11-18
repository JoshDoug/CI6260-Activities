% Week 7

ax = axes('XLim', [-2 2], 'YLim', [-2 2], 'ZLim', [-2 2]);
view(3)
%[x, y, z] = cylinder([.2 0]);
[x, y, z] = cylinder([2, 0], 50);
h(1) = surface(x, y, z, 'FaceColor', 'red');
h(2) = surface(x, y, -z, 'FaceColor', 'green');
h(3) = surface(z, x, y, 'FaceColor', 'blue');
h(4) = surface(-z, x, y, 'FaceColor', 'cyan');
h(5) = surface(y, z, x, 'FaceColor', 'magenta');
h(6) = surface(y, -z, x, 'FaceColor', 'yellow');

t = hgtransform('Parent', ax);
set(h, 'Parent', t)

xlabel('x');
ylabel('y');
zlabel('z');

rotate3d on
