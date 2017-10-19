% Task 5 - Rotating Pentagram

% pentagram = polygram(5, 5, 2, 5);
pentagram = polygram(0, 0, 2, 5);
rotationMatrix = [cos(pi/180), -sin(pi/180); sin(pi/180), cos(pi/180)];
h = fill(pentagram(1,:), pentagram(2,:), 'r');
rotatedPentagram = pentagram' * rotationMatrix;

%hold on
%fill(rotatedPentagram(:,1), rotatedPentagram(:,2), 'r');

for i=1:360
   disp(i);
   pentagram = pentagram' * rotationMatrix;
   pentagram = pentagram';
   h = fill(pentagram(1,:), pentagram(2,:), 'r');
   axis([-3 3 -3 3])
   drawnow
   %delete(h);
end

title('Pentagram');