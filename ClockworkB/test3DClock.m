% Test 3D working clock and transforms

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

for i=2:12
    %disp(i)
    tm(i) = hgtransform;
    markerHandle(i) = copyobj(markerHandle(1), tm(i));
    
    %set(markerHandle(i), 'Parent', tm(i));
    
    TRz = makehgtform('zrotate', pi/6 * (i -1));
    set(tm(i), 'Matrix', TRz * trm);
end

% Clock Hands - only Hour and Minute for this necessary
mhtransform = hgtransform;
[mhx, mhy, mhz] = cuboid(1, 8, 0.1); % Minute hand
mhz = mhz + 1;
mhy = mhy - 0.5;
hhtransform = hgtransform;
[hhx, hhy, hhz] = cuboid(1, 6, 0.1); % Hour Hand
hhz = hhz + 1;
hhy = hhy - 0.5;

ch(1) = surface(mhx, mhy, mhz, 'Parent', mhtransform, 'FaceColor', 'white', 'LineStyle', 'none');
ch(2) = surface(hhx, hhy, hhz, 'Parent', hhtransform, 'FaceColor', 'white', 'LineStyle', 'none');

trmh = makehgtform('zrotate', pi/2);
set(mhtransform, 'Matrix', trmh);

%set(h, 'Parent', t1);
