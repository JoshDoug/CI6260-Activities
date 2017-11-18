% Test 3D working clock and transforms

axis([-10 120 -10 50 -4 7])
light

% Create transform objects

% Create transforms to move clocks into position
Tmatrix = zeros(4, 4, 18);
Hbody = zeros(1, 18); % Handle for clock bodies
Ttransform = zeros(1, 18);
Ttransform(1) = hgtransform;

for i=0:5
   tx = i * 20;
   inc = (i * 3) + 1;
   Tmatrix(:,:, inc) = makehgtform('translate', [tx 0 0]);
   Tmatrix(:,:, inc + 1) = makehgtform('translate', [tx 20 0]);
   Tmatrix(:,:, inc + 2) = makehgtform('translate', [tx 40 0]);
end

% Create base/body of clock
[x, y, z] = filledCylinderAlt(10, 50, [0 1]);
h(1) = surface(x, y, z, 'Parent', Ttransform(1), 'FaceColor', 'black', 'LineStyle', 'none');

% Create clock bezel
[x, y, z] = hollowCylinder(10, 9, 50, [1 1.1]);
h(2) = surface(x, y, z, 'Parent', Ttransform(1), 'FaceColor', 'white', 'LineStyle', 'none');

for i=2:18
    Ttransform(i) = hgtransform;
    temp = copyobj(h, Ttransform(i));
    set(Ttransform(i), 'Matrix', Tmatrix(:,:,i));
end

% Hour Markers
[cx, cy, cz] = cuboid(0.5, 1, 0.1);
cz = cz + 1;

% Preallocate arrays
tm = zeros(1, 12*18);
markerHandle = zeros(1, 12*18);

% Create initial transform object and handle
tm(1) = hgtransform;
markerHandle(1) = surface(cx, cy, cz, 'Parent', tm(1), 'FaceColor', 'white', 'LineStyle', 'none');
% Create translation to move object to bezel
trm = makehgtform('translate', [0 8 0]);
% Initialise initial transform object
set(tm(1), 'Matrix', trm);

% This could probably be made faster - significantly impacts initial startup time
inc = 0;
for i=1:18
    for j=1:12
        inc = inc + 1;
        tm(inc) = hgtransform;
        markerHandle(inc) = copyobj(markerHandle(1), tm(inc));    
        TRz = makehgtform('zrotate', pi/6 * (j -1));
        set(tm(inc), 'Matrix', Tmatrix(:,:,i) * TRz * trm);
    end
end

% Clock Hands - only Hour and Minute for this necessary
% mhtransform = hgtransform;
% [mhx, mhy, mhz] = cuboid(1, 8, 0.1); % Minute hand
% hhtransform = hgtransform;
% [hhx, hhy, hhz] = cuboid(1, 6, 0.1); % Hour Hand
% 
% ttch = makehgtform('translate', [0 -0.5 1]);
% trmh = makehgtform('zrotate', pi/2);
% 
% ch(1) = surface(mhx, mhy, mhz, 'Parent', mhtransform, 'FaceColor', 'white', 'LineStyle', 'none');
% ch(2) = surface(hhx, hhy, hhz, 'Parent', hhtransform, 'FaceColor', 'white', 'LineStyle', 'none');
% 
% set(mhtransform, 'Matrix', trmh * ttch);
% set(hhtransform, 'Matrix', ttch);