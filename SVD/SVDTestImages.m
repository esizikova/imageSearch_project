%test images;

%Other test images
%img = uint8(repmat(0:255, 256, 1));
%imwrite(img, '../SVDTestImages/horizizontalGrad.png','PNG');

%img = uint8(repmat([0:255]', 1, 256));
%imwrite(img, '../SVDTestImages/verticalGrad.png','PNG');

%img = uint8(255*rand(256,256));
%imwrite(img, '../SVDTestImages/randomFullSpace.png','PNG');

%img = uint8(127+128*rand(256,256));
%imwrite(img, '../SVDTestImages/randomTopHalfSpace.png','PNG');

%img = uint8(127*rand(256,256));
%imwrite(img, '../SVDTestImages/randomBottomHalfSpace.png','PNG');

%Some tests
[images, labels] = loadImages('../SVDTestImages/');
%[images, labels] = loadImages('../Dataset/');

%Save all plotTopSingularValues
for i = 1:length(images)
   plotTopSingularValues(images{i});
   name = strsplit(labels{i},'.');
   filename = strcat('singularValuePlots/',name{1},int2str(i),'.png');
   saveas(gcf,filename,'png')
   close(gcf)
end

%Rotated image
A = rgb2gray(images{2});
A = imrotate(images{2}, 45,'crop');
A = A(42:210,42:210);
plotTopCompressions(A)
plotTopSingularValues(A)

%% FFT of basis vectors
N = 256; %sampling frequecy
U_fft = cell(length(images),1);
for i = 1:length(images)
    A = rgb2gray(images{i});
    [U,S,V] = svd(double(A));
    y = abs(fft(U(:,1),N));
    U_fft{i} = y(1:N/2);
end

V_fft = cell(length(images),1);
for i = 1:length(images)
    A = rgb2gray(images{i});
    [U,S,V] = svd(double(A));
    y = abs(fft(V(:,1),N));
    V_fft{i} = y(1:N/2);
end

for i = 1:length(images)
    for j = 1:length(images)
        %Euclidean distance
        dist(i,j) = norm(U_fft{i} - U_fft{j});
    end
end

% PLOT
plotMatrix ( dist, labels );

% CLUSTERING
clear dataPts
for i = 1:length(images)
    %dataPts(i,:) = [U_fft{i}',V_fft{i}'];
    dataPts(i,:) = U_fft{i}';
    %dataPts(i,:) = V_fft{i}';
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
        imshow ( images{ind(j)} );
    end;
end;

%% Variance


%% Sum of diagonals
for i = 1:length(images)
    [U,S,V] = svd(double(rgb2gray(images{i})));
    sum(diag(S))
end

%diagonal
[U,S,V] = svd(double(images{1}));
num_sv = 4;
plotTopSingularValues(images{1})

%Horizontal Gradient

%Random FullSpace
[U,S,V] = svd(double(images{10}));
plot(diag(S))
num_sv = 1;
imshow(uint8(U(:,1:num_sv)*S(1:num_sv,1:num_sv)*V(:,1:num_sv)'))
plotTopSingularValues(images{10})