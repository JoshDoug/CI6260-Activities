% Image Processing Coursework
%imgEye = imread('Eye1.png');
imgEye = imread('Eye2.png');

% a) Convert colour images to grayscale while maintaining the contrast of the vessels

imgGS1 = rgb2gray(imgEye);
imgAdptCont = adapthisteq(imgGS1);

% b) Automatically segment/detect retinal vessels in the colour images

imgEdge = edge(imgGS1, 'Canny');
imgAdptEdge = edge(imgAdptCont);
imgDoubleAdapt = edge(imgAdptEdge);

imgEdge = removePerim(imgEye, imgEdge, 6);
imgAdptEdge = removePerim(imgEye, imgAdptEdge, 6);
imgDoubleAdapt = removePerim(imgEye, imgDoubleAdapt, 6);

se = strel('disk', 2);
imgDilate = imdilate(imgAdptEdge, se);
imgDoubleAdptDilate = imdilate(imgDoubleAdapt, se);

subplot(2,4,1); imshow(imgEye); title('Eye 1');
subplot(2,4,2); imshow(imgGS1); title('Grayscale');
subplot(2,4,3); imshow(imgAdptCont); title('Adaptive Equalisation Contrast');
subplot(2,4,4); imshow(imgEdge); title('Edge');
subplot(2,4,5); imshow(imgAdptEdge); title('Adapt Contrast and Edge');
subplot(2,4,6); imshow(imgDoubleAdapt); title('Double Adapt Contrast and Edge');
subplot(2,4,7); imshow(imgDilate); title('Dilated');
subplot(2,4,8); imshow(imgDoubleAdptDilate); title('Adapted and Dilated');

% 1 - imgEdge: Write image created from grayscale image using Canny edge detection
imwrite(imgEdge, 'imgCannyEdge.png');

% 2 - imgAdptEdge: Write image created from grayscale image using adaptive histogram
% equalisation and edge detection
imwrite(imgAdptEdge, 'imgAdaptEdge.png');

% 3 - imgDoubleAdapt: Write image created from double edge detection,
% adaptive hist equalisation, and dilation
imwrite(imgDoubleAdapt, 'imgDoubleAdapt.png');

% 4 - imgDilate: Write image created from adaptive hist equalisation, edge
% detection
imwrite(imgDilate, 'imgDilate.png');

% 5 - imgDoubleAdptDilate: Write image created from adaptive hist equalisation,
% double edge detection
imwrite(imgDoubleAdptDilate, 'imgDoubleAdptDilate.png');
