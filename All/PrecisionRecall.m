function [ neighborIds ] = PrecisionRecall( queryImageIdx, descriptors, labels, nExamples )
%PRECISIONRECALL Summary of this function goes here
%   Detailed explanation goes here
% precision - fraction of retrieved instances that are relevant
% recall    - fraction of relevant instances that are retrieved

queryDescriptor = descriptors( queryImageIdx, : );
queryLabel = labels{queryImageIdx};

neighborsNo = 2 : nExamples;

precision = zeros( 1, size( neighborsNo, 2 ) );
recall    = zeros( 1, size( neighborsNo, 2 ) );

for j = 1:size( neighborsNo, 2 )
    [neighborIds, ~] = knnsearch(descriptors, queryDescriptor, 'K', neighborsNo(j) + 1 );
    neighborIds( neighborIds == queryImageIdx ) = [];
        
    sameLabels = 0;
    for i= 1:size( neighborIds, 2 )
        curLabel = labels{ neighborIds(i) };
        if ( strcmp(queryLabel, curLabel) )
            sameLabels = sameLabels + 1;
        end
    end;

    precision(j) = sameLabels / size( neighborIds, 2 );
    recall(j)    = sameLabels / j; % # examples in each category
end;

% plot( recall, precision', 'ro-');

%just for theoutput
[neighborIds, ~] = knnsearch(descriptors, queryDescriptor, 'K', nExamples/2 + 1 );
neighborIds( neighborIds == queryImageIdx ) = [];
end

