function [ clusterIndices, mostFreqElement ] = kMeansClustering( images, noOfCat, fHandle, nBins )
%KMEANSCLUSTERING  k-means clustering on our data

if ( nBins > 0)
    descriptorExample = fHandle( images{1}, nBins );
else
    descriptorExample = fHandle( images{1} );
end;
descriptorSize    = size ( descriptorExample, 1 );
noOfDatapoints    = size(images, 1);

% prepare the descriptor space
dataPts = zeros( noOfDatapoints, descriptorSize );
for i = 1:noOfDatapoints
    if ( nBins > 0)
        dataPts (i,:) = fHandle(images{i}, nBins );
    else
        dataPts (i,:) = fHandle(images{i} );
    end;
end;

% run k-means clustering
[clusterIndices, ~] = kmeans( dataPts, noOfCat, ...
                    'Distance', 'sqEuclidean',...
                    'Replicates', 15 );

% compute sorted frequency table
frequency = sortrows( tabulate( clusterIndices ) );  
mostFreqElement = max( frequency(:,2) );

end
