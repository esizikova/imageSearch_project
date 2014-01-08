clear all;
close all; 

[images,labels] = loadImages( '../../Dataset/', 3 );
band_filter_im = double( imread('band.png')) / 255;
noOfImages = size ( images, 2 );

% Similar to the fftLocalization we will look here at the frequency
% magnitude distribution, but instead of just focusing on the frequency we
% will first calculate the band histograms ( 5 bins ), and use those to get
% better information

% prepare bands
noOfBands = 128;
bandSizes = uint8(linspace(8, 256, noOfBands))/2;
bands = zeros( 256, 256, noOfBands );
for i = 1:noOfBands
    halfSize = bandSizes(i);
    se3 = strel('disk',double(halfSize), 8);
    bandShape = se3.getnhood();
    extends = 129 - halfSize:127 + halfSize;
    bands(extends, extends, i) = bandShape;
end;

%make sure bands do no overlap
figure;
for i = noOfBands:-1:2
    bands(:,:,i) = bands(:,:,i) - bands(:,:,i-1);
end;


% compute histogram for each image
histograms = zeros( noOfImages, noOfBands );
magnitudes = zeros( noOfImages, 1 );

k = zeros ( 1, noOfImages ); 
v = zeros ( 1, noOfImages );

for i = 1:noOfImages
    im = rgb2gray(images{i}); 
    im_fft = fft2(im);
    power_spectra = fftshift( abs( im_fft ) ) ;
    
    %normalize power spectra
    power_spectra = power_spectra / sum( power_spectra(:) );
    
    %compute the histogram
    frequency_histogram = zeros( 1, noOfBands );
    for j = 1:noOfBands
        band_frequencies = bands(:,:,j) .* power_spectra;
        frequency_histogram(j) = sum( band_frequencies(:) );
    end;
    histograms(i,:) = frequency_histogram / norm(frequency_histogram);
    k(i) = norm(frequency_histogram);  
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
