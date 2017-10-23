% Testing Transforms

a = [1 2; 3 6];

line(a(:,1), a(:,2));

b = [0.5 0; 0 0.5];

c = a * b;

line(c(:,1), c(:,2));

axis([0 5 0 5])
