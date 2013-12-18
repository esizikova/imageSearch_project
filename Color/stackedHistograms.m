function [descriptor] = stacked_histograms( im, bins )

if ( bins > 256 )
    bins = 256;
end;

im_R = im ( :, : , 1 );
im_G = im ( :, : , 2 );
im_B = im ( :, : , 3 );

normalizer = ( size( im, 1 ) * size( im, 2 ) );
hist_R = imhist ( im_R, bins ) / normalizer ;
hist_G = imhist ( im_G, bins ) / normalizer ;
hist_B = imhist ( im_B, bins ) / normalizer ;

descriptor = [ hist_R; hist_B; hist_G ];
end