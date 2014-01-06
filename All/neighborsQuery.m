% Given an image and database of images computes the 
% neighbors wich are closer than distThreshold. Also computes
% prcision and recall

clear all;
close all;

%read in all images
[images, labels] = loadImages( '../Dataset/' );
noOfCat = 8;

queryIdx = 1;
queryIm = images{ queryIdx };

% compute confusion matrix 
distMat = zeros( noOfCat*3 );
bins = 3;
for i = 1 : noOfCat*3
    im1 = images{i};
    im1Stat = imageStatisticsHSV(im1)';
    descriptor1 = im1Stat;
    for j = 1 : noOfCat*3
        im2 = images{j};
        im2Stat = imageStatisticsHSV(im2)';
        descriptor2 = im2Stat;
        euclidDist = norm(descriptor1 - descriptor2);
        distMat(i,j) = euclidDist;
    end;
end;

distanceThresholds = 0.05:0.1:1.00;
precision = zeros( 1, size( distanceThresholds,2 ) );
recall = zeros( 1, size( distanceThresholds,2 ) );
for j = 1:10
    distances = distMat ( 1, : );
    neighborIds = find ( distances < distanceThresholds(j) );
    neighborIds( neighborIds == queryIdx ) = [];
    
    % precision - fraction of retrieved instances that are relevant
    % recall    - fraction of relevant instances that are retrieved
    queryLabel = labels{queryIdx}
    sameLabels = 0;
    for i= 1:size( neighborIds, 2 )
        curLabel = labels{i};
        if ( strcmp(queryLabel, curLabel) )
            sameLabels = sameLabels + 1;
        end
    end;
    precision(j) = sameLabels / size( neighborIds, 2 );
    recall(j)    = sameLabels / 3; % # examples in each category
end;
plot( recall, precision, 'ro-');
 








