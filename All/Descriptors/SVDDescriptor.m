function [ singularVals ] = SVDDescriptor( im, varargin )
    im = histeq( single( rgb2gray ( im ) ) / 255 ) ;
    [U,S,V] = svd ( im );
    singularValsAll = diag(S);
    singularVals = singularValsAll(1:20);
    singularVals = singularVals / norm(singularVals);
end

