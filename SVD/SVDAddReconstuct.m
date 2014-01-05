% clear the workspace
close all;
clear all; 

% Read in all images
[images, labels] = loadImages( '../Dataset/' );
noOfDatapoints = size ( images, 1 ); 

% compute the SVD
im = histeq( single( rgb2gray ( images{24} ) ) / 255 );
[U,S,V] = svd ( im );

im_final = zeros(256);

for s = 1:20;
    % only use single singular value to create image component
    S(s,s)
    im_r = U(:,s) * S(s,s) * V(:,s)';
    im_final = im_final + im_r;
    
    % visualize
    subplot(1,2,1)
    imshow(im_r, []);
    subplot(1,2,2)
    imshow(im_final, []);
    drawnow;
    pause(0.3)
end;

% Observation notes - above code shows that we can reconstruct an image
% component using single column from U, singe singular value and single
% column from V. Such reconstuctions can be added together to yield the 
% final image. From this we can follow and say if first singular value is
% large then we can reconstruct a large (important) component of the image 
% using just single singular value - images with large first singular
% value are less 'complex'. Question - can we use first singular value to
% measure image 'complexity' or we need some less direct metric - i.e.
% reconstuct using single singular value and then calculate SSD with
% orginal image.

%Other observations :
% Beaches and roads have similar singular values - these are basically two
% planes( groud and sky)
% trees are complex images and have small singular value
% houses are on the low spectrum of things
% Mountain was very hard to do for our reconstuction - very small first
% singular value

%-------------------------------------------------
% Using values directly does not seem like such a great idea (open country
% + forest) -  might look at SSD and/or first singular value + statistics
% of first 20. Or - normalize the singular value given first 20. Possibly
% look at the case with equalized histograms