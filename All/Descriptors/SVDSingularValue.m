function [desc] = SVDSingularValue (img, varargin)  
    if nargin < 1
        disp('Invalid no. of arguments! ');
        return;
    end
    
    num_sv = 10;
    color = false;
    [U,S,V] = imageSVD(img, color);
    
    if color
        desc = cat(1,diag(S(1:num_sv,1:num_sv,1)), ...
                     diag(S(1:num_sv,1:num_sv,2)), ...
                     diag(S(1:num_sv,1:num_sv,3)));
    else
        desc = diag(S(1:num_sv,1:num_sv)/sum(diag(S)));
    end
end
