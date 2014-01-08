function [ descriptor ] = FFTBandDescriptor( im, varargin )
if( nargin < 2 | nargin > 2)
    disp('Incorrect number of arguments!' );
    return;
end;

bands = cell2mat(varargin(1));
noOfBands = size(bands,3);

% compute histogram for each image
im = rgb2gray( im );
im_fft = fft2( im );

% compute normalized power spectra
power_spectra = fftshift( abs( im_fft ) ) ;
power_spectra = power_spectra / sum( power_spectra(:) );

% compute the histogram
frequency_histogram = zeros( 1, noOfBands );
for j = 1:noOfBands
    band_frequencies = bands(:,:,j) .* power_spectra;
    frequency_histogram(j) = sum( band_frequencies(:) );
end;
descriptor = frequency_histogram / norm(frequency_histogram);
descriptor = descriptor';


end

