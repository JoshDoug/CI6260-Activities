% Task 4 - Cube -> Unit Cube

% Holds X, Y, and Z coordinates for cube and an additional column to make
% homeogenous
cubeMatrix = [0 0 0 1; 2 0 0 1; 2 2 0 1; 0 2 0 1; 0 0 2 1; 2 0 2 1; 2 2 2 1; 0 2 2 1];

% Holds coressponding vertice rows for each face
face = [1 2 3 4; 1 2 6 5; 2 3 7 6; 3 7 8 4; 1 4 8 5; 5 6 7 8];

for i=1:6
    xCoords = cubeMatrix([face(i,:) face(i,1)], 1); % Get X Coordinates for face i
    yCoords = cubeMatrix([face(i,:) face(i,1)], 2); % Get Y Coordinates for face i
    zCoords = cubeMatrix([face(i,:) face(i,1)], 3); % Get Z Coordinates for face i
    hold on
    line(xCoords, yCoords, zCoords); % Draw Cube
end



%line(cubeTest(:,1), cubeTest(:,2), cubeTest(:,3))
view(-45, 45)