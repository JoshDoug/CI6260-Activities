% Week 4: Task 3 - Malformed Circle

T2 = [1.5 0; 0 0.75];

circle = circleJDS(0, 0, 2, 50);

line(circle(1,:), circle(2,:)); % Plot original circle

circle = T2 * circle;

line(circle(1,:), circle(2,:)); % Plot transformed circle

axis([-10 10 -10 10])
