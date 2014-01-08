% clear the workspace
close all;
clear all;

% Choose what visualization you want + options
confMatrix = 0;
embedding2D = 1;
kMeans = 0;

% Add subfolders to search path
addpath([ pwd,'/Descriptors'] );

% Load the images
nImages = 10;
[images, labels] = loadImages( '../gistDataset/', 10 );
noOfDatapoints = size(images,2);

% Create the map of function handles 
functionMap = createFunctionHandleMap();

%prepare bads for fftbands descriptor
bands = createBands(128);


% get the handles to descriptors here
f1 = functionMap ( 'FFTBandDescriptor' );
f2 = functionMap ( 'statisticsHSV' );
f3 = functionMap ( 'FFTLocalization' );
fHandles = {f1, f2, f3};

%prepare arguments for the functions
arguments = cell(size(fHandles,2));
arguments{1} = bands;
arguments{2} = 128;

%prepare weights
weights = zeros(size(fHandles,2));
weights(1) = 0;
weights(2) = 10;
weights(3) = 0;

% compute descriptors for single image to get the total length
%disp(images);
descriptorLength = 0;
for i = 1:length(fHandles)
    fHandle = fHandles{i};
    curLength = size( fHandle (images{1}, arguments{i} ), 1 );
    descriptorLength = descriptorLength + curLength;
end;


% Compute the descriptors for each image, and store them
% prepare the pairwise distance 
descriptors = zeros( noOfDatapoints, descriptorLength ); 
for i = 1:noOfDatapoints
    fullDescriptor = [];
    for j = 1:length(fHandles)
        fHandle = fHandles{j};
        curDescriptor = weights(j) * fHandle ( images{i}, arguments{j} );
        fullDescriptor = [fullDescriptor ; curDescriptor];
    end;
    descriptors( i, : ) = fullDescriptor;
end


dVec = pdist( descriptors, 'euclidean');
D = squareform(dVec);

% nearest neighbor
queryImageIdx = 32;
queryDescriptor = descriptors(queryImageIdx, :);

neighborIds = nearestNeighbor ( queryImageIdx, descriptors, labels, 5 );
k = size(neighborIds,2);

subplot( 1, k + 1, 1), imshow( images{queryImageIdx} ), title('Query Image');
for i = 1:k
    subplot(1, k+1, i + 1); imshow(images{neighborIds(i)}),...
        title(['Neighbor ' num2str(i) ] );
end;

% Confusion matrix plotting
if ( confMatrix )
    plotMatrix( D, labels );
end;

% 2D embedding plotting
if ( embedding2D ) 
    [embedding,~] = cmdscale(dVec);
    max_emb = max(max(embedding));
    min_emb = min(min(embedding));
    imSize = 0.1*abs(max_emb - min_emb);
    plot2DEmbedding(embedding, images, imSize);
end;

if ( kMeans )
% K means clustering
[clusterInd, mostFreqEl] = kMeansClustering( descriptors, 8 );

% in this visualization each row is a cluster
plotKMeansClustering(images, 8, clusterInd, mostFreqEl);
end;

