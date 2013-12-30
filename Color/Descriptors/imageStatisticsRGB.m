function [ stat ] = imageStatisticsRGB( im )
im = double(im)/255;
im_std_dev = std( im(:) );
im_mean  = mean( im(:) );
stat = [im_mean; im_std_dev];
end

