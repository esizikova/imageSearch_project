clear all;
close all;

%read in all images
[images, labels] = loadImages( '../Dataset/' );
noOfCat = 8; % for now i just use 2 categories

% confusion matrix 
distMat = zeros( noOfCat*3 );

% # histogram bins - interestingly, lower number of bins gives better (visually) clustering
bins = 12;
for i = 1 : noOfCat*3
    for j = 1 : noOfCat*3
        im1 = images{i};
        im2 = images{j};
        descriptor1 = stackedHistograms ( im1, bins );
        descriptor2 = stackedHistograms ( im2, bins );
        euclidDist = norm(descriptor1 - descriptor2);
        distMat(i,j) = euclidDist;
    end;
end;

% show the distance matrix nicely
plotMatrix ( distMat, labels );

%--------------------------------------------------
% k-means clustering
dataPts = zeros( noOfCat*3 , size( descriptor1,1 ) );
for i = 1:noOfCat*3
    im = images{i};
    dataPts(i,:) = stackedHistograms ( im, bins );
end;

[clusterIdx, ctrs] = kmeans( dataPts, noOfCat, ...
                    'Distance', 'sqEuclidean',...
                    'Replicates', 15 );

frequency = sortrows(tabulate(clusterIdx));  %# compute sorted frequency table
mostFreqElement = max( frequency(:,2) );

%each row is a cluster
figure;
for i = 1 : noOfCat
    ind = find (clusterIdx == i);
    for j = 1:size( ind, 1 )
        subplot ( noOfCat, mostFreqElement, mostFreqElement * (i - 1) + j );
        imshow ( images{ ind(j) } );
    end;
end;



