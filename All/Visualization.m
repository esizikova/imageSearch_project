% clear the workspace
close all;
clear all;

% Choose what visualization you want + options
confMatrix = 1;
embedding2D = 1;
kMeans = 1;
imSize = 5.1; % if images in the 2d embedding are to small, increase this

% Add subfolders to search path
addpath([ pwd,'/Descriptors'] );

% Load the images
[images, labels] = loadImages( '../gistDataset/', 5 );
noOfDatapoints = size(images,2);

% Create the map of function handles 
functionMap = createFunctionHandleMap();

% get the handles to descriptors here
%f1 = functionMap ( 'singularValues' );
%f2 = functionMap ( 'statisticsLab' );
%fHandles = { f1, f2 };
f1 = functionMap ( 'WindowFFT' );
fHandles = { f1};

% compute descriptors for single image to get the total length
descriptorLength = 0;
for i = 1:length(fHandles)
    fHandle = fHandles{i};
    curLength = size( fHandle (images{1} ), 1 );
    descriptorLength = descriptorLength + curLength;
end;

% Compute the descriptors for each image, and store them
% prepare the pairwise distance 
tic
descriptors = zeros( noOfDatapoints, descriptorLength ); 
for i = 1:noOfDatapoints
    fullDescriptor = [];
    for j = 1:length(fHandles)
        fHandle = fHandles{j};
        curDescriptor = fHandle ( images{i} );
        fullDescriptor = [fullDescriptor ; curDescriptor];
    end;
    descriptors( i, : ) = fullDescriptor;
end
toc;

dVec = pdist( descriptors, 'euclidean');
D = squareform(dVec);

% Confusion matrix plotting
if ( confMatrix )
    plotMatrix(D,labels);
end;

% 2D embedding plotting
if ( embedding2D ) 
    [embedding,~] = cmdscale(dVec);
    plot2DEmbedding(embedding, images, imSize);
end;

if ( kMeans )
% K means clustering
[clusterInd, mostFreqEl] = kMeansClustering( descriptors, 8 );

% in this visualization each row is a cluster
plotKMeansClustering(images, 8, clusterInd, mostFreqEl);
end;

