% K1460846, Joshua Stringfellow
% Lab 13, Week 23 - Pattern Recognition B

shapes = imread('shapes1.jpg');
shapes = imresize(shapes, 0.25);
figure(1), imshow(shapes);

lab_shapes = rgb2lab(shapes); % Convert image to Lab color space
ab = lab_shapes(:,:,2:3);

% L*a*b* appears to work much better than HSV
% hsv_shapes = rgb2hsv(shapes);
% ab = hsv_shapes(:,:,2:3);
nrows = size(ab, 1);
ncols = size(ab, 2);
ab = reshape(ab, nrows*ncols, 2);

nColors = 9;
% Repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqEuclidean', 'Replicates', 3);

% Label every pixel using Kmeans results
pixel_labels = reshape(cluster_idx, nrows, ncols);
figure(2), imshow(pixel_labels, []), title('image labeled by cluster index');

% Create images that segment the H&E image by colour
segment_images = cell(1,3);
rgb_label = repmat(pixel_labels, [1 1 3]);

for k=1:nColors
    colour = shapes;
    colour(rgb_label ~= k) = 0;
    segmented_images{k} = colour;
end

for i=1:nColors
    j = i + 2;
    figure(j), imshow(segmented_images{i}), title(strcat('Objects in cluster ', int2str(j)));
end