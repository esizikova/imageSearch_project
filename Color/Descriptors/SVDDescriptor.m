function [ singularVals] = SVDDescriptor( im )
    im = histeq( single( rgb2gray ( im ) ) / 255 ) ;
    [U,S,V] = svd ( im );
    singularVals = diag(S)';
end

