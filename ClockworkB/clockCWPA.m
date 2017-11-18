% Clock - Computer Graphics Coursework: Part 1
% Joshua Stringfellow, K1460846

% This is the old original clock for Part 1, for Part 2 see main.m and
% singleClock.m

figClock = figure; % Grab figure handle to allow animation to be cancelled
axis equal

hourHand = [0 0; 0 5]; % Hour hand coordinates
minuteHand = [0 0; 0 10]; % Minute hand coordinates
secondHand = [0 -5; 0 10]; % Second hand coordinates
degree = pi/180; % Simplify rotation maths

circleCo = circleJDS(0, 0, 11, 100); % Create outer bezel circle
line(circleCo(1,:), circleCo(2,:), 'Color', 'red', 'LineWidth', 2)

% Number each hour on clock
rads = deg2rad(-60); % Get value necessary to rotate 60 degrees anticlockwise
numbers = circleJDS(0, 0, 9, 12)' * [cos(rads) -sin(rads); sin(rads) cos(rads)];
hold on
labelJDS(numbers') % Plot numbers

% Mark the minutes/seconds
marks = circleJDS(0, 0, 10, 60);
for i = 1:(length(marks(1,:)) -1)
    hold on
    plot(marks(1,i),marks(2,i), '.') % Plot minute/second marks
    if(mod(i,6) == 4)
        hold on
        plot(marks(1,i),marks(2,i), 's') % Plot hour marks with a square
    end
end

% Animation loop
while ishghandle(figClock) % Allows animation to be stopped more easily by exiting figure 
   time = clock; % Get time and calculate degree offsets for hours, minutes and seconds
   hour = degree * time(4) * 30;
   min = degree * time(5) * 6;
   sec = degree * time(6) * 6;
   
   % Calculate rotations based on degree offsets
   hourRotation = hourHand * [cos(hour) -sin(hour); sin(hour) cos(hour)];
   minRotation = minuteHand * [cos(min) -sin(min); sin(min) cos(min)];
   secRotation = secondHand * [cos(sec) -sin(sec); sin(sec) cos(sec)];
   
   % Plot second, minute, and hour hands
   hold on
   h1 = line(secRotation(:,1), secRotation(:,2), 'Color', 'red', 'LineWidth', 1);
   hold on
   h2 = line(minRotation(:,1), minRotation(:,2), 'Color', 'black', 'LineWidth', 2);
   hold on
   h3 = line(hourRotation(:,1), hourRotation(:,2), 'Color', 'black', 'LineWidth', 3);
   
   drawnow % Force a draw instead of waiting for the script to complete
   
   % Remove hands from plot
   delete(h1)
   delete(h2)
   delete(h3)
end

hold on