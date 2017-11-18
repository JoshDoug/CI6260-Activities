% Clock Coursework Part B
% Joshua Stringfellow - K1460846

% Inspiration - http://www.humanssince1982.com/the-clock-clock-white
% Using a set of analog clocks, displays a digital time

% This is the main submission, but I've included a single 3D analog clock
% (singleClock.m) with a second hand and the Part A submission
% (clockCWPA.m & labelJDS.m).

% Note: The initial startup time can take a few seconds.

clear;

figClock = figure; % Grab figure handle to allow animation to be cancelled
axis([-10 240 -10 50 -4 7])
lighting phong
shading interp

% Create transforms to move clocks into position
Tmatrix = zeros(4, 4, 36);
Hbody = zeros(1, 36); % Handle for clock bodies
Ttransform = zeros(1, 36); % Preallocate vector
Ttransform(1) = hgtransform;

% Create transforms to move to each of the 36 analog clocks that make up the
% digital clock
for i=0:11
    tx = i * 20;
    inc = (i * 3) + 1;
    Tmatrix(:,:, inc) = makehgtform('translate', [tx 0 0]);
    Tmatrix(:,:, inc + 1) = makehgtform('translate', [tx 20 0]);
    Tmatrix(:,:, inc + 2) = makehgtform('translate', [tx 40 0]);
end

% Create base/body of clock
[x, y, z] = filledCylinderAlt(10, 50, [0 1]);
h(1) = surface(x, y, z, 'Parent', Ttransform(1), 'FaceColor', 'white', 'LineStyle', 'none');

% Create clock bezel
[x, y, z] = hollowCylinder(10, 9, 50, [1 1.1]);
h(2) = surface(x, y, z, 'Parent', Ttransform(1), 'FaceColor', 'black', 'LineStyle', 'none');

% Draw each clock base (body and bezel)
for i=2:36
    Ttransform(i) = hgtransform;
    temp = copyobj(h, Ttransform(i));
    set(Ttransform(i), 'Matrix', Tmatrix(:,:,i));
end

% Setup Hour Markers
[cx, cy, cz] = cuboid(0.5, 1, 0.1);
cz = cz + 1;

% Preallocate arrays
tm = zeros(1, 12*36);
markerHandle = zeros(1, 12*24);

% Create initial transform object and handle
tm(1) = hgtransform;
markerHandle(1) = surface(cx, cy, cz, 'Parent', tm(1), 'FaceColor', 'black', 'LineStyle', 'none');
% Create translation to move marker to bezel
trm = makehgtform('translate', [0 8 0]);
% Initialise initial transform object
set(tm(1), 'Matrix', trm);

% Setup each marker on each analog clock
% This could probably be made faster - significantly impacts initial startup time
inc = 0;
for i=1:36
    for j=1:12
        inc = inc + 1;
        tm(inc) = hgtransform;
        markerHandle(inc) = copyobj(markerHandle(1), tm(inc));
        TRz = makehgtform('zrotate', pi/6 * (j -1));
        set(tm(inc), 'Matrix', Tmatrix(:,:,i) * TRz * trm);
    end
end

% Clock Hands - only Hour and Minute for this necessary
[minuteHandMatrices, hourHandMatrices] = handmatrices; % Get matrices for clock hand positioning

% Might be a better super matrix style of storage for these, but this is
% quicker:

% Hour First Digit
% Hour Second Digit
hour1stDigitMinuteHand = zeros(1, 6); % Preallocate Transform Objects
hour1stDigitHourHand = zeros(1, 6);
hour2ndDigitMinuteHand = zeros(1, 6);
hour2ndDigitHourHand = zeros(1, 6);

hour1stDigitMinuteHandle = zeros(1, 6); % Preallocate Handles
hour1stDigitHourHandle = zeros(1, 6);
hour2ndDigitMinuteHandle = zeros(1, 6);
hour2ndDigitHourHandle = zeros(1, 6);

% Minute First Digit
% Minute Second Digit
minute1stDigitMinuteHand = zeros(1, 6); % Preallocate Transform Objects
minute1stDigitHourHand = zeros(1, 6);
minute2ndDigitMinuteHand = zeros(1, 6);
minute2ndDigitHourHand = zeros(1, 6);

