%521 - Term Project
%SVD Exploration

%% read in all images
[images_set, labels] = loadImages( '../Dataset/' );
noOfCat = 8;

%Move from cells to 4-D matrices (yes, don't complain)
for i = 1:length(images_set)
    images(:,:,:,i) = images_set{i};
end

%SVD - compute
use_color = false;
clear U S V
for i = 1:size(images,4)
    if use_color
        [U(:,:,:,i),S(:,:,:,i),V(:,:,:,i)] = imageSVD(images(:,:,:,i)); % color
    else
        [U(:,:,1,i),S(:,:,1,i),V(:,:,1,i)] = imageSVD(images(:,:,:,i), use_color); % Black and white
    end
end

%% Descriptors
for i = 1:size(images,4)
    for j = 1:size(images,4)
        % Just look at Singular Values
        %num_sv = 10;
        %desc_1 = SVDSingularValue(images(:,:,:,i), num_sv, use_color, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i));
        %desc_2 = SVDSingularValue(images(:,:,:,j), num_sv, use_color, U(:,:,:,j), S(:,:,:,j), V(:,:,:,j));
        
        % Stack slices of U and V
        %num_ev = 3;
        %desc_1 = SVDEVStacked(images(:,:,:,i), num_ev, use_color, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i));
        %desc_2 = SVDEVStacked(images(:,:,:,j), num_ev, use_color, U(:,:,:,j), S(:,:,:,j), V(:,:,:,j));         
        
        % Stack slices of U and V with scaling by S
        num_ev = 1;
        desc_1 = SVD_EV_SV_Stacked(images(:,:,:,i), num_ev, use_color, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i));
        desc_2 = SVD_EV_SV_Stacked(images(:,:,:,j), num_ev, use_color, U(:,:,:,j), S(:,:,:,j), V(:,:,:,j));    
        
        %Main diagonal of resulting compressed image
        %num_sv = 3;
        %desc_1 = SVDDiagonal(images(:,:,:,i), num_sv, use_color, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i));
        %desc_2 = SVDDiagonal(images(:,:,:,j), num_sv, use_color, U(:,:,:,j), S(:,:,:,j), V(:,:,:,j)); 
        
        %Euclidean distance
        %dist(i,j) = norm(desc_1 - desc_2);
        
        %Cosine similarity
        dist(i,j) = dot(desc_1,desc_2)/(norm(desc_1)*norm(desc_2));
    end
end

% show the distance matrix nicely
plotMatrix ( dist, labels );

%% k-means clustering
for i = 1:size(images,4)
    dataPts(i,:) = SVDDiagonal(images(:,:,:,i), 100, use_color, U(:,:,:,i), S(:,:,:,i), V(:,:,:,i))';
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

%% Plots of U/V

plot(U(:,1,1,1),'red')  % coast
hold on
plot(U(:,1,1,2),'red')
plot(U(:,1,1,3),'red')
plot(U(:,1,1,4),'blue') % forest
plot(U(:,1,1,5),'blue')
plot(U(:,1,1,6),'blue')
hold off

plot(U(:,1,1,7),'green') % highway
plot(U(:,1,1,8),'green')
plot(U(:,1,1,9),'green')
plot(U(:,1,1,10),'black') % insidecity
plot(U(:,1,1,11),'black')
plot(U(:,1,1,12),'black')
plot(U(:,1,1,13), 'Color', [0.5430 0 0] ) % mountain
plot(U(:,1,1,14), 'Color', [0.5430 0 0] )
plot(U(:,1,1,15), 'Color', [0.5430 0 0] )
plot(U(:,1,1,16),'yellow') % opencountry
plot(U(:,1,1,17),'yellow')
plot(U(:,1,1,18),'yellow')
plot(U(:,1,1,19),'cyan') % street
plot(U(:,1,1,20),'cyan')
plot(U(:,1,1,21),'cyan')
plot(U(:,1,1,22),'magenta') % tallbuilding
plot(U(:,1,1,23),'magenta')
plot(U(:,1,1,24),'magenta')
hold off


%cosine similarity
A = U(:,1,1,1);
B = U(:,1,1,5);
sim = dot(A,B)/(norm(A)*norm(B))

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