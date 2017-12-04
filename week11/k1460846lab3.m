% Joshua Stringfellow, K1460846

Img = imread('cameraman.tif'); % 1. Load 'camerman.tif'

% 2. Apply averaging filters to Img
h1 = ones(3, 3)/9;
h2 = ones(7, 7)/49;
h3 = ones(10, 10)/100;

Img1 = imfilter(Img,h1);
Img2 = imfilter(Img,h2);
Img3 = imfilter(Img,h3, 'replicate'); % Filter with 10x10 matrix, 4. Use
% replicate to remove black border from around image

% 3. The larger the matrix the more neighbouring pixels are used in the
% creation of the new value for the pixel being targeted by a kernel, so the picture
% will be more blurry as a result. Pixels that are not directly
% neighbouring are less likely to be the same or nearly the same
% colour/gradient as the pixel being targetted, distorting the value.

figure(1)
subplot(2,2,1); imshow(Img); title('Img');
subplot(2,2,2); imshow(Img1); title('Img1');
subplot(2,2,3); imshow(Img2); title('Img2');
subplot(2,2,4); imshow(Img3); title('Img3');

% 5. Add Gaussian noise to image and then apply median and mean filter to
% create two new images from the obtained image.

% Apply Gaussian smoothing
gaussImg = imnoise(Img, 'gaussian');

% Apply mean filter
meanFilt = fspecial('average'); % Create filter
meanImg = imfilter(gaussImg, meanFilt); % Apply filter and create image

% Apply median filter and create image
medImg = medfilt2(gaussImg);

figure(2)
subplot(2,2,1); imshow(medImg); title('Img median');
subplot(2,2,2); imshow(meanImg); title('Img mean');
subplot(2,2,3); imhist(medImg); title('Img median histogram');
subplot(2,2,4); imhist(meanImg); title('Img mean histogram');

% The histogram shows the mean image as a smoother distribution of values
% and the mean image also looks slightly smoother with 
% fewer artifacts and jagged edges. The mean image might be preferable to a
% human but the median image might be preferable for use in computer
% analysis as there's higher contrast and the edges look sharper.
