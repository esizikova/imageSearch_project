function [descriptor] = RGBstackedHistograms( im, varargin )

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

im_R = im ( :, : , 1 );
im_G = im ( :, : , 2 );
im_B = im ( :, : , 3 );

normalizer = ( size( im, 1 ) * size( im, 2 ) );
hist_R = imhist ( im_R, nBins ) / normalizer ;
hist_G = imhist ( im_G, nBins ) / normalizer ;
hist_B = imhist ( im_B, nBins ) / normalizer ;

descriptor = [ hist_R; hist_B; hist_G ];

end