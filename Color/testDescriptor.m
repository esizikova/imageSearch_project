% Cleanup workspace
clear all;
close all;

% Add subfolders to search path
addpath([ pwd,'/Color/Descriptors/'] ); 

% Read in all images
[images, labels] = loadImages( './Dataset/' );

%global vars
descriptorName = 'statisticsRGB'; %change this to use different descriptor
nBins          = 0;
noOfDatapoints = size( images, 1 ); 
noOfCat        = distinctiveLabes ( labels );

% Create the map of function handles 
functionMap = createFunctionHandleMap();

% compute and show the distance matrix nicely
confMat = computeConfusionMatrix ( images, noOfCat, ...
    functionMap(descriptorName), nBins );
plotMatrix ( confMat, labels );
colormap gray

%--------------------------------------------------

%{ k-means clustering
[clusterInd, mostFreqEl] = kMeansClustering(images, noOfCat, ...
    functionMap(descriptorName), nBins);

% in this visualization each row is a cluster
plotKMeansClustering(images, noOfCat, clusterInd, mostFreqEl); %}




