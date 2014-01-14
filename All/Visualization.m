% clear the workspace
close all;
clear all;

% Choose what visualization you want + options
confMatrix = 0;
embedding2D = 1;
kMeans = 0;
neighborQuery = 1;

% Add subfolders to search path
addpath([ pwd,'/Descriptors'] );

% Load the images
nImages = 40;
[images, labels] = loadImages( '../gistDataset/', nImages );
noOfDatapoints = size(images,2);

% Create the map of function handles 
functionMap = createFunctionHandleMap();

%windowed descriptors
%specify the number of bins to break an image up into
%NOTE: If division is not even it will still run, but the last row/col may
%      be left out depending on rounding
rBins = 4; %num bins in row direction
cBins = 4; %num bins in column direction

%prepare bads for fftbands descriptor
bands = createBands ( 32, rBins, cBins );

% get the handles to descriptors here
f1 = functionMap ( 'UVBasisRotNorm' );
f2 = functionMap ( 'statisticsLab' );
f3 = functionMap ( 'FFTBandDescriptor' );
% f4 = functionMap ( 'FFTLocalization' );
fHandles =   {f1, f2, f3};

%prepare arguments for the functions
arguments = cell(size(fHandles,2));
arguments{1} = 1;
arguments{2} = 12;
arguments{3} = bands;

%prepare weights
weights = zeros(size(fHandles,2));
weights(1) = 4;
weights(2) = 1.5;
weights(3) = 3;

% compute descriptors for single image to get the total length
%disp(images);
descriptorLength = 0;
for i = 1:rBins
    for j = 1:cBins
        for k = 1:length(fHandles)
            fHandle = fHandles{k};
            rWidth = round(size(images{1},1)/rBins);
            cWidth = round(size(images{1},2)/cBins);
            rRange = 1+rWidth*(i-1):rWidth*i;
            cRange = 1+cWidth*(j-1):cWidth*j;
            curLength = size( fHandle (images{1}(rRange,cRange,:), arguments{k} ), 1 );
            descriptorLength = descriptorLength + curLength;
        end
    end
end;

% Compute the descriptors for each image, and store them
% prepare the pairwise distance 
descriptors = zeros( noOfDatapoints, descriptorLength ); 
for z = 1:noOfDatapoints
    fullDescriptor = [];
    for i = 1:rBins
        for j = 1:cBins
            rWidth = round(size(images{z},1)/rBins);
            cWidth = round(size(images{z},2)/cBins);
            rRange = 1+rWidth*(i-1):rWidth*i;
            cRange = 1+cWidth*(j-1):cWidth*j;
            for k = 1:length(fHandles)
                fHandle = fHandles{k};
                curDescriptor = weights(k) * fHandle ( images{z}(rRange,cRange,:), arguments{k} );
                fullDescriptor = [fullDescriptor ; curDescriptor];
            end;
        end
    end     
    descriptors( z, : ) = fullDescriptor;
end


dVec = pdist( descriptors, 'euclidean');
D = squareform(dVec);


% nearest neighbor
if(neighborQuery)
    queryImageIdx = 5;
    queryDescriptor = descriptors(queryImageIdx, :);
    
    neighborIds = nearestNeighbor ( queryImageIdx, descriptors, labels, 5 );
    k = size(neighborIds,2);
    
    subplot( 1, k + 1, 1), imshow( images{queryImageIdx} ), title('Query Image');
    for i = 1:k
        subplot(1, k+1, i + 1); imshow(images{neighborIds(i)}),...
            title(['Neighbor ' num2str(i) ] );
    end;
end;
set(gcf,'Position',[582 806 1007 166])

% Confusion matrix plotting
if ( confMatrix )
    plotMatrix( D, labels );
end;

% 2D embedding plotting
if ( embedding2D )
    [embedding,~] = cmdscale(dVec);
    max_emb = max(max(embedding));
    min_emb = min(min(embedding));
    imSize = 0.05*abs(max_emb - min_emb);
    plot2DEmbedding(embedding, images, imSize);
end;

if ( kMeans )
% K means clustering
[clusterInd, mostFreqEl] = kMeansClustering( descriptors, 8 );

% in this visualization each row is a cluster
plotKMeansClustering(images, 6, clusterInd, mostFreqEl);
end;

