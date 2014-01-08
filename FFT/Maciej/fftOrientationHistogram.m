clear all;
close all; 

[images,labels] = loadImages( '../../Dataset/', 3 );
noOfImages = size ( images, 2 );

% Let's try to figure out hwo many orientations there are, i.e. what is the
% major orientation in the image

%prepare bands
noOfBins = 12;
delta = 2*pi / noOfBins;

% compute histogram for each image
histograms = zeros( noOfImages, noOfBins );
magnitudes = zeros( noOfImages, 1 );

k = zeros ( 1, noOfImages ); 
v = zeros ( 1, noOfImages );

for i = 1:noOfImages
    im = rgb2gray(images{i}); 
    im_fft = fft2(im);
    phase_spectra = fftshift( angle( im_fft ) ) ;
    power_spectra = fftshift( abs (im_fft) );
    
    %normalize power spectra
    power_spectra = power_spectra / sum( power_spectra(:) );
    
    %compute the histogram
    orientation_histogram = zeros( 1, noOfBins);
    for j = 1:noOfBins
        curLow  = -pi + ((j - 1) * delta);
        curHigh = -pi + (j * delta);
        ind = find( phase_spectra >= curLow & phase_spectra < curHigh);
        magnitude = sum(power_spectra(ind));
        orientation_histogram(j) = magnitude * size(ind,1);
    end;
    histograms(i,:) = orientation_histogram;
    k(i) = norm(orientation_histogram);  
    v(i) = i;
end;

D = pdist ( histograms, 'euclidean' );
M = squareform(D);
imshow(M,[], 'InitialMagnification', 1000 );

imageMap = containers.Map(k, v);

indices =  cell2mat(values(imageMap));
figure;
for i = 1:size( keys(imageMap), 2 )
    im = images{indices(i)}; 
    subplot(3,8,i), imshow(im);
end;