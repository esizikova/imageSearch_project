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