clear all;
close all; 

[images,labels] = loadImages( '../../Dataset/', 3 );

noOfImages = size ( images, 2 )
% here we try to answer a question how much of the energy is in the low
% frequencies - images with a lot of periodicity will have less localized
% power spectra - which means that less energy will be in the low
% frequencies, after normalization.

%Prepare filter
filter = zeros(256);
halfSize = 8; % how big should this be?
extends = [129 - halfSize:128 + halfSize];
filter(extends, extends) = ones(2*halfSize);
figure; imshow(filter);

k = zeros ( 1, noOfImages ); 
v = zeros ( 1, noOfImages );

for i = 1:noOfImages
    
    im = rgb2gray(images{i}); 
    im_fft = fft2(im);
    power_spectra = fftshift( abs( im_fft ) ) ;
    
    power_spectra    = power_spectra / sum( power_spectra(:) );
    low_frequencies  = filter .* power_spectra;
    high_frequencies = imcomplement(filter) .* power_spectra;
       
    energy_low_frequencies  = sum( low_frequencies(:) );
    k(i) = energy_low_frequencies;  
    v(i) = i;
    
%     subplot(1,3,1); imshow( log(power_spectra), [] ); 
%     subplot(1,3,2); imshow( log(low_frequencies), []);
%     subplot(1,3,3); imshow( log(high_frequencies), []);
%     drawnow;

    disp( [labels{i} ' - Low Freq. Energy : ',...
        num2str(energy_low_frequencies ) ] );
end;

imageMap = containers.Map(k, v);

indices =  cell2mat(values(imageMap));
figure;
for i = 1:size( keys(imageMap), 2 )
    im = images{indices(i)}; 
    subplot(3,8,i), imshow(im);
end;
