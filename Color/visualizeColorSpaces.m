% Cleanup workspace
clear all; close all;

% generate rgb colors
tic;
RGB = rand( [10000 3] );
toc;
R = RGB(:,1);
G = RGB(:,2);
B = RGB(:,3);

% create figure
figure(1);

% show RGB cube
subplot(1,3,1);
scatter3( R, G, B, 15.0, RGB, 'fill' );
title( 'RGB' );
axis equal;
axis off;

% convert to HSV
tic;
HSV = rgb2hsv(RGB);
H = HSV ( :, 1 );
S = HSV ( :, 2 );
V = HSV ( :, 3 );
toc;

% show HSV 
% subplot(1,3,2);
scatter3( H, S, V, 25.0, RGB, 'fill' );
title( 'HSV' );
axis equal;
                                

% convert to Lab
tic;
colorTransform = makecform('srgb2lab');
Lab = applycform(RGB, colorTransform);
L = Lab ( :, 1 );
a = Lab ( :, 2 );
b = Lab ( :, 3 );
toc;

% show HSV 
subplot(1,3,3);
scatter3( L, a, b, 15.0, RGB, 'fill' );
title( 'Lab' );
axis equal;
axis off;