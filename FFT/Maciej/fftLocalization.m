clear all;
close all; 

[images,labels] = loadImages( '../../Dataset/', 3 );

noOfImages = size ( images, 2 )
for i = 1:noOfImages
    
    im = rgb2gray(images{i}); 
    im_fft = fft2(im);
    im_amplitude = log( fftshift( abs( im_fft ) ) );
    
    imshow(im_amplitude,[]);drawnow;
    pause(0.3)
    
    phi = sum( im_amplitude(:) );
    mu = mean ( im_amplitude(:) );
    sigma = std( im_amplitude(:) );
    disp( [labels{i} ' - Mean : ' num2str(mu) ' ; Std dev ',...
        num2str(sigma) ' ; Total ' num2str(phi) ] );
end;