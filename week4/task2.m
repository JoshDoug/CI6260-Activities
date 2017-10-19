% Week 4: Task 2 - Rotate Rectangle 30 degrees clockwise

rect = [1,1; 2,1; 2,3; 1,3]; % Rectangle plot points
rect(end+1,:) = rect(1,:); % Repeat first coordinates at end to complete rectangle

line(rect(:,1), rect(:,2)) % Draw initial rectangle
rect(:,3) = 1; % Make homogenous ... just add a column of 1?
% How do you know what numbers to add to make homogenous?

trans1 = [1 0 0; 0 1 0; -3 -2 1]; % Transition from rotation point to origin
rotationMatrix = [cos(pi/6), -sin(pi/6), 0; sin(pi/6), cos(pi/6), 0; 0, 0, 1]; % Homogenous rotation matrix
trans2 = [1 0 0; 0 1 0; 3 2 1]; % Transition origin to rotation point

rotatedRect = rect * trans1 * rotationMatrix * trans2; % Apply the transforms

hold on
line(rotatedRect(:,1), rotatedRect(:,2)) % Draw rotated rectangle
axis([0 5 0 5])