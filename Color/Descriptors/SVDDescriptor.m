function [ singularVals] = SVDDescriptor( im )
    im = histeq( single( rgb2gray ( im ) ) / 255 ) ;
    [U,S,V] = svd ( im );
%     singularVals = diag(S)';
    im_r = U(:,1) * S(1,1) * V(:,1)';
    singularVals = norm(im(:) - im_r(:));
end

