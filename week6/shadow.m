% Task 6 - Shadow
[x, y, z] = sphere(100); % x, y, and z are each matrices with equal numbers of columns and rows
z = z + 5; % Should this be done with a matrix translation? This is far more straightforward.

surf(x, y, z) % Is there a straightforward matrix calculation for this?
shading interp
lighting phong
xlabel('x')
ylabel('y')
zlabel('z')

hold on

% Light Source Coordinates
lx = 1;
ly = 1;
lz = 10;
light('Position', [lx, ly, lz]);

% Shadow Projection Matrix
P1 = [-lz 0 lx 0; 0 -lz ly 0; 0 0 0 0; 0 0 0 -lz];

% Apply projection to sphere coordinates
for i=1:length(x) % Walk through columns
    for j=1:length(x) % Walk through rows
        TF1 = P1 * [x(i,j), y(i,j), z(i,j), 1]'; % Apply projection
        TF1 = TF1 / TF1(4); % Normalise fourth element to 1
        x(i,j) = TF1(1); % Reassign coordinate values
        y(i,j) = TF1(2);
        z(i,j) = TF1(3);
    end
end

surf(x, y, z) % Plot shadow