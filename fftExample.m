close all;
clear all;

im = imread ( 'Dataset/coast_bea1.jpg' );
im = double(im) / 255;
im = rgb2gray(im);

im_fft = fft2(im);
%normally zero frequency is displayed in the upper left. fftshift moves it
%to hte center.
im_fft_centered = fftshift( im_fft ); 
im_phase = angle (im_fft_centered );
im_amplitude = abs( im_fft_centered );
im_reconstruct = ifft2( im_fft  );


subplot(2,2,1), imshow( im,[] ), title ('orginal image');
subplot(2,2,2), imshow( im_phase,[] ), title ('phase image');
% peak frequencies, are very high, so to see any useful infromation when
% visualizing, take the log of the amplitude
subplot(2,2,3), imshow( log(im_amplitude),[] ), title ('amplitude image');
subplot(2,2,4), imshow( im_reconstruct,[] ), title ('reconstructed image');
