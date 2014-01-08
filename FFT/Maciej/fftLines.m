clear all;
close all; 

[images,labels] = loadImages( '../../Dataset/', 3 );

im = rgb2gray(images{23}); 

im_fft = fft2(im);

% normally zero frequency is displayed in the upper left. fftshift moves it
% to hte center.
im_phase = angle (im_fft );
im_amplitude = abs( im_fft );

im_fft2 = im_amplitude.*exp(i*im_phase);
im_reconstruct = ifft2( im_fft2  );

% detect edges
im_edges = edge( log(fftshift(im_amplitude)), 'canny', 0.5, 2 );

% perform hough transform
[H,theta,rho] = hough( im_edges,'RhoResolution',0.5,'Theta',-90:0.5:89.5);

% find peaks in hough space
P = houghpeaks(H, 10,'threshold',ceil( 0.3 * max( H(:) ) ) );
x = theta(P(:,2));
y = rho(P(:,1));

lines = houghlines(im_edges,theta,rho,P,'FillGap',64,'MinLength',64);


subplot(2,2,1), imshow( im,[] ), title ('orginal image');
subplot(2,2,2), imshow( log(fftshift(im_amplitude)),[] ), title ('amplitude image');
subplot(2,2,3), imshow( im_edges,[] ), title ('edge detector');hold on;
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% Display the Hough matrix.
subplot(2,2,4);
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,...
      'InitialMagnification','fit');
title('Hough Transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(x,y,'s','color','black');
