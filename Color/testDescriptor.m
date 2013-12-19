clear all;
close all;

%read in all images
[images, labels] = loadImages( '../Dataset/' );
noOfCat = 8;

% confusion matrix 
distMat = zeros( noOfCat*3 );

% # histogram bins - interestingly, lower number of bins gives better (visually) clustering
bins = 3;
for i = 1 : noOfCat*3
    im1 = images{i};
    im1Stat = imageStatisticsLab(im1)';
    descriptor1 = im1Stat;
    for j = 1 : noOfCat*3
        im2 = images{j};
        im2Stat = imageStatisticsLab(im2)';
        descriptor2 = im2Stat;
        euclidDist = norm(descriptor1 - descriptor2);
        distMat(i,j) = euclidDist;
    end;
end;

% show the distance matrix nicely
plotMatrix ( distMat, labels );
colormap gray

%--------------------------------------------------
% k-means clustering
dataPts = zeros( noOfCat*3 , size( descriptor1,1 ) );
for i = 1:noOfCat*3
    im = images{i};
    imStat = imageStatisticsLab(im);
    size(imStat)
    dataPts(i,:) = imStat';
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



