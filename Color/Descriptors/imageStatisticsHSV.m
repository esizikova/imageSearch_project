function [ stat ] = imageStatisticsHSV( im )
im = double(im)/255;
im = rgb2hsv(im);

im_H = im ( :, : , 1 );
im_S = im ( :, : , 2 );
im_V = im ( :, : , 3 );

im_std_dev_H = std( im_H(:) );
im_std_dev_S = std( im_S(:) );
im_std_dev_V = std( im_V(:) );

im_mean_H  = mean( im_H(:) );
im_mean_S  = mean( im_S(:) );
im_mean_V  = mean( im_V(:) );

stat = [ im_mean_H, im_mean_S, im_mean_V,...
    im_std_dev_H, im_std_dev_S, im_std_dev_V ];
end

