% WS2 Script

obj.reader = vision.VideoFileReader('TownCentre.mp4');
obj.detector = vision.ForegroundDetector('NumGaussians', 3, 'NumTrainingFrames',20, ...
    'MinimumBackgroundRatio', 0.7); % Initialise GMM for background
obj.blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, 'AreaOutputPort', true, ...
    'CentroidOutputPort', true, 'MinimumBlobArea', 400); % Initialise blob detector

for i=1:20
    frame = obj.reader.step();
    frame = imresize(frame, 0.5);
    mask = obj.detector.step(frame); % Detect foreground.
    
    % Apply morphological operations to remove noise and fill in holes.
    mask = imopen(mask, strel('rectangle', [3,3]));
    mask = imclose(mask, strel('rectangle', [5, 5]));
    mask = imfill(mask, 'holes');
    
    figure(1);
    imshow(mask);
    
    figure(2);
    imshow(frame);
    
    % Perform blob analysis to find connected components.
    [~, centroids, bboxes] = obj.blobAnalyser.step(mask);
    hold on
    
    % Draw the object bounding boxes on the image frame.
    for j=1:size(bboxes,1)
        frame = rectangle('Position', bboxes(j,:));
    end
    drawnow
end