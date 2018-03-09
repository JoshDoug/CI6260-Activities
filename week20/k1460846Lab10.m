% K1460846, Joshua Stringfellow
% Lab 10, Week 20, Video Analysis Workshop

groundTruth = csvread('TownCentre-groundtruth.top');

% % Convert tracks to width/height
for j=[7,8,11,12]
    groundTruth(:,j)=groundTruth(:,j)-groundTruth(:,j-2);
end

% Read in Video File
infile = 'TownCentreXVID.avi';
%infile = 'TownCentre.mp4'; % Use mp4 on macOS (avi doesn't work)

readerobj = VideoReader(infile);
width = readerobj.Width; % Get width and height of frames
height = readerobj.Height;
numChannels = 3; % Set number of channels (RGB so equals 3)

% allFrames = zeros(height,width,numChannels,'uint8'); % Pre-allocate frames matrix
for i=1:50
    frame = readFrame(readerobj); % Read frame
    allFrames(:,:,:,i) = frame;
    %imshow(allFrames(:,:,:,i));
    %drawnow
end

% for i=1:10
%     imshow(allFrames(:,:,:,i));
%     drawnow
%     hold on
%     for j=1:14
%         headCoords = groundTruth((i - 1) * 14 + j, 5:8);
%         bodyCoords = groundTruth((i - 1) * 14 + j, 9:12);
%         rectangle('Position', headCoords, 'EdgeColor', 'r');
%         rectangle('Position', bodyCoords, 'EdgeColor', 'w');
%         drawnow
%     end
%     pause(2)
% end

% imshow(allFrames(:,:,:,1));
% drawnow
% hold on

% Detect people in first frame and select a person
peopleDetector = vision.PeopleDetector;
imgFrame = allFrames(:,:,:,1);
[bboxes, scores] = step(peopleDetector, imgFrame);
imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes, scores);
imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes(2,:), scores(2), 'Color', 'cyan');
figure, imshow(imgFrame)
title('People detected');

priorBB = bboxes(2,:);
for i=2:10
    imgFrame = allFrames(:,:,:,i);
    [bboxes, scores] = step(peopleDetector, imgFrame);

    for j=1:length(bboxes)
        Dtemp = sqrt((priorBB(1,1) - bboxes(j,1))^2 + (priorBB(1,2) - bboxes(j,2))^2);
        if ~exist('D', 'var')
            D = Dtemp;
            Dn = j;
        elseif Dtemp < D
            D = Dtemp;
            Dn = j;
        end
    end

    priorBB = bboxes(Dn,:);
    imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes, scores);
    imgFrame = insertObjectAnnotation(imgFrame, 'rectangle', bboxes(Dn,:), scores(Dn), 'Color', 'cyan');
    imshow(imgFrame)
    title(strcat(int2str(i), ' Frame'));
    clear D;
end

% Task 2