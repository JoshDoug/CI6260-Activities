function [ xy ] = polygram( cx, cy, r, n )
%POLYGRAM Returns coordinates for an n-pointed star
%   Works out coordinates for circle but halves r for every other
%   coordinate

outer = circleJDS(cx, cy, r, n);
inner = circleJDS(cx, cy, r/2, n*2);
inner(:, 1:2:end) = outer;
xy = inner;

end

