function [desc] = SVD_UV_Stacked(img, num_ev, color, U, S, V)
    if nargin < 2
        disp('Invalid no. of arguments! ');
        return;
    elseif nargin < 3
        color = true;
        [U,S,V] = imageSVD(img, color);
    elseif nargin < 4
        [U,S,V] = imageSVD(img, color);
    end
    
    if color
        red = cat(1,reshape(U(:,1:num_ev,1),num_ev*size(U,1),1),reshape(V(:,1:num_ev,1),num_ev*size(V,1),1));
        green = cat(1,reshape(U(:,1:num_ev,2),num_ev*size(U,1),1),reshape(V(:,1:num_ev,2),num_ev*size(V,1),1));
        blue = cat(1,reshape(U(:,1:num_ev,3),num_ev*size(U,1),1),reshape(V(:,1:num_ev,3),num_ev*size(V,1),1));
        desc = cat(1,red,green,blue);
        
    else
        desc = cat(1,reshape(U(:,1:num_ev),num_ev*size(U,1),1),reshape(V(:,1:num_ev),num_ev*size(V,1),1));
    end
end
