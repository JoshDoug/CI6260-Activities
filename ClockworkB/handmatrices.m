function [ hourHandMatrices, minuteHandMatrices ] = handmatrices( )
%HANDMATRICES Returns set of transforms for digits 0-9
%   Matrices to convert 6 analog clock hands to a digital number
%   Returns matrice of matrices for hour hand and minute hand

% Clock Hand Matrices
up = 0;
left = pi/2;
right = -pi/2;
down = pi;

% 0 Matrices - Done
hourHandMatrices{1,1} = makehgtform('zrotate', right);
hourHandMatrices{1,2} = makehgtform('zrotate', down);
hourHandMatrices{1,3} = makehgtform('zrotate', right);
hourHandMatrices{1,4} = makehgtform('zrotate', left);
hourHandMatrices{1,5} = makehgtform('zrotate', down);
hourHandMatrices{1,6} = makehgtform('zrotate', left);

minuteHandMatrices{1,1} = makehgtform('zrotate', up);
minuteHandMatrices{1,2} = makehgtform('zrotate', up);
minuteHandMatrices{1,3} = makehgtform('zrotate', down);
minuteHandMatrices{1,4} = makehgtform('zrotate', up);
minuteHandMatrices{1,5} = makehgtform('zrotate', up);
minuteHandMatrices{1,6} = makehgtform('zrotate', down);

% 1 Matrices - Done
hourHandMatrices{2,1} = makehgtform('zrotate', left);
hourHandMatrices{2,2} = makehgtform('zrotate', left);
hourHandMatrices{2,3} = makehgtform('zrotate', left);
hourHandMatrices{2,4} = makehgtform('zrotate', up);
hourHandMatrices{2,5} = makehgtform('zrotate', down);
hourHandMatrices{2,6} = makehgtform('zrotate', down);

minuteHandMatrices{2,1} = makehgtform('zrotate', down);
minuteHandMatrices{2,2} = makehgtform('zrotate', left);
minuteHandMatrices{2,3} = makehgtform('zrotate', up);
minuteHandMatrices{2,4} = makehgtform('zrotate', up);
minuteHandMatrices{2,5} = makehgtform('zrotate', up);
minuteHandMatrices{2,6} = makehgtform('zrotate', down);

% 2 Matrices - Done
hourHandMatrices{3,1} = makehgtform('zrotate', right);
hourHandMatrices{3,2} = makehgtform('zrotate', right);
hourHandMatrices{3,3} = makehgtform('zrotate', right);
hourHandMatrices{3,4} = makehgtform('zrotate', left);
hourHandMatrices{3,5} = makehgtform('zrotate', left);
hourHandMatrices{3,6} = makehgtform('zrotate', left);

minuteHandMatrices{3,1} = makehgtform('zrotate', up);
minuteHandMatrices{3,2} = makehgtform('zrotate', down);
minuteHandMatrices{3,3} = makehgtform('zrotate', right);
minuteHandMatrices{3,4} = makehgtform('zrotate', left);
minuteHandMatrices{3,5} = makehgtform('zrotate', up);
minuteHandMatrices{3,6} = makehgtform('zrotate', down);

% 3 Matrices
hourHandMatrices{4,1} = makehgtform('zrotate', right);
hourHandMatrices{4,2} = makehgtform('zrotate', right);
hourHandMatrices{4,3} = makehgtform('zrotate', right);
hourHandMatrices{4,4} = makehgtform('zrotate', left);
hourHandMatrices{4,5} = makehgtform('zrotate', up);
hourHandMatrices{4,6} = makehgtform('zrotate', left);

minuteHandMatrices{4,1} = makehgtform('zrotate', right);
minuteHandMatrices{4,2} = makehgtform('zrotate', right);
minuteHandMatrices{4,3} = makehgtform('zrotate', right);
minuteHandMatrices{4,4} = makehgtform('zrotate', up);
minuteHandMatrices{4,5} = makehgtform('zrotate', down);
minuteHandMatrices{4,6} = makehgtform('zrotate', down);

% 4 Matrices
hourHandMatrices{5,1} = makehgtform('zrotate', left);
hourHandMatrices{5,2} = makehgtform('zrotate', right);
hourHandMatrices{5,3} = makehgtform('zrotate', down);
hourHandMatrices{5,4} = makehgtform('zrotate', up);
hourHandMatrices{5,5} = makehgtform('zrotate', down);
hourHandMatrices{5,6} = makehgtform('zrotate', down);

