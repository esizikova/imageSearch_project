function [ stat ] = imageStatisticsLab( im )
im = double(im)/255;
colorForm = makecform ('srgb2lab');
im = applycform ( im, colorForm );

im_std_dev = std( im(:) );
im_mean  = mean( im(:) );
im_skew = moment(im(:), 2);
im_kurtosis = moment(im(:), 3);
stat = [im_mean, im_std_dev, im_skew, im_kurtosis ];
end


