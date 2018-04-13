% Joshua Stringfellow, K1460846
% Computer Vision, Coursework 3

% Cleanup
close all
clear overlapResults;
clear personGT;
clear allFrames;
clear personFrames;

person = 14; % Set Person from GroundTruth file
chosenBox = 3; % Select person detected by the people detector

groundTruth = csvread('TownCentre-groundtruth.top');
% % Convert tracks to width/height
for j=[7,8,11,12]
    groundTruth(:,j)=groundTruth(:,j)-groundTruth(:,j-2);
end

 % Bump frames to start at 1 to avoid zero index issues
groundTruth(:,1) = groundTruth(:,1) + 1; % Person Number
groundTruth(:,2) = groundTruth(:,2) + 1; % Frame Number

% Read in Video File
%infile = 'TownCentreXVID.avi';
infile = 'TownCentre.mp4'; % Use mp4 on macOS (avi doesn't work)

readerobj = VideoReader(infile);
width = readerobj.Width; % Get width and height of frames
height = readerobj.Height;
numChannels = 3; % Set number of channels (RGB so equals 3)

% Select a person from the groundTrust data structure
personGT = groundTruth(groundTruth(:,1)  == person,:); % Select person from grountTruth
firstFrame = personGT(1,2); % Select first frame the person appears in
lastFrame = max(personGT(:,2)); % Set range of frames to work through - using final frame person appears in
%lastFrame = firstFrame + 1; % Limit number of frames to n for testing

% Select frames containing person to be tracked - can be commented out on a 2nd+ run with the same person
allFrames = zeros(height,width,numChannels,'uint8'); % Pre-allocate frames matrix
for i=1:lastFrame
    frame = readFrame(readerobj); % Read frame
    allFrames(:,:,:,i) = frame;
end

% Scope frames to those the person is in (avoids any frames prior to the frame the person appears in)
personFrames = zeros(height, width, numChannels, 'uint8');
for i=firstFrame:lastFrame
    personFrames(:,:,:,(i - firstFrame) + 1) = allFrames(:,:,:,i);
end
personGT(:,2) = (personGT(:,2) - firstFrame) + 1;

% Detect people in first frame and select a person
peopleDetector = vision.PeopleDetector;
imgFrame = personFrames(:,:,:,1);
[bboxes, scores] = step(peopleDetector, imgFrame);
%imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes, scores);
imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes(chosenBox,:), scores(chosenBox), 'Color', 'cyan');
figure(1), imshow(imgFrame)
title('People detected');

i=1;
centerX = personGT(i,9) + (personGT(i,11)/2);
centerY = personGT(i,10) + (personGT(i,12)/2);
priorX = centerX;
priorY = centerY;
bbX = bboxes(chosenBox,1) + (bboxes(chosenBox,3)/2);
bbY = bboxes(chosenBox,2) + (bboxes(chosenBox,4)/2);
pbbX = bbX;
pbbY = bbY;

overlapResults(firstFrame:lastFrame) = 0;
priorBB = bboxes(chosenBox,:);
for i=2:lastFrame
    imgFrame = personFrames(:,:,:,i);
    [bboxes, scores] = step(peopleDetector, imgFrame);

    % Find closest bbox to detect same person in the next frame
    for j=1:length(bboxes(:,1))
        Dtemp = sqrt((priorBB(1,1) - bboxes(j,1))^2 + (priorBB(1,2) - bboxes(j,2))^2);
        if ~exist('D', 'var')
            D = Dtemp;
            Dn = j;
        elseif Dtemp < D
            D = Dtemp;
            Dn = j;
        end
    end
    priorBB = bboxes(Dn,:); % Store bbox for comparison in next loop
    % Annotate person
    %imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes, scores);
    imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes(Dn,:), scores(Dn), 'Color', 'cyan');
    imshow(imgFrame)
    title(strcat(int2str(i), ' Frame'));
    
    hold on
    bodyCoords = personGT(i, 9:12);
    rectangle('Position', bodyCoords, 'EdgeColor', 'w');
    drawnow
    pause(1)
    
    % Plot trajectory
    figure(2)
    centerX = personGT(i,9) + (personGT(i,11)/2);
    centerY = personGT(i,10) + (personGT(i,12)/2);
    hold on
    plot([priorX,centerX],[priorY,centerY], 'Color', 'r');
    bbX = bboxes(Dn,1) + (bboxes(Dn,3)/2);
    bbY = bboxes(Dn,2) + (bboxes(Dn,4)/2);
    plot([pbbX,bbX],[pbbY,bbY], 'Color', 'b');
    drawnow
    priorX = centerX;
    priorY = centerY;
    pbbX = bbX;
    pbbY = bbY;
    figure(1)
    
    % Compare BBoxes
    overlapResults(i) = bboxOverlapRatio(personGT(i,9:12),bboxes(Dn,:), 'ratioType', 'Min');
    
    clear D;
end

% Code found to alert the end of a program (Matlab's Beep function didn't work)
load handel
sound(y,Fs)