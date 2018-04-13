% Joshua Stringfellow, K1460846
% Lab 12, Week 22

% Task 1
% - Nearest Neighbour
% - Nearest Mean
% - Decision Tree Classifier

X=[ 1, 21.7, 4.1;
    1, 23.1, 4.0;
    1, 21.4, 3.8;
    2, 11.7, 2.7;
    3, 17.2, 4.3;
    1, 21.9, 3.4;
    1, 18.9, 3.8;
    3, 15.5, 4.4;
    2, 12.2, 3.1;
    1, 23.7, 4.4;
    1, 22.1, 4.7;
    3, 15.5, 4.5;
    2,  9.7, 3.3;
    2, 11.3, 2.8;
    3, 16.3, 4.5;
    3, 16.3, 4.7;
    2,  9.9, 3.3;
    2, 11.7, 3.6;
    1, 21.8, 4.0;
    3, 16.2, 4.6];

Y = [17.0, 3.9];

% Extract each class to ease plotting
classOne = X(X(:,1) == 1, 2:3);
classTwo = X(X(:,1) == 2, 2:3);
classThree = X(X(:,1) == 3, 2:3);

figure(1)
scatter(classOne(:,1), classOne(:,2), '+');
hold on
scatter(classTwo(:,1), classTwo(:,2), '*');
scatter(classThree(:,1), classThree(:,2), 'o');
scatter(Y(1), Y(2), 'x');

% Find Nearest Neighbour
for i=1:length(X)
    Dtemp = sqrt((X(i,2) - Y(1))^2 + (X(i,3) - Y(2))^2);
    if ~exist('D', 'var')
        D = Dtemp;
        Dn = X(i,1);
    elseif Dtemp < D
        D = Dtemp;
        Dn = X(i,1);
    end
end

fprintf('%d is the class using Nearest Neighbour\n', Dn); % Class of the nearest neighbour (3)

clear D;

% Classify Y using Nearest Mean classifier

rng(1); % rng seems to make the kmeans result consistent and the result aligns with the actual classes
[cidx, ctrs] = kmeans(X(:,2:3), 3);
for i=1:length(ctrs)
    Dtemp = sqrt((ctrs(i,1) - Y(1))^2 + (ctrs(i,2) - Y(2))^2);
    if ~exist('D', 'var')
        D = Dtemp;
        Dn = i;
    elseif Dtemp < D
        D = Dtemp;
        Dn = i;
    end
end

fprintf('%d is the class using kmean to find Nearest Mean Neighbour\n', Dn);
% Class of Nearest Mean neighbour cluster (the ordering of the classes seems random
% with no obvious mapping between the cidx and ctrs, so Dn will not neccessarily correspond
% to the actual class, it will just match the closest average)
% Although using rng(1) appears to have resolved this (consistently returns 3 for me)

clear D;

% Manual Nearest Mean classifier to get the actual class
means = [mean(classOne(:,1)), mean(classOne(:,2)); mean(classTwo(:,1)), mean(classTwo(:,2)); mean(classThree(:,1)), mean(classThree(:,2))];

for i=1:length(means)
    Dtemp = sqrt((means(i,1) - Y(1))^2 + (means(i,2) - Y(2))^2);
    if ~exist('D', 'var')
        D = Dtemp;
        Dn = i;
    elseif Dtemp < D
        D = Dtemp;
        Dn = i;
    end
end

fprintf('%d is the class manually finding Nearest Mean Neighbour\n', Dn); % Manual result that should match the actual class (3)

% Classify Y using basic Binary Decision tree on X

if Y(1) < 14 % If X < 14 unkown class is 2
    fprintf('%d is the class using a basic Binary Decision tree\n', 2);
elseif Y(1) < 18 % If 14 < X > 18 unknown class is 3
    fprintf('%d is the class using a basic Binary Decision tree\n', 3);
else
    fprintf('%d is the class using a basic Binary Decision tree\n', 1); % If X > 18 unknown class is 1
end

% Task 2 - Optional
img = imread('shapes1.jpg');
img = imresize(img, 0.25); % Resize to same as worshop feature blob

% Detect and segment objects in image

% Measure features or properties of each image

% Build a classifier using one (or more) of the task 1 methods to sort
% objects into different classes based on size, shape, colour
%imshow(img);

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

