function [U,S,V] = imageSVD(img, color)
    if nargin < 2
        color = true;
    end

    if color
        [U(:,:,1),S(:,:,1),V(:,:,1)] = svd(double(img(:,:,1)));
        [U(:,:,2),S(:,:,2),V(:,:,2)] = svd(double(img(:,:,2)));
        [U(:,:,3),S(:,:,3),V(:,:,3)] = svd(double(img(:,:,3)));
    else
        img = rgb2gray(img);
        [U,S,V] = svd(double(img));
    end
end