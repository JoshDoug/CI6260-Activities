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
subplot(2,1,1); imshow(img); title('Original Image');
subplot(2,1,2); imshow(real(iimg)); title('Low Pass Image'); % Image with Low Pass filter applied

% 2 - Apply a Gaussian filter, 15x15, sigma 3.0, in the spatial domain to an image
gimg2 = imgaussfilt(img, 3, 'FilterSize', 15);

figure(2)
imshow(gimg2);

% 3 - Same Gaussian filter applied in the frequency domain
fdimg2 = imgaussfilt(img, 3, 'FilterDomain', 'frequency');
figure(3)
imshow(fdimg2);