% Colour-Based Segmentation Using K-Means Clustering
% Tutorial: https://uk.mathworks.com/help/images/examples/color-based-segmentation-using-k-means-clustering.html

he = imread('hestain.png');
figure(1), imshow(he), title('H&E image');

lab_he = rgb2lab(he); % Convert image to Lab color space

% Classify the colours in 'a*b*'
ab = lab_he(:,:,2:3);
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab, nrows*ncols, 2);
nColors = 3;

% Repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqEuclidean', 'Replicates', 3);

% Label every pixel using Kmeans results
pixel_labels = reshape(cluster_idx, nrows, ncols);
figure(2), imshow(pixel_labels, []), title('image labeled by cluster index');

% Create images that segment the H&E image by colour
segment_images = cell(1,3);
rgb_label = repmat(pixel_labels, [1 1 3]);

for k=1:nColors
    colour = he;
    colour(rgb_label ~= k) = 0;
    segmented_images{k} = colour;
end

figure(3), imshow(segmented_images{1}), title('objects in cluster 1');

