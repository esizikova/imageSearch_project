% clear the workspace
close all;
clear all; 

% Read in all images
[images, labels] = loadImages( '../Dataset/' );
noOfDatapoints = size ( images, 1 ); 

% compute the SVD of all images and store singular values
dVals = zeros(1, noOfDatapoints);

for i = 1:noOfDatapoints
    % I believe histogram equalization is necessary here
    im = histeq( single( rgb2gray ( images{i} ) ) / 255 ); 
%     im = single( rgb2gray ( images{i} ) ) / 255 ;
    [U,S,V] = svd ( im );
    im_rec = U(:,1) * S(1,1) * V(:,1)';
    % squared distance
    dVals(i) = norm( im(:) - im_rec(:) );
end;

figure(1), hold on; axis equal; axis off
imSize = .8;
for i = 1:noOfDatapoints
    loc_x = dVals(i);
    loc_y = dVals(i);
    imagesc ( [loc_x loc_x+imSize],...
              [loc_y+imSize loc_y], images{i} );
end;

plot(  dVals, dVals, 'r.');