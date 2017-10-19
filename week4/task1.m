% Week 4: Task 1 - Reflect line (-1, 1),(2,-1) around axis y=2

% Create matrix of line end coordinates
pointABT = [-1,1;2,-1];
pointABT(:,3)=1; % Add a 3rd column containing 1 for translation compatibility

% Create transform matrices
translateDown = [1 0 0; 0 1 0; 0 -2 1];
reflectMatrix = [1 0 0; 0 -1 0; 0 0 1]; % 3rd column and row added to make homogenous
translateUp = [1 0 0; 0 1 0; 0 2 1];

plot(pointABT(:,1),pointABT(:,2),'r');

pointABT = pointABT * translateDown * reflectMatrix * translateUp;

hold on
plot(pointABT(:,1), pointABT(:,2)) % could also use line function

axis([-8 8 -8 8])