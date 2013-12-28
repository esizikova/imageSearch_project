close all;
clear all;

im = imread ( 'Dataset/coast_bea1.jpg' );
im = double(im) / 255;
im = rgb2gray(im);

im_fft = fft2(im);
%normally zero frequency is displayed in the upper left. fftshift moves it
%to hte center.
im_phase = angle (im_fft );
im_amplitude = abs( im_fft );
% im_phase = double(rand(256, 256));
im_amplitude = double(rand(256, 256));
im_fft2 = im_amplitude.*exp(i*im_phase);

im_reconstruct = ifft2( im_fft2 );


subplot(2,2,1), imshow( im,[] ), title ('orginal image');
subplot(2,2,2), imshow( fftshift(im_phase),[] ), title ('phase image');
% peak frequencies, are very high, so to see any useful infromation when
% visualizing, take the log of the amplitude
subplot(2,2,3), imshow( log(fftshift(im_amplitude)),[] ), title ('amplitude image');
subplot(2,2,4), imshow( im_reconstruct,[] ), title ('reconstructed image');
