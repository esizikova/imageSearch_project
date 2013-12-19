function [ stat ] = imageStatisticsRGB( im )
im = double(im)/255;
im_std_dev = std( im(:) );
im_mean  = mean( im(:) );
im_skew = moment(im(:), 2);
im_kurtosis = moment(im(:), 3);
stat = [im_mean, im_std_dev, im_skew, im_kurtosis ];
end

