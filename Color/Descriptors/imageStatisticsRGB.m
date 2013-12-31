function [ stat ] = imageStatisticsRGB( im )
im = double(im)/255;

im_R = im ( :, : , 1 );
im_G = im ( :, : , 2 );
im_B = im ( :, : , 3 );

im_std_dev_R = std( im_R(:) );
im_std_dev_G = std( im_G(:) );
im_std_dev_B = std( im_B(:) );

im_mean_R  = mean( im_R(:) );
im_mean_G  = mean( im_G(:) );
im_mean_B  = mean( im_B(:) );

stat = [ im_mean_R, im_mean_G, im_mean_B,...
    im_std_dev_R, im_std_dev_G, im_std_dev_B ];
end

