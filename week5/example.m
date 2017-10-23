% scale matrix example from workshop task slides
T_41 = [0.5 0 0 0; 0 0.5 0 0; 0 0 0.5 0; 0 0 0 1];

% vertices
P_cube= [0 0 0 1; 2 0 0 1; 2 2 0 1; 0 2 0 1; 0 0 2 1; 2 0 2 1; 2 2 2 1; 0 2 2 1];

% faces
cface = [1,2,3,4; 5,6,7,8; 1,2,6,5; 4,3,7,8; 2,3,7,6; 1,4,8,5];

% compute transformed vertices
T_cube= P_cube*T_41;figure; hold on;
p1=patch('Vertices', P_cube(:,1:3), 'Faces', cface, 'FaceColor', 'g');
p2=patch('Vertices', T_cube(:,1:3), 'Faces', cface, 'FaceColor', 'r');

% set up the viewangle
view(34, 28);