function [ clusterIndices, mostFreqElement ] = kMeansClustering( descriptors, noOfCat )
%KMEANSCLUSTERING  k-means clustering on our data

% run k-means clustering
[clusterIndices, ~] = kmeans( descriptors, noOfCat, ...
                    'Distance', 'sqEuclidean',...
                    'Replicates', 15 );

% compute sorted frequency table
frequency = sortrows( tabulate( clusterIndices ) );  
mostFreqElement = max( frequency(:,2) );

end

