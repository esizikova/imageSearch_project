function [ stat ] = HSVimageStatistics( im, varargin )
im = double(im)/255;
im = rgb2hsv(im);

im_H = im ( :, : , 1 );
im_S = im ( :, : , 2 );
im_V = im ( :, : , 3 );


im_mean_H  = mean( im_H(:) );
im_mean_S  = mean( im_S(:) );
% im_mean_V  = mean( im_V(:) );

stat = [ im_mean_H, im_mean_S ]';
end

