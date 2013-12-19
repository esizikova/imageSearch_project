function [ stat ] = imageStatisticsHSV( im )
im = double(im)/255;
im = rgb2hsv(im);
im_std_dev = std( im(:) );
im_mean  = mean( im(:) );
im_skew = moment(im(:), 2);
im_kurtosis = moment(im(:), 3);
stat = [im_mean, im_std_dev, im_skew, im_kurtosis ];
end

