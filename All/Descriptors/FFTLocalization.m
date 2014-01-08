function [ descriptor ] = FFTLocalization( im, varargin )

%Prepare filter
filter = zeros(256);
halfSize = 8; % how big should this be?
extends = [129 - halfSize:128 + halfSize];
filter(extends, extends) = ones(2*halfSize);

im = rgb2gray(im);
im_fft = fft2(im);
power_spectra = fftshift( abs( im_fft ) ) ;

power_spectra    = power_spectra / sum( power_spectra(:) );
low_frequencies  = filter .* power_spectra;

descriptor  = sum( low_frequencies(:) );


end

