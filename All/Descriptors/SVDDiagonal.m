function [desc] = SVDDiagonal(img, varargin)
    if nargin < 1
        disp('Invalid no. of arguments! ');
        return;
    end
    
    num_sv = 10;
    color = false;
    [U,S,V] = imageSVD(img, color);
    
    if color
        out_img(:,:,1) = U(:,1:num_sv,1)*S(1:num_sv,1:num_sv,1)*V(:,1:num_sv,1)';
        out_img(:,:,2) = U(:,1:num_sv,2)*S(1:num_sv,1:num_sv,2)*V(:,1:num_sv,2)';
        out_img(:,:,3) = U(:,1:num_sv,3)*S(1:num_sv,1:num_sv,3)*V(:,1:num_sv,3)';
        desc = cat(1,diag(out_img(:,:,1)),diag(out_img(:,:,2)),diag(out_img(:,:,3)));
    else
        out_img = U(:,1:num_sv)*S(1:num_sv,1:num_sv)*V(:,1:num_sv)';
        desc = diag(out_img);
    end
end
