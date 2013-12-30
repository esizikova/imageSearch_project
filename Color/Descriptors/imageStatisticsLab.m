function [ stat ] = imageStatisticsLab( im )
im = double(im)/255;
colorForm = makecform ('srgb2lab');
im = applycform ( im, colorForm );

im_std_dev = std( im(:) );
im_mean  = mean( im(:) );
stat = [im_mean; im_std_dev ];
end


