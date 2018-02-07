% Test

imgEye1 = imread('Eye2.png');

%Kirsch Matrix Templates
% Matrix is rotated clockwise unlike the linked example, but it's the
% sumation that matters, not the rotation order
h=[5, -3, -3; 5, 0, -3; 5, -3, -3]; % Starting matrix
imgKirsch{8} = imgEye1; % Pre-allocate (kind of)
imgSum = 0;

for i=1:8
    imgKirsch{i} = imfilter(imgEye1, h);
    
    if imgSum == 0 % Set initial image of of first kirsch filtered orignal image
       imgSum = imgKirsch{i}; 
    else
        imgSum = imadd(imgSum, imgKirsch{i});
    end
    
    % Rotate matrix by 45 degrees clockwise
    h(:) = h([2 3 6 1 5 9 4 7 8]);
end

figure(1)
subplot(2,5,1); imshow(imgEye1); title('Eye 1');
subplot(2,5,2); imshow(imgSum); title('Summation');
subplot(2,5,3); imshow(imgKirsch{1}); title('A');
subplot(2,5,4); imshow(imgKirsch{2}); title('B');
subplot(2,5,5); imshow(imgKirsch{3}); title('C');
subplot(2,5,6); imshow(imgKirsch{4}); title('D');
subplot(2,5,7); imshow(imgKirsch{5}); title('E');
subplot(2,5,8); imshow(imgKirsch{6}); title('F');
subplot(2,5,9); imshow(imgKirsch{7}); title('G');
subplot(2,5,10); imshow(imgKirsch{8}); title('H');

grayEye1 = rgb2gray(imgSum);
T = graythresh(grayEye1);
binEye1 = imbinarize(grayEye1, T);
medEye1 = medfilt2(binEye1);
medEye1 = removePerim(imgEye1, medEye1, 6);

se = strel('disk', 2); % Create morphological structuring element
erodeEye1 = imerode(binEye1, se);
erodeEye1 = removePerim(imgEye1, erodeEye1, 6);
binEye1 = removePerim(imgEye1, binEye1, 6);

figure(2)
subplot(2,2,1); imshow(grayEye1); title('Grayscale image');
subplot(2,2,2); imshow(binEye1); title('Binary image');
subplot(2,2,3); imshow(erodeEye1); title('Erode image');
subplot(2,2,4); imshow(medEye1); title('Median filtered image');

% 1 - erodeEye1: Write image that used erosion on grayscale summation image
imwrite(erodeEye1, 'imgErode.png');

% 2 - medEye1: Write image that used median filtering
imwrite(medEye1, 'imgMed.png');

