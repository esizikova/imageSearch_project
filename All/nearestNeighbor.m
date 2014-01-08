function [ neighborIds ] = nearestNeighbor( queryImageIdx, descriptors, labels, nNeighbors )
%PRECISIONRECALL Summary of this function goes here
%   Detailed explanation goes here

queryDescriptor = descriptors( queryImageIdx, : );

[neighborIds, ~] = knnsearch(descriptors, queryDescriptor, 'K', nNeighbors+1 );

neighborIds ( neighborIds == queryImageIdx ) = [];

end

