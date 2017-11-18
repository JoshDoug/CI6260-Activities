% Basic Plots

figure(1)
x = 0:pi/100:2*pi;
y = sin(x);
plot(x, y)

hold on

y2 = cos(x);
plot(x, y2, ':')

y3 = tan(x);
plot(x, y3, '--')

legend('sin', 'cos', 'tan')

axis([0 7 -2 2])

figure(2)

t = 0:pi/10:2*pi;
[X,Y,Z] = cylinder(4*cos(t));
subplot(2,2,1); surf(X); title('X');
subplot(2,2,2); mesh(Y); title('Y');
subplot(2,2,3); mesh(Z); title('Z');
subplot(2,2,4); mesh(X,Y,Z); title('X,Y,Z');
