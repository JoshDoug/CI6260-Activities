load('object3d.mat');

% Detect first plane, the table, and extract it from point cloud
maxDistance = 0.02; % Set max point-to-plane for plane fitting (0.02 = 2cm)
referenceVector = [0,0,1]; % Set normal vector of the plane
maxAngularDistance = 5; % Set max angular distance to 5 degrees

[planeModel1, ~, outlierIndices] = pcfitplane(ptCloud, maxDistance,...
    referenceVector, maxAngularDistance);
remainPtCloud = select(ptCloud, outlierIndices);

% Set the region of interest to constrain the search for the second plane, left wall
% ROI = [xmin, xmax, ymin, ymax, zmin, zmax];
roi = [-inf, inf; 0.4, inf; -inf, inf]; % ROI = Region of Interest
sampleIndices = findPointsInROI(remainPtCloud, roi);

% Detect the left wall and extract it from the remaining point cloud
[planeModel2, ~, outlierIndices] = pcfitplane(remainPtCloud,...
    maxDistance, 'SampleIndices', sampleIndices);
remainPtCloud = select(remainPtCloud, outlierIndices);

%
% Detect back plane/right wall
%
% Set the region of interest to constrain the serach for the back right wall
maxDistance = 0.02; % Set max point-to-plane for plane fitting (0.02 = 2cm)
roi = [0.9, 1.1; -0.1, 0.45; -inf, inf]; % ROI = Region of Interest
sampleIndices = findPointsInROI(remainPtCloud, roi);

% Detect the back wall and extract it from the remaining point cloud
[planeModel3, ~, outlierIndices] = pcfitplane(remainPtCloud,...
    maxDistance, 'SampleIndices', sampleIndices);
remainPtCloud = select(remainPtCloud, outlierIndices);

%
% Detect Cylinder
%
maxDistance = 0.005; % Reset max distance to 5mm
roi = [0.4,0.6,-inf,0.2,0.1,inf]; % Set region of interest to constrain search
sampleIndices = findPointsInROI(remainPtCloud, roi);
% referenceVector = [0,0,1]; % Already set above

% Detect cylinder and extract it from the point cloud by specifying the inlier points
[cylinderModel, ~, outlierIndices] = pcfitcylinder(remainPtCloud, maxDistance,...
    referenceVector, 'SampleIndices', sampleIndices);
remainPtCloud = select(remainPtCloud, outlierIndices);

%
% Detect Sphere
%
maxDistance = 0.01; % Set to 1cm
roi = [-inf, 0.5, 0.2, 0.4, 0.1, inf]; % Set ROI
sampleIndices = findPointsInROI(remainPtCloud, roi);

% Detect sphere (globe) and extract from point cloud
[sphereModel, inlierIndices, outlierIndices] = pcfitsphere(remainPtCloud, maxDistance,...
    'SampleIndices', sampleIndices);
globe = select(remainPtCloud, inlierIndices);
remainPtCloud = select(remainPtCloud, outlierIndices); % Cut away at point cloud

%
% Detect Phone
%
maxDistance = 0.02;
roi = [0.6,0.85,0.15,0.38,0.05,0.2]; % What should ROI be?
sampleIndices = findPointsInROI(remainPtCloud, roi);
[phoneModel, inlierIndices, outlierIndices] = pcfitplane(remainPtCloud, maxDistance,...
    'SampleIndices', sampleIndices);
phone = select(remainPtCloud, inlierIndices);
remainPtCloud = select(remainPtCloud, outlierIndices);

% Overlay models on point cloud
figure(1)
pcshow(ptCloud);
hold on
plot(planeModel1);
plot(planeModel2);
plot(planeModel3);
plot(cylinderModel);
plot(sphereModel);
plot(phoneModel);

% Plot models without point cloud
figure(2)
axis([0.2 1.2 -0.1 0.6 0 0.6]);
hold on
plot(planeModel1);
plot(planeModel2);
plot(planeModel3);
plot(cylinderModel);
plot(sphereModel);
plot(phoneModel); % Phone plot is larger than the specified ROI

% Plot phone point cloud
figure(3)
pcshow(phone); % But phone point cloud is detected
