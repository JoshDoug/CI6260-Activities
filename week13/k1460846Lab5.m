% Josh Stringfellow, K1460846
% Lab 5 Task 3 - Image Segmentation

% 1. Read coings.png and save
img = imread('coins.png');

% 2. Find best grey level T and use thresholding method to segment to coins
% (White) and background (Black) and compare results with MATLAB's
% graythresh
T = graythresh(img);
%imgbw = im2bw(img, T);
imgbin = imbinarize(img, T); % recommended alternative to deprecated im2bw function

figure(1)
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(img > 95); title('Image > 95');
%subplot(1,3,3); imshow(imgbw); title('im2bw img');
subplot(1,3,3); imshow(imgbin); title('imbinarize img');

% 3. Plot the borders of all coins on the grayscale image
img_filled = imfill(imgbin, 'holes'); % fill image holes
boundaries = bwboundaries(img_filled); % trace region boundaries

figure(2)
imshow(img)
hold on;

for i=1:length(boundaries)
   b = boundaries{i}; % Select coin boundary
   plot(b(:,2), b(:,1), 'r', 'LineWidth', 3); % Plot boundary on img
end

% 4. Label coins in a binary image and display label 7
imgLabel = bwlabel(img_filled); % Re-use imfill image from task 3 ...
% ... and get matrix of labels for the 8-connected objects found in img

figure(3)
imshow(imgLabel == 7); title('Label 7 Object'); % Select region 7 and display it