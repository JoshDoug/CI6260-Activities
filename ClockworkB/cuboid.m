function [ x, y, z ] = cuboid( width, height, depth )
%CUBOID Returns coordinates for a cube
%   Width = x axis, Height = y axis, Depth = z axis
%   Uses inputs to generate a cube centered at x=0

% Create base coordinates
basex = [0 width; 0 width];
basey = [0 0; height height];
basez = [0 0; 0 0];

% Create middle faces coordinates
midx = [0 width width 0 0; 0 width width 0 0];
midy = [0 0 height height 0; 0 0 height height 0];
midz = [0 0 0 0 0; depth depth depth depth depth];

% Create top coordinates
topx = [0 0; width width];
topy = [0 height; 0 height];
topz = [depth depth; depth depth];

% Combine top, middle, and base coordinates
x = [basex midx topx];
x = x - (width/2); % Center at x=0
y = [basey midy topy];
z = [basez midz topz];

end