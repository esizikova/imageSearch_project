%compressed composit images - grayscale only
function plotTopCompressions(image)

[U,S,V] = svd(double(image));

figure;

num_sv = 1;
for i = 1:2
    for j = 1:2
        subplot(2,2,num_sv); imshow(uint8(U(:,1:num_sv)*S(1:num_sv,1:num_sv)*V(:,1:num_sv)')); % title(num_sv)
        num_sv = num_sv + 1;
    end
end
end