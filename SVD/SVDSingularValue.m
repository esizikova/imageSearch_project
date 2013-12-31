function [desc] = SVDSingularValue (img, num_sv, color, U, S, V)  
    if nargin < 3
        color = true;
        [U,S,V] = imageSVD(img, color);
    elseif nargin < 4
        [U,S,V] = imageSVD(img, color);
    end
    
    if color
        desc = cat(1,diag(S(1:num_sv,1:num_sv,1)), ...
                     diag(S(1:num_sv,1:num_sv,2)), ...
                     diag(S(1:num_sv,1:num_sv,3)));
    else
        desc = diag(S(1:num_sv,1:num_sv));
    end
end