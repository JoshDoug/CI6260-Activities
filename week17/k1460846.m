% K1460846, Joshua Stringfellow
% Week 17, Lab 7 - Image Compression
% Note: Takes a little while to run...

% Task 1 - Differential Coding, for a grayscale or colour image perform the following computations:
img = imread('harbour.png');

% a) Compute the entropy of the image
E = entropy(img); % ~7.75

% b) Compute the first differential of the image (e.g. image gradient)
% % Using fspecial pruitt filter
h = fspecial('prewitt');
imgPrewitt = imfilter(img, h);

% % Using more straightforward diff function
imgDiff = diff(img);

% c) Compute the entropy of the differential image
EPrewitt = entropy(imgPrewitt); % ~3.64
EDiff = entropy(imgDiff);

% d) Compare the entropy values of the original and differenced image:
figure(1)
subplot(2,3,1); imshow(img); title('Original Image');
subplot(2,3,2); imshow(imgPrewitt); title('Prewitt Image');
subplot(2,3,3); imshow(imgDiff); title('Diff Image');
% Seemed to work fine, but after clearing it stopped and apparently
% requires a grayscale/one channel image. Not sure what changed.
subplot(2,3,4); imhist(rgb2gray(img)); title('Original Histogram');
subplot(2,3,5); imhist(rgb2gray(imgPrewitt)); title('Prewitt Histogram');
subplot(2,3,6); imhist(rgb2gray(imgDiff)); title('Diff Histogram');

% The entropy value of the differential image is half that of the original
% image but higher than the simple diff which has an entropy of 2.33.

% Task 3 - JPEG Compression
% 1) Load original image - harbour.png (done above)
% 2) Save the image using imwrite (JPEG) using a Q factor of 50
imwrite(img, 'imgComp50.jpg', 'Quality', 50);

% 3) Load compressed image from and compare with original image using PSNR criteria
imgComp = imread('imgComp50.jpg');
peaksnr = psnr(imgComp, img); % returns 34.9

% 4) Experiment with JPEQ Quality parameter and associated compression
% efficiencies, use imfinfo to get file size details
imwrite(img, 'imgComp10.jpg', 'Quality', 10);
imwrite(img, 'imgComp20.jpg', 'Quality', 20);
imwrite(img, 'imgComp30.jpg', 'Quality', 30);
imwrite(img, 'imgComp40.jpg', 'Quality', 40); % Skip 50 as we already have that
imwrite(img, 'imgComp60.jpg', 'Quality', 60);
imwrite(img, 'imgComp70.jpg', 'Quality', 70);
imwrite(img, 'imgComp80.jpg', 'Quality', 80);
imwrite(img, 'imgComp90.jpg', 'Quality', 90);
% Uncomment for first run, but comment after to avoid unnecessary time consuming writes
% Use imfinfo from the prompt/command window

figure(2)
for i=1:9
    filename = strcat('imgComp', int2str(i), '0.jpg');
    tempImg = imread(filename);
    fileInfo = imfinfo(filename);
    titlename = strcat(filename, ' ', fileInfo.FileSize);
    subplot(2,5,i); imshow(tempImg); title(titlename);
end

fileInfo = imfinfo('harbour.png');
titlename = strcat('harbour.png ', fileInfo.FileSize);
subplot(2,5,10); imshow(img); title(titlename);

% 5) Write a program to create a plot of the quality factor vs file size
% and quality factor vs PSNR acrss the range of quality factors (1-100)

%imageValues{100}.peaksnr = 0;
imagesPSNR = zeros(1,100);
imagesFS = zeros(1,100);

% Compress image with Q-factor 1-100 and plot them
for i=1:100
   imwrite(img, 'tempImg.jpg', 'Quality', i);
   tempImg = imread('tempImg.jpg');
   imagesPSNR(i) = psnr(tempImg, img);
   imgInfo = imfinfo('tempImg.jpg');
   imagesFS(i) = imgInfo.FileSize;
end

figure(3)
plot(1:100, imagesPSNR(1:100)); title('Quality Factor vs PSNR');

figure(4)
plot(1:100, imagesFS(1:100)); title('Quality Factor vs File Size');

% 6) visually judge the de-compressed image and identify the minimum
% Q-factor value that produces an image of acceptable quality

% The point at which the image is still of acceptable quality is
% subjective, and the image is according to MatLab too large and is
% displayed at 50%, so a higher resolution screen might give slightly
% different results when being visually judged.
% Images still look good with no obvious artifacting when the Quality level
% is set to 30, but artifacts become quite obvious in the water and
% especially the sky at quality factor 20. At Quality factor 25 the water
% looks good, as do the ships, and the artifacting is visible in the sky
% but only if you're expecting it and know to look for it. I'd say 25 is
% roughly the cutoff point.



