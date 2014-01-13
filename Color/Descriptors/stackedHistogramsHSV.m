function [ descriptor ] = stackedHistogramsHSV( im, bins )
if ( bins > 256 )
    bins = 256;
end;

im = double(im)/256;
im_HSV = rgb2hsv(im);

im_H = im_HSV ( :, : , 1 );
im_S = im_HSV ( :, : , 2 );
im_V = im_HSV ( :, : , 3 );

normalizer = ( size( im_HSV, 1 ) * size( im_HSV, 2 ) );
hist_H = imhist ( im_H, 4*bins ) / normalizer ;
hist_S = imhist ( im_S, bins ) / normalizer ;
hist_V = imhist ( im_V, bins ) / normalizer ;

descriptor = [ hist_H; hist_S; hist_V ]';
end


