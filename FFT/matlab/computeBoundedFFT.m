    % Prepare image     
     %theta = linspace(0, 2*pi, 256);
     %f = repmat(sin(2*theta+2), [256 1]);
     
    % function [ M ] = computeBoundedFFT(im)
         V = zeros(256,256);

         im = imread ('/home/lena/Documents/CS_Projects/imageSearch_project/trunk/Dataset/insidecity_a140032.jpg' );
         im = double(im) / 255;
         f = rgb2gray(im);  % 256*256
         %f(5:24,13:17) = 1; 
         %imshow(f)

         % Compute Fourier Transform 
         F = fft2(f); 
         F = fftshift(F); % Center FFT

         % Measure the minimum and maximum value of the transform amplitude 
         % disp(unique(abs(F)));
         %disp('min amplitude');
         %min(min(abs(F))) %   0
         %disp('max amplitude');
         %max(max(abs(F))) % 100 
         subplot(3,1,3);
         imshow(abs(F),[0 100]); %colormap(jet); colorbar
         title('city');

         % set everything but a small window to zeros
         V(100:150,100:150) = F(100:150,100:150); % this is the filtered image
         %imshow(abs(V),[0 100]); %colormap(jet); colorbar
       
         M = reshape( F(100:150,100:150), 1,2601);
         %imshow(real(ifft2(V)),[])

   %  end
     
%      % Look at the phases 
%      disp(unique(angle(F)));
%      imshow(angle(F),[-pi,pi]); %colormap(jet); colorbar

    
