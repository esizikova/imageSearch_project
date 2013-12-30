function [ stat ] = imageStatisticsHSV( im )
im = double(im)/255;
im = rgb2hsv(im);
im_std_dev = std( im(:) );
im_mean  = mean( im(:) );

stat = [ im_mean, im_std_dev ];
end

