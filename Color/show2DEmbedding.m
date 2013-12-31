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

% compute the descriptor, in this case HSV image statistics
embedding2D = zeros ( noOfDatapoints, 2 );
for i = 1:noOfDatapoints
    fHandle = functionMap( 'statisticsLab' );
    descriptor = fHandle(images{i});
    channel1   = descriptor(1);
    channel2   = descriptor(2);
    channel3   = descriptor(3);
    embedding2D(i,:) = [channel2, channel3]; 
end

% map the actual interval of values to [0 1]
min1 = min( embedding2D(:,1) );
max1 = max( embedding2D(:,1) );
min2 = min( embedding2D(:,2) );
max2 = max( embedding2D(:,2) );
embedding2D(:,1) = ( embedding2D(:,1) - min1 ) / ( max1 - min1 );
embedding2D(:,2) = ( embedding2D(:,2) - min2 ) / ( max2 - min2 );


figure(1);axis([ 0 1.2 0 1.2]);hold on;
imSize = .1;
for i = 1:noOfDatapoints
    loc_x = embedding2D(i,1);
    loc_y = embedding2D(i,2);
    imagesc ( [loc_x loc_x+imSize],...
              [loc_y+imSize loc_y], images{i} );
end;
plot( embedding2D(:,1), embedding2D(:,2), 'r.');
