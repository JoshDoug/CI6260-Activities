% Week 4: Task 3 - Malformed Circle

% Dunno what to do here.

T2 = [1.5 0 0; 0 0.75 0; 0 0 1];

circle = circleJDS(3, 3, 2, 5);

line(circle(1,:), circle(2,:)); % Plot original circle

%circle = circle * T2

axis([-10 10 -10 10])