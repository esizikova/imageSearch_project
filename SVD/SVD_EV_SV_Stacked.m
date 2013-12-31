function [desc] = SVD_EV_SV_Stacked(img, num_ev, color, U, S, V)
    if nargin < 3
        color = true;
        [U,S,V] = imageSVD(img, color);
    elseif nargin < 4
        [U,S,V] = imageSVD(img, color);
    end
    
    if color
        red = cat(1,reshape(U(:,1:num_ev,1)*S(1:num_ev,1:num_ev,1),num_ev*size(U,1),1),reshape(S(1:num_ev,1:num_ev,1)*V(:,1:num_ev,1)',num_ev*size(V,1),1));
        green = cat(1,reshape(U(:,1:num_ev,2)*S(1:num_ev,1:num_ev,2),num_ev*size(U,1),1),reshape(S(1:num_ev,1:num_ev,2)*V(:,1:num_ev,2)',num_ev*size(V,1),1));
        blue = cat(1,reshape(U(:,1:num_ev,3)*S(1:num_ev,1:num_ev,3),num_ev*size(U,1),1),reshape(S(1:num_ev,1:num_ev,3)*V(:,1:num_ev,3)',num_ev*size(V,1),1));
        desc = cat(1,red,green,blue);
        
    else
        desc = cat(1,reshape(U(:,1:num_ev)*S(1:num_ev,1:num_ev),num_ev*size(U,1),1),reshape(S(1:num_ev,1:num_ev)*V(:,1:num_ev)',num_ev*size(V,1),1));
    end
end