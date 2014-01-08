clear all;
close all; 

[images,labels] = loadImages( '../../Dataset/', 3 );

noOfImages = size ( images, 2 )
% In phase image each pixel value is some theta, from Euler formula
% let's try to get the average orientation of the image.

k = zeros ( 1, noOfImages ); 
v = zeros ( 1, noOfImages );

%Prepare filter
filter = zeros(256);
halfSize = 18; % how big should this be?
extends = [129 - halfSize:128 + halfSize];
filter(extends, extends) = ones(2*halfSize);

for i = 1:noOfImages
    
    im = rgb2gray(images{i}); 
    im_fft = fft2(im);
    phase_spectra = fftshift( angle( im_fft ) ) ;
    low_frequencies_phase  = filter .* phase_spectra;
    imshow(phase_spectra,[]), pause(.3);
    mean_angle = mean( low_frequencies_phase(:) );
    k(i) = mean_angle;  
    v(i) = i;

    disp( [labels{i} ' - Mean Angle : ',...
        num2str( mean_angle ) ] );
end;

imageMap = containers.Map(k, v);

indices =  cell2mat(values(imageMap));
figure;
for i = 1:size( keys(imageMap), 2 )
    im = images{indices(i)}; 
    subplot(3,8,i), imshow(im);
end;