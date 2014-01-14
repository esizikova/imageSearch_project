clear all;
close all;

% Cleanup workspace
clear all;
close all;

% Add subfolders to search path
addpath([ pwd,'/Descriptors/'] ); 

% Read in all images
[images, labels] = loadImages( '../Dataset/' );
%global vars

nBins          = 3;

histogram = stackedHistogramsRGB( images{5}, nBins );
figure,
subplot(1,2,1), imshow( images{5}, []); title('Input Image','FontSize',15)
subplot(1,2,2),

N = numel(histogram);
for i=1:N
  h = bar(i, histogram(i)); hold on;
  if (i <= 3)  
    col = 'r';
  elseif ( i > 3 & i <= 6) 
    col = 'g';
  else
      col ='b';
  end
  set(h, 'FaceColor', col) 
end 
set(gca, 'XTickLabel', '');
xlabel('Bins','FontSize',15)
ylabel('Values','FontSize',15)
title('Histogram','FontSize',15)