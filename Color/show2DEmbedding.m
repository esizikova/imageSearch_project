% clear the workspace
close all;
clear all;

% Add subfolders to search path
addpath([ pwd,'/Descriptors'] ); 

% Read in all images
[images, labels] = loadImages( '../Dataset/' );
noOfDatapoints = size ( images, 1 ); 

% Create the map of function handles 
functionMap = createFunctionHandleMap();

%select the function to get descriptor
fHandle1 = functionMap( 'statisticsLab' );
descriptorSize1 = size( fHandle1( images{1} ), 2 );
fHandle2 = functionMap( 'singularValues' );
descriptorSize2 = size( fHandle2( images{1} ), 2 );

descriptorSize = descriptorSize1 + ...
                 descriptorSize2 ;
             
%prepare the pairwise distance 
descriptors = zeros( noOfDatapoints, descriptorSize  ); 
for i = 1:noOfDatapoints
    d1 =  fHandle1( images{i} );
    d2 =  fHandle2( images{i} );
    descriptors(i,:) = [ d1, d2 ];
end

D = pdist( descriptors, 'euclidean');

%do multidimensional scaling
[embedding2D,eigvals] = cmdscale(D);

%plot results
figure(1); hold on; axis equal;
imSize = 5.1;
for i = 1:noOfDatapoints
    loc_x = embedding2D(i,1);
    loc_y = embedding2D(i,2);
    imagesc ( [loc_x loc_x+imSize],...
              [loc_y+imSize loc_y], images{i} );
end;
plot( embedding2D(:,1), embedding2D(:,2), 'r.');

% also plot the confusion matrix
conf = zeros( noOfDatapoints );
for i = 1:noOfDatapoints
    for j = 1:noOfDatapoints
        conf(i,j) = norm(descriptors(i,:) - descriptors(j,:));
    end;
end;

plotMatrix( conf, labels );

% Old code ---------------------------------------------------------------
% compute the descriptor
% embedding2D = zeros ( noOfDatapoints, 2 );
% for i = 1:noOfDatapoints
%     fHandle = functionMap( 'statisticsHSV' );
%     descriptor = fHandle(images{i});
%     channel1   = descriptor(1);
%     channel2   = descriptor(2);
%     embedding2D(i,:) = [channel1, channel2]; 
% end
% 
% % map the actual interval of values to [0 1]
% % min1 = min( embedding2D(:,1) );
% % max1 = max( embedding2D(:,1) );
% % min2 = min( embedding2D(:,2) );
% % max2 = max( embedding2D(:,2) );
% % embedding2D(:,1) = ( embedding2D(:,1) - min1 ) / ( max1 - min1 );
% % embedding2D(:,2) = ( embedding2D(:,2) - min2 ) / ( max2 - min2 );
% 
% 
% figure(2);axis([ 0 1.2 0 1.2]);hold on;
% imSize = .1;
% for i = 1:noOfDatapoints
%     loc_x = embedding2D(i,1);
%     loc_y = embedding2D(i,2);
%     imagesc ( [loc_x loc_x+imSize],...
%               [loc_y+imSize loc_y], images{i} );
% end;
% plot( embedding2D(:,1), embedding2D(:,2), 'r.');
