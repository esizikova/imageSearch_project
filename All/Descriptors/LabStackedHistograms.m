function [descriptor] = LabStackedHistograms( im, varargin )

if ( nargin > 2)
    disp('Invalid no. of arguments! ');
    return;
end;

nBins = 3;

if ( nargin == 2 )
    nBins = varargin{1};
end;

if ( nBins > 256 )
    nBins = 256;
end;

im = double(im)/256;
colorForm = makecform ('srgb2lab');
im_Lab = applycform ( im, colorForm );

im_L = im_Lab ( :, : , 1 );
im_a = im_Lab ( :, : , 2 );
im_b = im_Lab ( :, : , 3 );

normalizer = ( size( im_Lab, 1 ) * size( im_Lab, 2 ) );
hist_L = imhist ( im_L, nBins ) / normalizer ;
hist_a = imhist ( im_a, nBins ) / normalizer ;
hist_b = imhist ( im_b, nBins ) / normalizer ;

descriptor = [ hist_L; hist_a; hist_b ];
end