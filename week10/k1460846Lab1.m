% Lab 1

Img = imread('cameraman.tif'); % 1. Load 'camerman.tif'
Img1 = imread('rice.png'); % 2. Load 'rice.png'
h = imadd(Img, 50); % 3. Add 50 to each pixel of Img
h1 = imsubtract(Img1, h); % 4. Subtract h from 2nd Img

% 5. Display the four images in a subplot
figure(1)
subplot(2,2,1); imshow(Img); title('Cameraman');
subplot(2,2,2); imshow(Img1); title('Rice');
subplot(2,2,3); imshow(h); title('Lighter');
subplot(2,2,4); imshow(h1); title('h subtracted from 2nd image');

% 6. Display intensity histogram of Img and h
figure(2)
subplot(1,2,1); imhist(Img); title('Img histogram');
subplot(1,2,2); imhist(h); title('h histogram');
% The two histograms show how the values between 0 and 255 have been
% shifted by +50 in h from Img making h lighter. MatLab also ensures that
% values greater than 255 don't overflow.

% 7. Enhance contrast of image by histogram equalisation
EnhImg = histeq(Img); % Not clear which image to equalise
figure(3)
subplot(2,2,1); imshow(Img); title('Img');
subplot(2,2,2); imshow(EnhImg); title('EnhImg');
subplot(2,2,3); imhist(Img); title('Img histogram');
subplot(2,2,4); imhist(EnhImg); title('EnhImg histogram');
% The histograms show that the EnhImg has a greater and more even spread
% of values after the equalisation has re-distributed the grayscale values.
% The resulting EnhImg has more contrast between the person and the sky and
% the details of the jacket are more visible.