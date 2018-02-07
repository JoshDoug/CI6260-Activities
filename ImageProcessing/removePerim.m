function [ maskedImage ] = removePerim( imgGS, imageToMask, n )
%REMOVEPERIM Remove the perimeter of the eye
%   Uses the colour image to create a mask, erodes it and then deletes from
%   the image that has the vessels segmeented

grayScaleImage = rgb2gray(imgGS); % Convert to grayscale
T = graythresh(grayScaleImage); % Get threshold

binImg = imbinarize(grayScaleImage, T); % Convert to black and white
se = strel('disk', n); % Create morphological structuring element
imgEro = imerode(binImg, se); % Erode image
imgImc = imcomplement(imgEro); % Invert image

maskedImage = imageToMask;
maskedImage(imgImc) = 0; % Mask image

end

