function [ bands ] = createBands( noOfBands, rBins, cBins )

% prepare bands
width  = 256 / cBins;
height = 256 / rBins;
bandSizes = uint8(linspace(5, min(width,height) - 10, noOfBands)) / 2;
bands = zeros( width, height, noOfBands );
for i = 1:noOfBands
    halfSize = bandSizes(i);
    se3 = strel('disk',double(halfSize), 8);
    bandShape = se3.getnhood();
    extends = (width / 2 + 1) - halfSize:(height / 2 - 1) + halfSize;
    bands(extends, extends, i) = bandShape;
end;

band_im = zeros ( width, height );
for i = 1:noOfBands
    band_im = band_im + bands(:,:,i);
end;
band_im = band_im / noOfBands;
% imshow ( band_im,[] );

%make sure bands do no overlap
for i = noOfBands:-1:2
    bands(:,:,i) = bands(:,:,i) - bands(:,:,i-1);
end;
end