minuteHandMatrices{5,1} = makehgtform('zrotate', down);
minuteHandMatrices{5,2} = makehgtform('zrotate', up);
minuteHandMatrices{5,3} = makehgtform('zrotate', down);
minuteHandMatrices{5,4} = makehgtform('zrotate', up);
minuteHandMatrices{5,5} = makehgtform('zrotate', up);
minuteHandMatrices{5,6} = makehgtform('zrotate', down);

% 5 Matrices
hourHandMatrices{6,1} = makehgtform('zrotate', right);
hourHandMatrices{6,2} = makehgtform('zrotate', right);
hourHandMatrices{6,3} = makehgtform('zrotate', right);
hourHandMatrices{6,4} = makehgtform('zrotate', left);
hourHandMatrices{6,5} = makehgtform('zrotate', left);
hourHandMatrices{6,6} = makehgtform('zrotate', left);

minuteHandMatrices{6,1} = makehgtform('zrotate', right);
minuteHandMatrices{6,2} = makehgtform('zrotate', up);
minuteHandMatrices{6,3} = makehgtform('zrotate', down);
minuteHandMatrices{6,4} = makehgtform('zrotate', up);
minuteHandMatrices{6,5} = makehgtform('zrotate', down);
minuteHandMatrices{6,6} = makehgtform('zrotate', left);

% 6 Matrices
hourHandMatrices{7,1} = makehgtform('zrotate', right);
hourHandMatrices{7,2} = makehgtform('zrotate', down);
hourHandMatrices{7,3} = makehgtform('zrotate', right);
hourHandMatrices{7,4} = makehgtform('zrotate', left);
hourHandMatrices{7,5} = makehgtform('zrotate', left);
hourHandMatrices{7,6} = makehgtform('zrotate', left);

minuteHandMatrices{7,1} = makehgtform('zrotate', up);
minuteHandMatrices{7,2} = makehgtform('zrotate', up);
minuteHandMatrices{7,3} = makehgtform('zrotate', down);
minuteHandMatrices{7,4} = makehgtform('zrotate', up);
minuteHandMatrices{7,5} = makehgtform('zrotate', down);
minuteHandMatrices{7,6} = makehgtform('zrotate', left);

% 7 Matrices - Done
hourHandMatrices{8,1} = makehgtform('zrotate', left);
hourHandMatrices{8,2} = makehgtform('zrotate', left);
hourHandMatrices{8,3} = makehgtform('zrotate', right);
hourHandMatrices{8,4} = makehgtform('zrotate', up);
hourHandMatrices{8,5} = makehgtform('zrotate', up);
hourHandMatrices{8,6} = makehgtform('zrotate', left);

minuteHandMatrices{8,1} = makehgtform('zrotate', down);
minuteHandMatrices{8,2} = makehgtform('zrotate', left);
minuteHandMatrices{8,3} = makehgtform('zrotate', right);
minuteHandMatrices{8,4} = makehgtform('zrotate', up);
minuteHandMatrices{8,5} = makehgtform('zrotate', down);
minuteHandMatrices{8,6} = makehgtform('zrotate', down);

% 8 Matrices
hourHandMatrices{9,1} = makehgtform('zrotate', right);
hourHandMatrices{9,2} = makehgtform('zrotate', right);
hourHandMatrices{9,3} = makehgtform('zrotate', right);
hourHandMatrices{9,4} = makehgtform('zrotate', left);
hourHandMatrices{9,5} = makehgtform('zrotate', left);
hourHandMatrices{9,6} = makehgtform('zrotate', left);

minuteHandMatrices{9,1} = makehgtform('zrotate', up);
minuteHandMatrices{9,2} = makehgtform('zrotate', up);
minuteHandMatrices{9,3} = makehgtform('zrotate', down);
minuteHandMatrices{9,4} = makehgtform('zrotate', up);
minuteHandMatrices{9,5} = makehgtform('zrotate', down);
minuteHandMatrices{9,6} = makehgtform('zrotate', down);

% 9 Matrices
hourHandMatrices{10,1} = makehgtform('zrotate', left);
hourHandMatrices{10,2} = makehgtform('zrotate', right);
hourHandMatrices{10,3} = makehgtform('zrotate', right);
hourHandMatrices{10,4} = makehgtform('zrotate', up);
hourHandMatrices{10,5} = makehgtform('zrotate', up);
hourHandMatrices{10,6} = makehgtform('zrotate', left);

minuteHandMatrices{10,1} = makehgtform('zrotate', down);
minuteHandMatrices{10,2} = makehgtform('zrotate', up);
minuteHandMatrices{10,3} = makehgtform('zrotate', down);
minuteHandMatrices{10,4} = makehgtform('zrotate', up);
minuteHandMatrices{10,5} = makehgtform('zrotate', down);
minuteHandMatrices{10,6} = makehgtform('zrotate', down);