function [ H ] = combinedHistogramHSV( im, nBins )
% naming is hard - the idea here is instead of stacking the histograms
% we will create new bins as cominations of bins for each channel - thus
% combined histogram

im = double(im)/256;
im = rgb2hsv( im );

im_H = im ( :, :, 1);
im_S = im ( :, :, 2);
im_V = im ( :, :, 3);

normalizer = ( size( im, 1 ) * size( im, 2 ) );
hist_H = imhist ( im_H, nBins*5 ) / normalizer ;
hist_S = imhist ( im_S, nBins ) / normalizer ;
hist_V = imhist ( im_V, nBins ) / normalizer ;

H = zeros( 5 * nBins * nBins * nBins ,1 );
for v = 1:size( hist_V, 1 )
    for s = 1:size( hist_S, 1 )
        for h = 1:size( hist_H, 1 )
             ind = nBins*nBins*(v-1) + nBins*(s-1) + h;
             H( ind ) = hist_H(h) + hist_S(s) + hist_V(v);
        end;
    end;
end;

end

