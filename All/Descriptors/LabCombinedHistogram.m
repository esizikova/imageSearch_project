function [ H ] = LabCombinedHistogram( im, varargin )
% naming is hard - the idea here is instead of stacking the histograms
% we will create new bins as cominations of bins for each channel - thus
% combined histogram

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

% im_L = im_Lab ( :, :, 1);
im_a = im_Lab ( :, :, 2);
im_b = im_Lab ( :, :, 3);

normalizer = ( size( im, 1 ) * size( im, 2 ) );
% hist_L = imhist ( im_L, nBins ) / normalizer ;
hist_a = imhist ( im_a, nBins ) / normalizer ;
hist_b = imhist ( im_b, nBins ) / normalizer ;

% H = zeros( nBins * nBins * nBins ,1 );
% for v = 1:size( hist_b, 1 )
%     for s = 1:size( hist_a, 1 )
%         for h = 1:size( hist_L, 1 )
%              ind = nBins*nBins*(v-1) + nBins*(s-1) + h;
%              H( ind ) = hist_L(h) + hist_a(s) + hist_b(v);
%         end;
%     end;
% end;

H = zeros( nBins * nBins ,1 );
for v = 1:size( hist_b, 1 )
    for s = 1:size( hist_a, 1 )
        ind =  nBins*(v-1) + s;
        H( ind ) = hist_a(s) + hist_b(v);
    end;
end;

end

