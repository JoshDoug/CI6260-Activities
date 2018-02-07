% Create image mask

imgEye1 = imread('testEye.jpg');
imgGS1 = rgb2gray(imgEye1);
T = graythresh(imgGS1);
imgGT1 = imbinarize(imgGS1, T);
imgImc = imcomplement(imgGT1);
se = strel('disk', 2);
imgEro = imerode(imgImc, se);

imshow(imgEro);