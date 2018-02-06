% Joshua Stringfellow, K1460846
% Lab 8 - Final Image Processing Workshop

% Task 1 - Read ImageRandomNoise.bmp and save as Img
Img1 = imread('Image1RandomNoise.bmp');
Img2 = imread('Image2StructuralNoise.png');

% Task 2 - Remove random and structural noise from images
Img1 = rgb2gray(Img1(1:243,1:299,:)); % Crop out whitespace and convert from rgb to grayscale
Img2 = rgb2gray(Img2(1:243,1:299,:)); % Same again

procImg1 = medfilt2(Img1); % Apply a median filter to remove noise
procImg1 = imsharpen(procImg1); % Apply a sharpen filter

procImg2 = Img2;
boundary = 190; % 190 as a general 'threshold' boundary (idea inspired from thresholding)
% Each band/stripe has shifted most of the pixels roughly the same amount,
% so each row can be nearly corrected just by shifting the entire row on
% the basis of the first pixel, perhaps an unorthodox approach.
[height, width] = size(Img2);
for i=1:height
    if(procImg2(i,1,1) < boundary)
       procImg2(i,:,1) =  procImg2(i,:,1) + (boundary - procImg2(i,1,1));
    end
end
procImg2 = procImg2 - 50; % Lighten image a tad

h = ones(4,1)/4;
filtImg = imfilter(procImg2, h); % Apply N-D filter
sharpImg = imsharpen(filtImg); % Apply 'unsharp' filter

figure(1);
subplot(2,2,1); imshow(Img1); title('Original Image 1');
subplot(2,2,2); imshow(procImg1); title('Processed Image 1');
subplot(2,2,3); imshow(Img2); title('Original Image 2');
subplot(2,2,4); imshow(sharpImg); title('Processed Image 2');

% Task 3 - Segment banana and save final images as binary bmp image

% Couldn't figure this out.

se = strel('square', 3);
procImg1 = imerode(procImg1, se);
T1 = graythresh(procImg1);
img1bin = imbinarize(procImg1, T1);
%img1fill = imfill(img1bin, 'holes');
img1label = bwlabel(img1bin);

figure(2)
subplot(2,2,1); imshow(procImg1); title('Original Image 1');
subplot(2,2,2); imshow(img1bin); title('BW Img1');
subplot(2,2,3); imshow(img1fill); title('Filled Img1');
subplot(2,2,4); imshow(img1label == 5); title('Processed Image 2');







