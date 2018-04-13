% Temp Task 2 & 3

% Task 2 - Optional
img = imread('shapes1.jpg');
img = imresize(img, 0.25); % Resize to same as worshop feature blob

% Detect and segment objects in image

% Measure features or properties of each image

% Build a classifier using one (or more) of the task 1 methods to sort
% objects into different classes based on size, shape, colour


imshow(img);

% Task 3
load('shapes1features.mat'); % Load feature data

% Run kmeans on colour features (14:19) to classify into colour classes
[cidxCol, ctrsCol] = kmeans(features(14:19)', 6);

% Run kmeans on shape features (1:11) to classify into the different shapes
% and size classes
[cidxS, ctrsS] = kmeans(features(1:11)', 11);

% bwselect function requires coordinates to work - so 
% bwselect(BW, features(1,:), length(features(1,:)); % hmm this takes
% coordinates...


% Activity 5 of Task 3 - requires Task 2 which is optional?
