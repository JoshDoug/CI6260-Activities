% Week 3 Workshop Activity

% Using DDA
figure(1)
DDA(5, 3, 17, 7) % Plot line with slope between -1 and 1
DDA(5, 3, 7, 17) % Plot line with slope greater than 1
axis([0 20 0 20])

% Using Bresenham
figure(2)
Bresenham(5, 3, 17, 7) % Plot line with slope between -1 and 1
Bresenham(5, 3, 7, 17) % Plot line with slope greater than 1
axis([0 20 0 20])
