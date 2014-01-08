function [ bands ] = createBands( noOfBands )

% prepare bands
bandSizes = uint8(linspace(10, 200, noOfBands))/2;
bands = zeros( 256, 256, noOfBands );
for i = 1:noOfBands
    halfSize = bandSizes(i);
    se3 = strel('disk',double(halfSize), 8);
    bandShape = se3.getnhood();
    extends = 129 - halfSize:127 + halfSize;
    bands(extends, extends, i) = bandShape;
end;

%make sure bands do no overlap
for i = noOfBands:-1:2
    bands(:,:,i) = bands(:,:,i) - bands(:,:,i-1);
end;
end

