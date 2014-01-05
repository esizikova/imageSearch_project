%compressed composit images - grayscale only
function plotTopSingularValues(image)

[U,S,V] = svd(double(image));

figure;

num_sv = 5;
num_rows = 4;
subplot(num_rows,num_sv+1,1); imshow(image); title('Original Image')
for i = 1:num_sv
    sv_img = uint8(U(:,i)*S(i,i)*V(:,i)');
    subplot(num_rows,num_sv+1,i+1); imshow(sv_img); title(['Singular Value ', int2str(i)])
    subplot(num_rows,num_sv+1,i+num_sv+2); plot(U(:,i)); title('U')
    subplot(num_rows,num_sv+1,i+(num_sv+1)*2+1); plot(V(:,i)); title('V')
    subplot(num_rows,num_sv+1,i+(num_sv+1)*3+1); hist(double(reshape(sv_img,size(sv_img,1)*size(sv_img,2),1))); title(['Mean = ', int2str(mean(mean(sv_img)))])
end

end