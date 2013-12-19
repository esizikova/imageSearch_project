function [H] = combinedHistogramRGB ( im, nBins )
% naming is hard - the idea here is instead of stacking the histograms
% we will create new bins as cominations of bins for each channel - thus
% combined histogram

im = double(im)/256;

im_R = im ( :, :, 1);
im_G = im ( :, :, 2);
im_B = im ( :, :, 3);

normalizer = ( size( im, 1 ) * size( im, 2 ) );
hist_R = imhist ( im_R, nBins ) / normalizer ;
hist_G = imhist ( im_G, nBins ) / normalizer ;
hist_B = imhist ( im_B, nBins ) / normalizer ;

H = zeros( nBins*nBins*nBins ,1 );
for b = 1:size( hist_B, 1 )
    for g = 1:size( hist_G, 1 )
        for r = 1:size( hist_R, 1 )
             ind = nBins*nBins*(b-1) + nBins*(g-1) + r;
             H( ind ) = hist_R(r) + hist_G(g) + hist_B(b);
        end;
    end;
end;


end

