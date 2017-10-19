% Week 4

% Task 1 - reflect by axis y=2
translateDown = [1 0 0; 0 1 0; 0 -2 1];
reflectMatrix = [1 0 0; 0 -1 0; 0 0 1];
translateUp = [1 0 0; 0 1 0; 0 2 1];

pointABT = [-1,1;2,-1];
pointABT(:,3)=1;

plot(pointABT(:,1),pointABT(:,2),'r');

pointABT = pointABT * translateDown * reflectMatrix * translateUp;

hold on
plot(pointABT(:,1), pointABT(:,2)) % could also use line function

axis([-8 8 -8 8])
