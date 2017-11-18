% Delete when done


axis([-10 30 -10 50 -4 7])
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
tm = zeros(1, 12*6);
markerHandle = zeros(1, 12*6);

% Create initial transform object and handle
tm(1) = hgtransform;
markerHandle(1) = surface(cx, cy, cz, 'Parent', tm(1), 'FaceColor', 'white', 'LineStyle', 'none');
% Create translation to move object to bezel
trm = makehgtform('translate', [0 8 0]);
% Initialise initial transform object
set(tm(1), 'Matrix', trm);

% This could probably be made faster - significantly impacts initial startup time
inc = 0;
for i=1:6
    for j=1:12
        inc = inc + 1;
        tm(inc) = hgtransform;
        markerHandle(inc) = copyobj(markerHandle(1), tm(inc));    
        TRz = makehgtform('zrotate', pi/6 * (j -1));
        set(tm(inc), 'Matrix', Tmatrix(:,:,i) * TRz * trm);
    end
end

% Clock Hands - only Hour and Minute for this necessary
mhtransform = zeros(1, 6);
mhtransform(1) = hgtransform;
[mhx, mhy, mhz] = cuboid(1, 8, 0.1); % Minute hand
hhtransform = zeros(1, 6);
hhtransform(1) = hgtransform;
[hhx, hhy, hhz] = cuboid(1, 6, 0.1); % Hour Hand

ttch = makehgtform('translate', [0 -0.5 1]);
%trmh = makehgtform('zrotate', pi/2);

mh = zeros(1, 6);
hh = zeros(1, 6);
mh(1) = surface(mhx, mhy, mhz, 'Parent', mhtransform(1), 'FaceColor', 'white', 'LineStyle', 'none');
hh(1) = surface(hhx, hhy, hhz, 'Parent', hhtransform(1), 'FaceColor', 'white', 'LineStyle', 'none');

%set(mhtransform(1), 'Matrix', trmh * ttch);
%set(hhtransform(1), 'Matrix', ttch);

for i=1:6
    mhtransform(i) = hgtransform;
    hhtransform(i) = hgtransform;
    mh(i) = copyobj(mh(1), mhtransform(i));
    hh(i) = copyobj(hh(1), hhtransform(i));
    set(mhtransform(i), 'Matrix', Tmatrix(:,:,i) * ttch);
    set(hhtransform(i), 'Matrix', Tmatrix(:,:,i) * ttch);
end

% Clock Hand Matrices
% Preferably externalise in a seperate file
% minuteHandMatrices;
% hourHandMatrices;
up = 0;
left = pi/2;
right = -pi/2;
down = pi;

% 0 Matrices - Done
hourHandMatrices{1,1} = makehgtform('zrotate', right);
hourHandMatrices{1,2} = makehgtform('zrotate', down);
hourHandMatrices{1,3} = makehgtform('zrotate', right);
hourHandMatrices{1,4} = makehgtform('zrotate', left);
hourHandMatrices{1,5} = makehgtform('zrotate', down);
hourHandMatrices{1,6} = makehgtform('zrotate', left);

minuteHandMatrices{1,1} = makehgtform('zrotate', up);
minuteHandMatrices{1,2} = makehgtform('zrotate', up);
minuteHandMatrices{1,3} = makehgtform('zrotate', down);
minuteHandMatrices{1,4} = makehgtform('zrotate', up);
minuteHandMatrices{1,5} = makehgtform('zrotate', up);
minuteHandMatrices{1,6} = makehgtform('zrotate', down);

% for i=1:6
%     set(mhtransform(i), 'Matrix', Tmatrix(:,:,i) * minuteHandMatrices{1,i} * ttch);
%     set(hhtransform(i), 'Matrix', Tmatrix(:,:,i) * hourHandMatrices{1,i} * ttch);
%     drawnow
% end

