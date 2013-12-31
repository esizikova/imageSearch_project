function [desc] = SVDDiagonal(img, num_sv, color, U, S, V)
    if nargin < 3
        color = true;
        [U,S,V] = imageSVD(img, color);
    elseif nargin < 4
        [U,S,V] = imageSVD(img, color);
    end
    
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