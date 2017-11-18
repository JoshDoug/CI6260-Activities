% ballistic projectile path

vz = 20.0; % Velocity constant
a = -9.8;  % Acceleration constant, g m/s
t = 0:0.5:6; % Time Samples
z = vz*t + 1/2*a*t.^2; % Z-Locations

% Calculate the position in the x-direction and y-direction
vx = 2;
x = vx*t;
vy = 3;
y = vy*t;

% Compute the components of the velocity vectors and display vectors using
% 3D quiver plot
u = gradient(x);
v = gradient(y);
w = gradient(z);

quiver3(x, y, z, u, v, w, 0.5)