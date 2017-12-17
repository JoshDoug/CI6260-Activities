% Week 12 Actvities

img = imread('cameraman.tif');
ftimg = fft2(img);

% 1 - Apply an ideal lowpass filter with radius of 7 to an image

[N, M] = size(img); r = 7;
disk = ones(N,M);

% Low Pass
for i=1:N
    for j=1:M
        r2 = (i - round(N/2))^2 + (j - round(M/2))^2;
        if r2 > round(r^2)
            disk(i,j) = 0;
        end
    end
end
disk = fftshift(disk);

ftdisk = ftimg .* disk;
iimg = ifft2(ftdisk);

figure(1)
subplot(2,2,1); imshow(img); title('Original Image');
subplot(2,2,2); imshow(real(iimg)); title('Low Pass Image'); % Image with Low Pass filter applied
subplot(2,2,3); imshow(real(ftdisk)); title('ftimg applied to disk');
subplot(2,2,4); imshow(real(ifftshift(ftdisk))); title('inverse shift of ftdisk');

% 2 - Apply a Gaussian filter, 15x15, sigma 3.0, in the spatial domain to an image

h = fspecial('gaussian', [15, 15], 3.0);
gimg = imfilter(img, h, 'replicate');

figure(2)
imshow(gimg);

% 3 - Same Gaussian filter applied in the frequency domain



% 4





