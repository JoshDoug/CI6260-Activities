function Bresenham( x0, y0, x1, y1 )
%Bresenham's Algorithm - Finds optimum raster locations to represent a line

dx = x1 - x0; %	assumes	dx ? 0 (line	is	not	vertical)
dy = y1 - y0;
D = 2 * dy - dx;
Dr = 2 * dx - dy; % D for slopes greater than 1, r for reverse
y = y0;
x = x0;

plot(x0, y0, 'ro')
hold on

if(dy <= dx) % Plot points where slop is less than 1
    for x=x0:x1
       plot(x, y, 'ro');
       if (D >= 0)
           y = y + 1;
           D = D - 2 * dx;
       end
       D = D + 2 * dy;
    end
elseif (dy > dx) % Plot points where slope is greater than 1
    for y=y0:y1
       plot(x, y, 'ro');
       if (Dr >= 0)
           x = x + 1;
           Dr = Dr - 2 * dy;
       end
       Dr = Dr + 2 * dx;
    end
end
    
end