% Test 3D working clock and transforms

clear;

figClock = figure; % Grab figure handle to allow animation to be cancelled
axis([-10 10 -10 10 -4 7])
light

% Create transform objects
t1 = hgtransform;

% Create base/body of clock
[x, y, z] = filledCylinderAlt(10, 50, [0 1]);
h(1) = surface(x, y, z, 'Parent', t1, 'FaceColor', 'black', 'LineStyle', 'none');

% Create clock bezel
[x, y, z] = hollowCylinder(10, 9, 50, [1 1.1]);
h(2) = surface(x, y, z, 'Parent', t1, 'FaceColor', 'white', 'LineStyle', 'none');

% Hour Markers
[cx, cy, cz] = cuboid(0.5, 1, 0.1);
cz = cz + 1;

% Preallocate arrays
tm = zeros(1, 10);
markerHandle = zeros(1, 10);

% Create initial transform object and handle
tm(1) = hgtransform;
markerHandle(1) = surface(cx, cy, cz, 'Parent', tm(1), 'FaceColor', 'white', 'LineStyle', 'none');
% Create translation to move object to bezel
trm = makehgtform('translate', [0 8 0]);
% Initialise initial transform object
set(tm(1), 'Matrix', trm);

% Draw markers
for i=2:12
    tm(i) = hgtransform;
    markerHandle(i) = copyobj(markerHandle(1), tm(i));    
    TRz = makehgtform('zrotate', pi/6 * (i -1));
    set(tm(i), 'Matrix', TRz * trm);
end

% Clock Hands
shtransform = hgtransform;
[shx, shy, shz] = cuboid(0.5, 9, 0.15); % Second Hand

mhtransform = hgtransform;
[mhx, mhy, mhz] = cuboid(1, 8, 0.1); % Minute hand

hhtransform = hgtransform;
[hhx, hhy, hhz] = cuboid(1, 6, 0.1); % Hour Hand

ttch = makehgtform('translate', [0 -0.5 1]); % Center hands

% Setup clock hand handles
ch(1) = surface(mhx, mhy, mhz, 'Parent', mhtransform, 'FaceColor', 'white', 'LineStyle', 'none');
ch(2) = surface(hhx, hhy, hhz, 'Parent', hhtransform, 'FaceColor', 'white', 'LineStyle', 'none');
ch(3) = surface(shx, shy, shz, 'Parent', shtransform, 'FaceColor', 'red', 'LineStyle', 'none');

degree = pi/180; % Simplify rotation maths

% Animate clock hands
while ishghandle(figClock) % Allows animation to be stopped more easily by exiting figure
   time = clock; % Get time and calculate degree offsets for hours, minutes and seconds
   hour = degree * time(4) * 30;
   min = degree * time(5) * 6;
   sec = degree * time(6) * 6;
   
   % Setup transformations
   trsh = makehgtform('zrotate', -sec);
   trmh = makehgtform('zrotate', -min);
   trhh = makehgtform('zrotate', -hour);
   
   % Redraw clock hands
   set(mhtransform, 'Matrix', trmh * ttch);
   set(hhtransform, 'Matrix', trhh * ttch);
   set(shtransform, 'Matrix', trsh * ttch);
   
   drawnow
end







