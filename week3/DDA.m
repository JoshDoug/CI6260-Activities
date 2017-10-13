function DDA( x0, y0, x1, y1 )
%DDA Finds optimum raster locations to represent a line

dy = y1 - y0;
dx = x1 - x0;
m = dy/dx;
py = y0;
px = x0;

if (abs(m) < 1) % Plot points where slope is less than 1
    for px=x0:x1
        plot(px, round(py), 'ro');
        py = py + m;
        hold on
    end
elseif (abs(m) > 1) % Plot points where slope is greater than 1
    for py=y0:y1
        plot(round(px), py, 'ro');
        px = px + 1/m;
        hold on
    end
end

end