% 1 Matrices - Done
hourHandMatrices{2,1} = makehgtform('zrotate', left);
hourHandMatrices{2,2} = makehgtform('zrotate', left);
hourHandMatrices{2,3} = makehgtform('zrotate', left);
hourHandMatrices{2,4} = makehgtform('zrotate', up);
hourHandMatrices{2,5} = makehgtform('zrotate', down);
hourHandMatrices{2,6} = makehgtform('zrotate', down);

minuteHandMatrices{2,1} = makehgtform('zrotate', down);
minuteHandMatrices{2,2} = makehgtform('zrotate', left);
minuteHandMatrices{2,3} = makehgtform('zrotate', up);
minuteHandMatrices{2,4} = makehgtform('zrotate', up);
minuteHandMatrices{2,5} = makehgtform('zrotate', up);
minuteHandMatrices{2,6} = makehgtform('zrotate', down);

% 2 Matrices - Done
hourHandMatrices{3,1} = makehgtform('zrotate', right);
hourHandMatrices{3,2} = makehgtform('zrotate', right);
hourHandMatrices{3,3} = makehgtform('zrotate', right);
hourHandMatrices{3,4} = makehgtform('zrotate', left);
hourHandMatrices{3,5} = makehgtform('zrotate', left);
hourHandMatrices{3,6} = makehgtform('zrotate', left);

minuteHandMatrices{3,1} = makehgtform('zrotate', up);
minuteHandMatrices{3,2} = makehgtform('zrotate', down);
minuteHandMatrices{3,3} = makehgtform('zrotate', right);
minuteHandMatrices{3,4} = makehgtform('zrotate', left);
minuteHandMatrices{3,5} = makehgtform('zrotate', up);
minuteHandMatrices{3,6} = makehgtform('zrotate', down);

% 3 Matrices
hourHandMatrices{4,1} = makehgtform('zrotate', right);
hourHandMatrices{4,2} = makehgtform('zrotate', right);
hourHandMatrices{4,3} = makehgtform('zrotate', right);
hourHandMatrices{4,4} = makehgtform('zrotate', left);
hourHandMatrices{4,5} = makehgtform('zrotate', up);
hourHandMatrices{4,6} = makehgtform('zrotate', left);

minuteHandMatrices{4,1} = makehgtform('zrotate', right);
minuteHandMatrices{4,2} = makehgtform('zrotate', right);
minuteHandMatrices{4,3} = makehgtform('zrotate', right);
minuteHandMatrices{4,4} = makehgtform('zrotate', up);
minuteHandMatrices{4,5} = makehgtform('zrotate', down);
minuteHandMatrices{4,6} = makehgtform('zrotate', down);

% 4 Matrices
hourHandMatrices{5,1} = makehgtform('zrotate', left);
hourHandMatrices{5,2} = makehgtform('zrotate', right);
hourHandMatrices{5,3} = makehgtform('zrotate', down);
hourHandMatrices{5,4} = makehgtform('zrotate', up);
hourHandMatrices{5,5} = makehgtform('zrotate', down);
hourHandMatrices{5,6} = makehgtform('zrotate', down);

minuteHandMatrices{5,1} = makehgtform('zrotate', down);
minuteHandMatrices{5,2} = makehgtform('zrotate', up);
minuteHandMatrices{5,3} = makehgtform('zrotate', down);
minuteHandMatrices{5,4} = makehgtform('zrotate', up);
minuteHandMatrices{5,5} = makehgtform('zrotate', up);
minuteHandMatrices{5,6} = makehgtform('zrotate', down);

% 5 Matrices
hourHandMatrices{6,1} = makehgtform('zrotate', right);
hourHandMatrices{6,2} = makehgtform('zrotate', right);
hourHandMatrices{6,3} = makehgtform('zrotate', right);
hourHandMatrices{6,4} = makehgtform('zrotate', left);
hourHandMatrices{6,5} = makehgtform('zrotate', left);
hourHandMatrices{6,6} = makehgtform('zrotate', left);

