function [  ] = colorSpacePointCloud( im )
% visualizes how image pixels fir into a color space
im = double(im)/256;
col = reshape( im, [size(im,1) * size(im,2), 3] );
S = ones( size(col,1), 1 );
scatter3( col( :, 1 ), col( :, 2 ), col ( :, 3 ), S(:), col ); 

end

