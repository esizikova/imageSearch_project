%521 - Term Project
%SVD Exploration

%read in all images
[images_set, labels] = loadImages( '../Dataset/' );
noOfCat = 8; % for now i just use 2 categories

%Move from cells to 4-D matrices (yes, don't complain)
for i = 1:length(images_set)
    images(:,:,:,i) = images_set{i};
end

%SVD - each color channel
for i = 1:size(images,4)
    [U(:,:,1,i),S(:,:,1,i),V(:,:,1,i)] = svd(double(images(:,:,1,i)));
    [U(:,:,2,i),S(:,:,2,i),V(:,:,2,i)] = svd(double(images(:,:,2,i)));
    [U(:,:,3,i),S(:,:,3,i),V(:,:,3,i)] = svd(double(images(:,:,3,i)));

    %Reconstruct from less singular values
    num_sv = 10;
    out_img(:,:,1,i) = U(:,1:num_sv,1,i)*S(1:num_sv,1:num_sv,1,i)*V(:,1:num_sv,1,i)';
    out_img(:,:,2,i) = U(:,1:num_sv,2,i)*S(1:num_sv,1:num_sv,2,i)*V(:,1:num_sv,2,i)';
    out_img(:,:,3,i) = U(:,1:num_sv,3,i)*S(1:num_sv,1:num_sv,3,i)*V(:,1:num_sv,3,i)';

    imshow(uint8(out_img(:,:,:,i)))
end

%SVD - Just look at singular values
for i = 1:size(images,4)
    for j = 1:size(images,4)
        desc_1 = cat(1,diag(S(:,:,1,i)),diag(S(:,:,2,i)),diag(S(:,:,3,i)));
        desc_2 = cat(1,diag(S(:,:,1,j)),diag(S(:,:,2,j)),diag(S(:,:,3,j)));
        eucl_dist = norm(desc_1 - desc_2);
        sv_dist(i,j) = eucl_dist;
    end
end

% show the distance matrix nicely
plotMatrix ( sv_dist, labels );

%SVD - Stack slices of U and V with 1 singular value
for i = 1:size(images,4)
    for j = 1:size(images,4)
        red = S(1,1,1,i)*cat(1,U(:,1,1,i),V(:,1,1,i));
        green = S(1,1,2,i)*cat(1,U(:,1,2,i),V(:,1,2,i));
        blue = S(1,1,3,i)*cat(1,U(:,1,3,i),V(:,1,3,i));
        desc_1 = cat(1,red,green,blue);
        
        red = S(1,1,1,j)*cat(1,U(:,1,1,j),V(:,1,1,j));
        green = S(1,1,2,j)*cat(1,U(:,1,2,j),V(:,1,2,j));
        blue = S(1,1,3,j)*cat(1,U(:,1,3,j),V(:,1,3,j));
        desc_2 = cat(1,red,green,blue);
        
        eucl_dist = norm(desc_1 - desc_2);
        slice_dist(i,j) = eucl_dist;
    end
end

% show the distance matrix nicely
plotMatrix ( slice_dist, labels );

%--------------------------------------------------
% k-means clustering
dataPts = zeros( noOfCat*3 , 768);
for i = 1:noOfCat*3
    dataPts(i,:) = cat(1,diag(S(:,:,1,i)),diag(S(:,:,2,i)),diag(S(:,:,3,i)))';
end;

[clusterIdx, ctrs] = kmeans( dataPts, noOfCat, ...
                    'Distance', 'sqEuclidean',...
                    'Replicates', 15 );

frequency = sortrows(tabulate(clusterIdx));  %# compute sorted frequency table
mostFreqElement = max( frequency(:,2) );

%each row is a cluster
figure;
for i = 1 : noOfCat
    ind = find (clusterIdx == i);
    for j = 1:size( ind, 1 )
        subplot ( noOfCat, mostFreqElement, mostFreqElement * (i - 1) + j );
        imshow ( images(:,:,:,ind(j)) );
    end;
end;



%Normalize back to uint8
%red = (red - min(min(red)));
%red = red*255/max(max(red));
%green = (green - min(min(green)));
%green = green*255/max(max(green));
%blue = (blue - min(min(blue)));
%blue = blue*255/max(max(blue));

%SVD - three channels at once -- doesn't seem to work too well?
%[U,S,V] = svd(double(cat(2,image(:,:,1),image(:,:,2),image(:,:,3))));
%num = 1; %number of singular values to keep
%img = U(:,1:num)*S(1:num,1:num)*V(:,1:num)';

%out_img_2 = uint8(cat(3,img(:,1:size(image,2)), ...
%                        img(:,size(image,2)+1:size(image,2)*2),...
%                        img(:,size(image,2)*2+1:size(image,2)*3)));
%imshow(out_img_2)