minuteHandMatrices{6,1} = makehgtform('zrotate', right);
minuteHandMatrices{6,2} = makehgtform('zrotate', up);
minuteHandMatrices{6,3} = makehgtform('zrotate', down);
minuteHandMatrices{6,4} = makehgtform('zrotate', up);
minuteHandMatrices{6,5} = makehgtform('zrotate', down);
minuteHandMatrices{6,6} = makehgtform('zrotate', left);

% 6 Matrices
hourHandMatrices{7,1} = makehgtform('zrotate', right);
hourHandMatrices{7,2} = makehgtform('zrotate', down);
hourHandMatrices{7,3} = makehgtform('zrotate', right);
hourHandMatrices{7,4} = makehgtform('zrotate', left);
hourHandMatrices{7,5} = makehgtform('zrotate', left);
hourHandMatrices{7,6} = makehgtform('zrotate', left);

minuteHandMatrices{7,1} = makehgtform('zrotate', up);
minuteHandMatrices{7,2} = makehgtform('zrotate', up);
minuteHandMatrices{7,3} = makehgtform('zrotate', down);
minuteHandMatrices{7,4} = makehgtform('zrotate', up);
minuteHandMatrices{7,5} = makehgtform('zrotate', down);
minuteHandMatrices{7,6} = makehgtform('zrotate', left);

% 7 Matrices - Done
hourHandMatrices{8,1} = makehgtform('zrotate', left);
hourHandMatrices{8,2} = makehgtform('zrotate', left);
hourHandMatrices{8,3} = makehgtform('zrotate', right);
hourHandMatrices{8,4} = makehgtform('zrotate', up);
hourHandMatrices{8,5} = makehgtform('zrotate', up);
hourHandMatrices{8,6} = makehgtform('zrotate', left);

minuteHandMatrices{8,1} = makehgtform('zrotate', down);
minuteHandMatrices{8,2} = makehgtform('zrotate', left);
minuteHandMatrices{8,3} = makehgtform('zrotate', right);
minuteHandMatrices{8,4} = makehgtform('zrotate', up);
minuteHandMatrices{8,5} = makehgtform('zrotate', down);
minuteHandMatrices{8,6} = makehgtform('zrotate', down);

% 8 Matrices
hourHandMatrices{9,1} = makehgtform('zrotate', right);
hourHandMatrices{9,2} = makehgtform('zrotate', right);
hourHandMatrices{9,3} = makehgtform('zrotate', right);
hourHandMatrices{9,4} = makehgtform('zrotate', left);
hourHandMatrices{9,5} = makehgtform('zrotate', left);
hourHandMatrices{9,6} = makehgtform('zrotate', left);

minuteHandMatrices{9,1} = makehgtform('zrotate', up);
minuteHandMatrices{9,2} = makehgtform('zrotate', up);
minuteHandMatrices{9,3} = makehgtform('zrotate', down);
minuteHandMatrices{9,4} = makehgtform('zrotate', up);
minuteHandMatrices{9,5} = makehgtform('zrotate', down);
minuteHandMatrices{9,6} = makehgtform('zrotate', down);

% 9 Matrices
hourHandMatrices{10,1} = makehgtform('zrotate', left);
hourHandMatrices{10,2} = makehgtform('zrotate', right);
hourHandMatrices{10,3} = makehgtform('zrotate', right);
hourHandMatrices{10,4} = makehgtform('zrotate', up);
hourHandMatrices{10,5} = makehgtform('zrotate', up);
hourHandMatrices{10,6} = makehgtform('zrotate', left);

minuteHandMatrices{10,1} = makehgtform('zrotate', down);
minuteHandMatrices{10,2} = makehgtform('zrotate', up);
minuteHandMatrices{10,3} = makehgtform('zrotate', down);
minuteHandMatrices{10,4} = makehgtform('zrotate', up);
minuteHandMatrices{10,5} = makehgtform('zrotate', down);
minuteHandMatrices{10,6} = makehgtform('zrotate', down);