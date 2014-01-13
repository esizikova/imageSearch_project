function [descriptor] = stackedHistogramsLab( im, bins )

if ( bins > 256 )
    bins = 256;
end;

im = double(im)/256;
colorForm = makecform ('srgb2lab');
im_Lab = applycform ( im, colorForm );

im_L = im_Lab ( :, : , 1 );
im_a = im_Lab ( :, : , 2 );
im_b = im_Lab ( :, : , 3 );

normalizer = ( size( im_Lab, 1 ) * size( im_Lab, 2 ) );
hist_L = imhist ( im_L, 1*bins ) / normalizer ;
hist_a = imhist ( im_a, 2*bins ) / normalizer ;
hist_b = imhist ( im_b, 2*bins ) / normalizer ;

descriptor = [ hist_L; hist_a; hist_b ]';
end