function rectangleJDS(x, y, w, h)
%rectangleTest Draw a rectanble
%   Draw a rectangle using x, y, width, and height parameters

yh = y + h;
xw = x + w;
line([x x xw xw x], [y yh yh y y])

end

