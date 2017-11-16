% Week 7 - Shuttle

load('shuttle.mat');		% file on Canvas
handle = patch ( 'Vertices', node_xyz', 'Faces', face_node' );
set ( handle, 'FaceColor',[0.5, 0.6, 0.8], 'EdgeColor', 'Black' );
axis equal;
grid on;