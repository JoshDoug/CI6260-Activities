% Week 6

% Task 1 - Sphere
subplot(1,3,1);
[x, y, z] = sphere(100); % Generate spherical coordinates
surf(x, y, z) % Plot sphere

% Task 2 - Lighting function experimentation
subplot(1,3,2);
surf(x, y, z)
lighting phong % Adjust lighting
shading interp % Smooth shading with interpolation option
light % Create simple light source

% Task 3 - Material experimentation
subplot(1,3,3);
surf(x, y, z)
shading interp
material dull % Set material
lighting phong
light

% Task 4 - Move light source around sphere
figure(2)
surf(x, y, z)
shading interp
lighting phong
h = light;

for az = -180:10:180 % Blocks Task 5 from running until finished
    lightangle(h, az, 20) % Alter angle on light handle
    pause(.1) % Short pause to animate smoothly
end

% Task 5 - Map texture onto sphere surface
figure(3)
[I, map] = imread('marsTexture.png');
[x, y, z] = sphere(100);
warp(x,y,z,I) % Map image to sphere and plot it

lighting phong

h = light;

for az = -180:5:180
    lightangle(h, az, 20)
    pause(.1)
end

% Task 6 - Shadows in seperate file, shadow.m
