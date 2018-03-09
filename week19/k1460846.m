% K1460846, Joshua Stringfellow
% Week 19, Lab 9 - Hough Transform Lab

% Task 1 - Apply Hough Transform to building.png and detect principal edges
% in the image

img = imread('building.jpg');
edges = edge(img, 'canny');
[H, theta, rho] = hough(edges);

peaks = houghpeaks(H, 5, 'Threshold', ceil(0.5*max(H(:))));
lines = houghlines(edges, theta, rho, peaks);

figure(1)
imshow(img);
hold on

for i=1:length(lines)
    xy = [lines(i).point1; lines(i).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'blue');
    plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'green');
    plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
end

% Task 2 - Determine a set of parameters to optimise the detection of the
% principal edges in the image

%peaks = houghpeaks(H, 5, 'Threshold', ceil(0.5*max(H(:))), 'NHoodSize', [5  5]);
%[H2, theta2, rho2] = hough(edges, 'RhoResolution', 1, 'Theta', 1);
[H2, theta2, rho2] = hough(edges, 'RhoResolution', 0.9, 'Theta', -90:89);
peaks2 = houghpeaks(H2, 5, 'Threshold', ceil(0.5*max(H2(:))));
lines2 = houghlines(edges, theta2, rho2, peaks2);

[H3, theta3, rho3] = hough(edges, 'RhoResolution', 0.9, 'Theta', -45:45);
peaks3 = houghpeaks(H3, 5, 'Threshold', ceil(0.5*max(H3(:))));
lines3 = houghlines(edges, theta3, rho3, peaks3);

figure(2)
imshow(img);
hold on

for i=1:length(lines2)
    xy = [lines2(i).point1; lines2(i).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'blue');
    plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'green');
    plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
end

for i=1:length(lines3)
    xy = [lines3(i).point1; lines3(i).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'blue');
    plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'green');
    plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
end


% Task 3 - Justify choice of detection parameters

% Tweaking most of the parameters didn't help to improve the line detection
% overall, but adjusting the Theta value helped to detect lines at
% different angles, so simply rerun the line detection process and layered
% over the extra lines that were detected with the adjusted Theta value.

% The RhoResolution default of 1 already seems to work well for the image,
% raising it much starts making the line detection very innefecitve long
% before reaching norm(size(imgBW)) where image here is 'edges'.