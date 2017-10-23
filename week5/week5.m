% Week 5 Workshop

% Shape Vertices
Vertices  = [0 0 0; 4.25 0 0; 4.25 0 0.7; 3.1 0 1; 2.2 0 1.5; 0.5 0 1.5; 0 0 1;
    0 1.7 0; 4.25 1.7 0; 4.25 1.7 0.7; 3.1 1.7 1; 2.2 1.7 1.5; 0.5 1.7 1.5; 0 1.7 1];

% Homogenous version of Vertice Matrix
homVertices = Vertices;
homVertices(:,4) = 1;

% Shape Faces in a Cell Array
Patch{1}   = [1 2 3 4 5 6 7];
Patch{2} = [8 9 10 11 12 13 14];
Patch{3} = [2 9 10 3 NaN NaN NaN];
Patch{4} = [3 10 11 4 NaN NaN NaN];
Patch{5} = [4 11 12 5 NaN NaN NaN];
Patch{6} = [5 12 13 6 NaN NaN NaN];
Patch{7} = [6 13 14 7 NaN NaN NaN];
Patch{8} = [7 14 8 1 NaN NaN NaN];
Patch{9} = [1 8 9 2 NaN NaN NaN];

% Alternative format for Shape Faces in a Matrix
PatchMatrix = [1 2 3 4 5 6 7; 8 9 10 11 12 13 14; 2 9 10 3 NaN NaN NaN; 3 10 11 4 NaN NaN NaN;
    4 11 12 5 NaN NaN NaN; 5 12 13 6 NaN NaN NaN; 6 13 14 7 NaN NaN NaN; 7 14 8 1 NaN NaN NaN; 1 8 9 2 NaN NaN NaN];

% Matrix of Lines referencing Vertices Matrix
LineIndex= [1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 7 1; 2 9; 9 10; 10 11; 11 12;12 13;
    13 14; 14 8; 8 9; 3 10; 4 11; 5 12; 6 13; 7 14; 1 8];

% Task 
figure(1)
for i=1:21
    xCoords = Vertices(LineIndex(i,:), 1); % Get X Coordinates for line i
    yCoords = Vertices(LineIndex(i,:), 2); % Get Y Coordinates for line i
    zCoords = Vertices(LineIndex(i,:), 3); % Get Z Coordinates for line i
    hold on
    line(xCoords, yCoords, zCoords); % Draw Cube
end

axis([-0.5 5 -0.5 2 -0.5 2])
view(34, 28)

% Task 2
figure(2)

% specifying columns 1:3 isn't really necessary here, could just use :
patch('Vertices', Vertices(:,1:3), 'Faces', PatchMatrix, 'FaceColor', 'g');

axis([-0.5 5 -0.5 2 -0.5 2])
view(-45, 45)

% Task 3
figure(3)

T1 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 10 5 20 1];
TShape = homVertices * T1;

for i=1:21
    xCoords = Vertices(LineIndex(i,:), 1); % Get X Coordinates for line i
    yCoords = Vertices(LineIndex(i,:), 2); % Get Y Coordinates for line i
    zCoords = Vertices(LineIndex(i,:), 3); % Get Z Coordinates for line i
    hold on
    line(xCoords, yCoords, zCoords); % Draw Cube
end

for i=1:21
    xCoords = TShape(LineIndex(i,:), 1); % Get X Coordinates for line i
    yCoords = TShape(LineIndex(i,:), 2); % Get Y Coordinates for line i
    zCoords = TShape(LineIndex(i,:), 3); % Get Z Coordinates for line i
    hold on
    line(xCoords, yCoords, zCoords); % Draw Cube
end

axis([-0.5 15 -0.5 10 -0.5 25])
view(34, 28)

% Task 4
figure(4)

O1 = [1 0 0 0; 0 1 0 0; 0 0 0 1];
OShape = Vertices * O1;

for i=1:21
    xCoords = OShape(LineIndex(i,:), 1); % Get X Coordinates for line i
    yCoords = OShape(LineIndex(i,:), 2); % Get Y Coordinates for line i
    zCoords = OShape(LineIndex(i,:), 3); % Get Z Coordinates for line i
    hold on
    line(xCoords, yCoords, zCoords); % Draw Cube
end

axis([-0.5 5 -0.5 2 -0.5 2])
view(45, 45)

% Task 5
figure(5)

T2 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 5 1]; % Translate by 5 in Z
P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 1/5 0]; % Perspective Projection Matrix
% Need to bring final value back  to 1

PShape = homVertices * T2;

for i=1:14
    PShape(i,:) = P1 * PShape(i,:)';
    PShape(i,:) = PShape(i,:) * (1/PShape(i,4));
end

%PShape(:,4) = 1;
%PShape = P1' * PShape';
%PShape = PShape';

for i=1:21
    xCoords = PShape(LineIndex(i,:), 1); % Get X Coordinates for line i
    yCoords = PShape(LineIndex(i,:), 2); % Get Y Coordinates for line i
    zCoords = PShape(LineIndex(i,:), 3); % Get Z Coordinates for line i
    hold on
    line(xCoords, yCoords, zCoords); % Draw Cube
end

axis([-0.5 5 0 5 0 10])
view(34, 28)
