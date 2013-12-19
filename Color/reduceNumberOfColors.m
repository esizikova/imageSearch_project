function [ im_reduced ] = reduceNumberOfColors( im, nColors )

[im_no_dither, map] = rgb2ind( im, nColors, 'nodither' );
im_reduced          = ind2rgb ( im_no_dither, map );
% for i = 1:256 
%     for j = 1:256
%         ind = im_no_dither(i,j) + 1;
%         im ( i, j, 1 ) = map ( ind, 1 );
%         im ( i, j, 2 ) = map ( ind, 2 );
%         im ( i, j, 3 ) = map ( ind, 3 );
%     end;
% end;

figure, imshow( im_reduced );

end

