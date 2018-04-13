% Matlab Example  https://uk.mathworks.com/help/images/examples/detect-and-measure-circular-objects-in-an-image.html

rgb = imread('coloredChips.png');
rgb = imresize(rgb, 2);

%d = imdistline;
%delete(d);

%gray_image = rgb2gray(rgb);
%imshow(gray_image);

[centers, radii] = imfindcircles(rgb, [40 50], 'ObjectPolarity', 'dark', 'Sensitivity', 0.95, 'Method', 'twostage');
[centersBright, radiiBright] = imfindcircles(rgb, [40 50], 'ObjectPolarity', 'bright', 'Sensitivity', 0.92, 'Method', 'twostage');
length(radii)

figure
imshow(rgb);
hDark = viscircles(centers, radii);
hBright = viscircles(centersBright, radiiBright, 'Color', 'b');