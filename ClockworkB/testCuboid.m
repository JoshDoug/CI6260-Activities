% Test Cuboid

figure(1)

basex = [0 4; 0 4];
basey = [0 0; 4 4];
basez = [0 0; 0 0];

midx = [0 4 4 0 0; 0 4 4 0 0];
midy = [0 0 4 4 0; 0 0 4 4 0];
midz = [0 0 0 0 0; 4 4 4 4 4];

topx = [0 0; 4 4];
topy = [0 4; 0 4];
topz = [4 4; 4 4];

x = [basex midx topx];
y = [basey midy topy];
z = [basez midz topz];

surf(x, y, z);

axis([-5 10 -5 10 0 5])
xlabel('x');
ylabel('y');
zlabel('z');

% Test cube function
figure(2)

[cx, cy, cz] = cuboid(4, 10, 1);
surf(cx, cy, cz);

axis([-5 10 -5 10 0 5])
xlabel('x');
ylabel('y');
zlabel('z');