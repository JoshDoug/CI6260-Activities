function DDA (x0, y0, x1, y1)

dy = y1 - y0;
dx = x1 - x0;
m = dy/dx;
py = y0;

for px=x0:x1
  plot(px, round(py), 'ro');
  py = py + m;
  hold on
end