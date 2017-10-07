figure(1)
axis([0 18 0 18]) % Set axis

% Draw house perimiter
rectangleJDS(1, 1, 11, 11)

% Draw windows
drawWindowFrames(2, 2, 3, 3)
drawWindowFrames(2, 8, 3, 3)
drawWindowFrames(8, 2, 3, 3)
drawWindowFrames(8, 8, 3, 3)

% Draw door
rectangleJDS(5.5, 1, 2, 6)

% Handle using rectangle function to draw a circle
rectangle('Position',[7 4 0.3 0.3],'Curvature',[1 1])

% Draw roof
line([0.5 6.5 12.5 0.5], [12 16 12 12])

title('House')