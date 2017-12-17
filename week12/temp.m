% Week 12 Actvities

img = imread('cameraman.tif');

%img = imrotate(img, 45);

ftimg = fft2(img);

ftsimg = fftshift(ftimg);

img2 = ifft2(ftimg);

figure(1)
subplot(1,5,1); imshow(img); title('img');
subplot(1,5,2); imshow(real(ftimg)); title('ftimg');
subplot(1,5,3); imshow(log(abs(ftsimg)),[]); title('ftsimg');
subplot(1,5,4); imshow(angle(ftsimg)); title('ftsimg angle');
subplot(1,5,5); imshow(real(img2),[]); title('img2');

% 1 - An ideal lowpass filter with radius of 7

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

lftdisk = ftimg .* disk;
limg = ifft2(lftdisk);

% High Pass
disk = ones(N,M);
for i=1:N
    for j=1:M
        r2 = (i - round(N/2))^2 + (j - round(M/2))^2;
        if r2 < round(r^2)
            disk(i,j) = 0;
        end
    end
end
disk = fftshift(disk);

hftdisk = ftimg .* disk;
himg = ifft2(hftdisk);


figure(2)
subplot(2,2,1); imshow(real(limg));
subplot(2,2,2); imshow(real(himg));
subplot(2,2,3); imshow(ifftshift(lftdisk));
subplot(2,2,4); imshow(ifftshift(hftdisk));

% Task 2 - Construct a Gaussian-shaped filter using fspecial and convolve it

h = fspecial('gaussian', [N,M], 3.0);
fconv = conv2(h, img);
% = ftimg .* f;

figure(3)
imshow(fconv);





