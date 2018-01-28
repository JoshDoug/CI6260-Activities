% Joshua Stringfellow, K1460846
% Lab 7 - Feature Extraction

% Task 1 - Read 'shapes.bmp' and save as Img
Img = imread('shapes.bmp');

% Task 2 - Find best grey level T and use thresholding to segment image
% into shapes (white) and background (black) and compare result with
% graythresh

Img = Img(:,:,1); % .bmp image has 3 layers, although each layer looks
% identical so reduce it to a single layer to work with imbinarize
imgtest = Img > 100;

T = graythresh(Img);
imgbin = imbinarize(Img, T);

figure(1)
subplot(1,3,1); imshow(Img); title('Original');
subplot(1,3,2); imshow(imgtest); title('Manual Threshold'); % 1-126 will work
subplot(1,3,3); imshow(imgbin); title('Using graythresh');

% They're the same because the image doesn't have any gradients so finding the
% threshold between the background and the shapes is very straightforward
% and has a wide margin

% Task 3 - Plot the borders of all shapes on the original grayscale image

imgfill = imfill(imgbin, 'holes');
bound = bwboundaries(imgfill);

figure(2)
imshow(Img);
hold on;

for i=1:length(bound)
    b = bound{i};
    plot(b(:,2), b(:,1), 'r', 'LineWidth', 3);
end

% Task 4 - Compute the area, rectangularity, compactness, diameters, major &
% minor axis length of each shape.

imglabel = bwlabel(imgfill);
stats = regionprops(imgfill, imglabel, 'Area', 'Centroid', 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength');
diameter = mean([stats.MajorAxisLength stats.MinorAxisLength], 2);

figure(3)
imshow(Img);
hold on;

for i=1:length(bound)
    b = bound{i};
    diameter = mean([stats(i).MajorAxisLength stats(i).MinorAxisLength], 2);
    
    plot(b(:,2), b(:,1), 'r', 'LineWidth', 3);
    text(b(1,2) + 10, b(1,1), strcat('Area ', int2str(stats(i).Area)));
    %text(b(1,2) + 10, b(1,1), int2str(stats(i))); Rectangularity?
    %text(b(1,2) + 10, b(1,1), int2str(stats(i))); Compactness?
    text(b(1,2) + 10, b(1,1) + 10, strcat('Diameter ', int2str(diameter)));
    text(b(1,2) + 10, b(1,1) + 20, strcat('Major Axis ', int2str(stats(i).MajorAxisLength)));
    text(b(1,2) + 10, b(1,1) + 30, strcat('Minor Axis ', int2str(stats(i).MinorAxisLength)));
end

% Task 5 - Keep only the largest eclipse and display

area = 0; % Var to hold area for comparison in loop
imgno = 0; % Var to hold image number
for i=1:length(stats) % Loop to select largest eclipse by area
    if(stats(i).Area > area) % If the area is larger than the current largest area, update the area and img number
       area = stats(i).Area;
       imgno = i;
    end
end

figure(4)
imshow(imglabel == imgno);







