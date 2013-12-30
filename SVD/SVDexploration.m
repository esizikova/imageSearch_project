%521 - Term Project
%SVD Exploration

%read in all images
[images_set, labels] = loadImages( '../Dataset/' );
noOfCat = 8;

%Move from cells to 4-D matrices (yes, don't complain)
for i = 1:length(images_set)
    images(:,:,:,i) = images_set{i};
end

%SVD - compression
for i = 1:size(images,4)
    [U(:,:,:,i),S(:,:,:,i),V(:,:,:,i)] = imageSVD(images(:,:,:,i));

    %Reconstruct from less singular values
    %num_sv = 10;
    %out_img(:,:,1,i) = U(:,1:num_sv,1,i)*S(1:num_sv,1:num_sv,1,i)*V(:,1:num_sv,1,i)';
    %out_img(:,:,2,i) = U(:,1:num_sv,2,i)*S(1:num_sv,1:num_sv,2,i)*V(:,1:num_sv,2,i)';
    %out_img(:,:,3,i) = U(:,1:num_sv,3,i)*S(1:num_sv,1:num_sv,3,i)*V(:,1:num_sv,3,i)';

    %imshow(uint8(out_img(:,:,:,i)))
end

%% SVD - Just look at singular values
num_sv = 10;
for i = 1:size(images,4)
    for j = 1:size(images,4)
        desc_1 = SVDSingularValue(images(:,:,:,i), num_sv, true, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i));
        desc_2 = SVDSingularValue(images(:,:,:,j), num_sv, true, U(:,:,:,j), S(:,:,:,j), V(:,:,:,j));
        sv_dist(i,j) = norm(desc_1 - desc_2);
    end
end

% show the distance matrix nicely
plotMatrix ( sv_dist, labels );

%% SVD - Stack slices of U and V
num_ev = 3;
for i = 1:size(images,4)
    for j = 1:size(images,4)
        desc_1 = SVDEVStacked(images(:,:,:,i), num_ev, true, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i));
        desc_2 = SVDEVStacked(images(:,:,:,j), num_ev, true, U(:,:,:,j), S(:,:,:,j), V(:,:,:,j)); 
        slice_dist(i,j) = norm(desc_1 - desc_2);
    end
end

% show the distance matrix nicely
plotMatrix ( slice_dist, labels );

%% SVD - Main diagonal of resulting compressed image
n_sv = 100;
for i = 1:size(images,4)
    for j = 1:size(images,4)
        desc_1 = SVDDiagonal(images(:,:,:,i), num_sv, true, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i));
        desc_2 = SVDDiagonal(images(:,:,:,j), num_sv, true, U(:,:,:,j), S(:,:,:,j), V(:,:,:,j)); 
        diag_dist(i,j) = norm(desc_1 - desc_2);
    end
end

% show the distance matrix nicely
plotMatrix ( diag_dist, labels );

%% k-means clustering
for i = 1:size(images,4)
    dataPts(i,:) = SVDDiagonal(images(:,:,:,i), 100, true, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i))';
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


%% Old stuff
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