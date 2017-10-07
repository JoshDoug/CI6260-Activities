figure(1)

% t = linspace(0, 2*pi, 20);
% x = cos(t);
% y = sin(t);

% line(x * 2, y * 2)

circleCo = circleJDS(5,5,2,50);
line(circleCo(1,:), circleCo(2,:)) % plot outer circle

hold on
pentagram = polygram(5,5,2,10);
fill(pentagram(1,:), pentagram(2,:), 'r') % plot n-pointed star

hold on
labelJDS(pentagram) % label n-pointed star

title('Pentagram')