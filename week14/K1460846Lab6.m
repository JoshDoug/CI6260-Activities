% Joshua Stringfellow, K1460846
% Lab 6 - Morphological Operations

% 1. Read coings.png and label coins, find area of each point
img = imread('coins.png');
T = graythresh(img);
imgbin = imbinarize(img, T);
img_filled = imfill(imgbin, 'holes'); % fill image holes
imgLabel = bwlabel(img_filled);

stats = regionprops(img_filled, imgLabel); % Get the areas for each coin/region

% figure(1)
imshow(imgLabel);
hold on;

boundaries = bwboundaries(img_filled); % trace region boundaries

for i=1:length(boundaries)
   b = boundaries{i}; % Select coin boundary
   text(b(1,2) + 5, b(1,1), int2str(stats(i).Area)); % Use coin boundary cordinates to plot area size
   % Area size is just the total number of pixels
end

% 2. Enhance contrast of coins.png
% Create structured element and use it with each morphological operation
% that might make sense (so not including skeleton)
se = strel('disk', 2);
dilateimg = imdilate(img, se);
erodeimg = imerode(img, se);
openimg = imopen(img, se);
closeimg = imclose(img, se);

figure(2)
subplot(2,3,1); imshow(dilateimg); title('Dilate Image');
subplot(2,3,2); imshow(erodeimg); title('Erode Image');
subplot(2,3,3); imshow(openimg); title('Open Image');
subplot(2,3,4); imshow(closeimg); title('Close Image');
subplot(2,3,5); imshow(img); title('Original Image');

% Of the operations the dilation is the least useful in improving the
% contrast, and mostly just blurs/increases the noise of the image

% Erosion obscures a lot of detail but increases the contrast for
% objects within the coins such as the outline of a head or building, but
% it also introduces/increases shadows.

% Close image keeps some of the finer details but the image gets lighter
% and the contrast doesn't seem to improve

% Open image seems to do the best job of increasing the contrast but loses
% more of the finer details than closing. Although it still keeps more
% details than erosion.

% 3. Use morphological operations, thresholding, and labeling to segment cameraman
imgMan = imread('cameraman.tif');

SE = strel('square', 7); % 7 seems like a good size for removing minor details without deforming the cameraman
imgresult = imclose(imgMan, SE);
imgresult = imfill(imgresult);

imgresult = uint8(255) - imgresult; % invert image otherwise boundary selects the inverse of the cameraman

T = graythresh(imgresult);
imgresult = imbinarize(imgresult, T); % Apply threshold

imgLabel = bwlabel(imgresult); % Get labels
boundary = bwboundaries(imgresult); % Get boundaries

figure(3)
subplot(1,2,1); imshow(imgMan); title('Original Image');
subplot(1,2,2); imshow(imgLabel == 2); title('Segmented Image');

hold on;

% Plot boundary around cameraman (not really necessary but nicely highlights him)
b = boundary{2};
plot(b(:,2), b(:,1), 'r', 'LineWidth', 3);