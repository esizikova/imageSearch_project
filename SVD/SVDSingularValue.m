function [desc] = SVDSingularValue (img, color, U, S, V)  
    if nargin < 1
        disp('Invalid no. of arguments! ');
        return;
    elseif nargin < 2
        color = false;
        if size(img,3) == 3
            img = rgb2gray(img);
        end
        [U,S,V] = svd(double(img));
    end
    
    num_sv = 10;
    
    if color
        desc = cat(1,diag(S(1:num_sv,1:num_sv,1)), ...
                     diag(S(1:num_sv,1:num_sv,2)), ...
                     diag(S(1:num_sv,1:num_sv,3)));
    else
        desc = diag(S(1:num_sv,1:num_sv));
    end
end