minute1stDigitMinuteHandle = zeros(1, 6); % Preallocate Handles
minute1stDigitHourHandle = zeros(1, 6);
minute2ndDigitMinuteHandle = zeros(1, 6);
minute2ndDigitHourHandle = zeros(1, 6);

% Second First Digit
% Second Second Digit
second1stDigitMinuteHand = zeros(1, 6); % Preallocate Transform Objects
second1stDigitHourHand = zeros(1, 6);
second2ndDigitMinuteHand = zeros(1, 6);
second2ndDigitHourHand = zeros(1, 6);

second1stDigitMinuteHandle = zeros(1, 6); % Preallocate Handles
second1stDigitHourHandle = zeros(1, 6);
second2ndDigitMinuteHandle = zeros(1, 6);
second2ndDigitHourHandle = zeros(1, 6);

% Base clock hand that will be copied
mhtransform = hgtransform;
[mhx, mhy, mhz] = cuboid(1, 8, 0.1); % Minute hand
hhtransform = hgtransform;
[hhx, hhy, hhz] = cuboid(1, 6, 0.1); % Hour Hand
mh = surface(mhx, mhy, mhz, 'Parent', mhtransform, 'FaceColor', 'black', 'LineStyle', 'none');
hh = surface(hhx, hhy, hhz, 'Parent', hhtransform, 'FaceColor', 'black', 'LineStyle', 'none');

ttch = makehgtform('translate', [0 -0.5 1]); % Transform to center the hands

% Setup initial clock handles and transform objects
for i=1:6
    hour1stDigitMinuteHand(i) = hgtransform;
    hour1stDigitHourHand(i) = hgtransform;
    hour2ndDigitMinuteHand(i) = hgtransform;
    hour2ndDigitHourHand(i) = hgtransform;
    hour1stDigitMinuteHandle(i) = copyobj(mh, hour1stDigitMinuteHand(i));
    hour1stDigitHourHandle(i) = copyobj(hh, hour1stDigitHourHand(i));
    hour2ndDigitMinuteHandle(i) = copyobj(mh, hour2ndDigitMinuteHand(i));
    hour2ndDigitHourHandle(i) = copyobj(hh, hour2ndDigitHourHand(i));
    
    minute1stDigitMinuteHand(i) = hgtransform;
    minute1stDigitHourHand(i) = hgtransform;
    minute2ndDigitMinuteHand(i) = hgtransform;
    minute2ndDigitHourHand(i) = hgtransform;
    minute1stDigitMinuteHandle(i) = copyobj(mh, minute1stDigitMinuteHand(i));
    minute1stDigitHourHandle(i) = copyobj(hh, minute1stDigitHourHand(i));
    minute2ndDigitMinuteHandle(i) = copyobj(mh, minute2ndDigitMinuteHand(i));
    minute2ndDigitHourHandle(i) = copyobj(hh, minute2ndDigitHourHand(i));
    
    second1stDigitMinuteHand(i) = hgtransform;
    second1stDigitHourHand(i) = hgtransform;
    second2ndDigitMinuteHand(i) = hgtransform;
    second2ndDigitHourHand(i) = hgtransform;
    second1stDigitMinuteHandle(i) = copyobj(mh, second1stDigitMinuteHand(i));
    second1stDigitHourHandle(i) = copyobj(hh, second1stDigitHourHand(i));
    second2ndDigitMinuteHandle(i) = copyobj(mh, second2ndDigitMinuteHand(i));
    second2ndDigitHourHandle(i) = copyobj(hh, second2ndDigitHourHand(i));
end

% Setup done, now animate:

hourdigit(1) = 0;
hourdigit(2) = 0;
minutedigit(1) = 0;
minutedigit(2) = 0;
seconddigit(1) = 0;
seconddigit(2) = 0;

cachehourdigit(1) = 1;
cachehourdigit(2) = 1;
cacheminutedigit(1) = 1;
cacheminutedigit(2) = 1;
cacheseconddigit(1) = 1;
cacheseconddigit(2) = 1;

figClock.Color = 'black';
axis off

