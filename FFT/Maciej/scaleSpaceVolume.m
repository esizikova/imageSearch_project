clear all;
close all; 

[images,labels] = loadImages( '../../Dataset/', 3 );
noOfImages = size(images,2);

residuals = zeros( 1, noOfImages );

%this is the same as my localization - I just look how much energy there is
%in the low frequencies.
for j = 1:noOfImages
    I =  single(( rgb2gray(images{j}))) / 255;
    I_org = I;
    I_filt = I;
    
    H = fspecial( 'gaussian', 9, 3 );
    for i = 2:1000
        I_filt = imfilter( I_filt, H, 'replicate', 'symmetric' );
        I_residual = I_filt - I_org;
        residual = sum( I_residual(:) );
        if ( residual < -0.02 ) break; end;
     
        subplot(1,3,1) , imshow( I_org,[] ) ;
        subplot(1,3,2) , imshow( I_filt,[] ) ;
        subplot(1,3,3) , imshow( I_residual,[] );
        drawnow;
    end;
    i
    residuals(j) = residual
end;