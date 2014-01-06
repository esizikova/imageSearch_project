% Cleanup workspace
clear all;
close all;

% Add subfolders to search path
addpath('/home/lena/Documents/CS_Projects/imageSearch_project/trunk/Color/Descriptors/'); 

% Read in all images
[images, labels] = loadImages('/home/lena/Documents/CS_Projects/imageSearch_project/trunk/Dataset/');

%global vars
%descriptorName = 'statisticsRGB'; %change this to use different descriptor
nBins          = 0;
noOfDatapoints = size( images, 1 ); 
noOfCat        = distinctiveLabes ( labels );

% Create the map of function handles 
%functionMap = createFunctionHandleMap();

fHandle = @computeBoundedFFT;
% compute and show the distance matrix nicely
confMat = computeConfusionMatrix ( images, noOfCat, ...
    fHandle, 0 );
plotMatrix ( confMat, labels );
colormap gray

%--------------------------------------------------

if 0,
    % k-means clustering
    [clusterInd, mostFreqEl] = kMeansClustering(images, noOfCat, ...
        fHandle, 0);

    % in this visualization each row is a cluster
    plotKMeansClustering(images, noOfCat, clusterInd, mostFreqEl); %
end