while ishghandle(figClock) % Allows animation to be stopped more easily by exiting figure
    time = clock; % Get time
    hour = time(4);
    min = time(5);
    sec = time(6);
    
    if numel(num2str(hour)) == 1
        hourdigit(1) = 1;
        hourdigit(2) = hour + 1;
    else
        hourStr = num2str(hour);
        hourdigit(1) = str2num(hourStr(1)) + 1;
        hourdigit(2) = str2num(hourStr(2)) + 1;
    end
    
    if numel(num2str(min)) == 1
        minutedigit(1) = 1;
        minutedigit(2) = min + 1;
    else
        minStr = num2str(min);
        minutedigit(1) = str2num(minStr(1)) + 1;
        minutedigit(2) = str2num(minStr(2)) + 1;
    end
    
    secString = num2str(sec);
    if secString(2) == '.'
        seconddigit(1) = 1;
        seconddigit(2) = str2num(secString(1)) + 1;
    else
        minStr = num2str(min);
        seconddigit(1) = str2num(secString(1)) + 1;
        seconddigit(2) = str2num(secString(2)) + 1;
    end
    
    % Optimise by testing for digits changing - ensure digits that haven't
    % changed don't get redrawn pointlessly
    
    if cachehourdigit(1) ~= hourdigit(1)
        % Draw first hour digit
        for i=1:6
            set(hour1stDigitMinuteHand(i), 'Matrix', Tmatrix(:,:,i) * minuteHandMatrices{hourdigit(1),i} * ttch);
            set(hour1stDigitHourHand(i), 'Matrix', Tmatrix(:,:,i) * hourHandMatrices{hourdigit(1),i} * ttch);
            drawnow
        end
    end
    
    if cachehourdigit(2) ~= hourdigit(2)
        % Draw second hour digit
        for i=1:6
            set(hour2ndDigitMinuteHand(i), 'Matrix', Tmatrix(:,:,i+6) * minuteHandMatrices{hourdigit(2),i} * ttch);
            set(hour2ndDigitHourHand(i), 'Matrix', Tmatrix(:,:,i+6) * hourHandMatrices{hourdigit(2),i} * ttch);
            drawnow
        end
    end
    
    if cacheminutedigit(1) ~= minutedigit(1)
        % Draw first minute digit
        for i=1:6
            set(minute1stDigitMinuteHand(i), 'Matrix', Tmatrix(:,:,i+12) * minuteHandMatrices{minutedigit(1),i} * ttch);
            set(minute1stDigitHourHand(i), 'Matrix', Tmatrix(:,:,i+12) * hourHandMatrices{minutedigit(1),i} * ttch);
            drawnow
        end
    end
    
    if cacheminutedigit(2) ~= minutedigit(2)
        % Draw second minute digit
        for i=1:6
            set(minute2ndDigitMinuteHand(i), 'Matrix', Tmatrix(:,:,i+18) * minuteHandMatrices{minutedigit(2),i} * ttch);
            set(minute2ndDigitHourHand(i), 'Matrix', Tmatrix(:,:,i+18) * hourHandMatrices{minutedigit(2),i} * ttch);
            drawnow
        end
    end
    
    if cacheseconddigit(1) ~= seconddigit(1)
        % Draw first second digit
        for i=1:6
            set(second1stDigitMinuteHand(i), 'Matrix', Tmatrix(:,:,i+24) * minuteHandMatrices{seconddigit(1),i} * ttch);
            set(second1stDigitHourHand(i), 'Matrix', Tmatrix(:,:,i+24) * hourHandMatrices{seconddigit(1),i} * ttch);
            drawnow
        end
    end
    
    if cacheseconddigit(2) ~= seconddigit(2)
        % Draw second second digit
        for i=1:6
            set(second2ndDigitMinuteHand(i), 'Matrix', Tmatrix(:,:,i+30) * minuteHandMatrices{seconddigit(2),i} * ttch);
            set(second2ndDigitHourHand(i), 'Matrix', Tmatrix(:,:,i+30) * hourHandMatrices{seconddigit(2),i} * ttch);
            drawnow
        end
    end
    
    % Cache digits to avoid unneccessary redraws
    cachehourdigit(1) = hourdigit(1);
    cachehourdigit(2) = hourdigit(2);
    cacheminutedigit(1) = minutedigit(1);
    cacheminutedigit(2) = minutedigit(2);
    cacheseconddigit(1) = seconddigit(1);
    cacheseconddigit(2) = seconddigit(2);

    % Short pause as this isn't animating seconds
    pause(0.1)
end

