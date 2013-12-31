function [ stat ] = imageStatisticsLab( im )
im = double(im)/255;
colorForm = makecform ('srgb2lab');
im = applycform ( im, colorForm );

im_L = im ( :, : , 1 );
im_a = im ( :, : , 2 );
im_b = im ( :, : , 3 );

im_std_dev_L = std( im_L(:) );
im_std_dev_a = std( im_a(:) );
im_std_dev_b = std( im_b(:) );

im_mean_L  = mean( im_L(:) );
im_mean_a  = mean( im_a(:) );
im_mean_b  = mean( im_b(:) );

stat = [ im_mean_L, im_mean_a, im_mean_b,...
    im_std_dev_L, im_std_dev_a, im_std_dev_b ];
end


