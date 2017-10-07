function drawWindowFrames( x, y, w, h )
%drawWindowFrames Plot a Window with frame crossection
%   Detailed explanation goes here

midx = x + (w/2);
midy = y + (h/2);
yh = y + h;
xw = x + w;
rectangleJDS(x,y,w,h)
line([x xw], [midy midy])
line([midx midx], [y yh])

end

