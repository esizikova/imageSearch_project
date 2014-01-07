     function [ K ] = computeBoundedFFTMagnitude(im)
         
         im = double(im) / 255;
         f = rgb2gray(im);  % 256*256
         
         
         % Compute Fourier Transform 
         F = fft2(f); 
         F = fftshift(F); % Center FFT

         % take only a small number of main frequencies
         M = reshape( F(100:150,100:150), 2601,1);
         K = abs(M);
      
     end