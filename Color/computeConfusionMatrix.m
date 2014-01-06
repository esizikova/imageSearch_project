function [ confMat ] = computeConfusionMatrix( images, noOfCat, fHandle, nBins )

confMat = zeros( size( images, 1 ) );

for i = 1 : noOfCat*3
    im1 = images{i};
    if ( nBins > 0 )
        descriptorA = fHandle ( im1, nBins );
    else
        descriptorA = fHandle ( im1 );
    end;
    for j = 1 : noOfCat*3
        im2 = images{j};
        if (  nBins > 0 )
            descriptorB = fHandle ( im2, nBins );
        else
            descriptorB = fHandle ( im2 );
        end;
        euclidDist = norm ( descriptorA - descriptorB );
        confMat(i,j) = euclidDist;
    end;
end;


end

