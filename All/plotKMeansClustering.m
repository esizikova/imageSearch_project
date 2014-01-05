function [] = plotKMeansClustering( images, noOfCat, clusterIndices, mostFreqElement )

figure;
for i = 1 : noOfCat
    ind = find (clusterIndices == i);
    for j = 1:size( ind, 1 )
        subplot ( noOfCat, mostFreqElement, mostFreqElement * (i - 1) + j );
        imshow ( images{ ind(j) } );
    end;
end;
 set(gcf,'PaperPositionMode','auto')
 set(gcf, 'Position', [800 100 900 900])

end

