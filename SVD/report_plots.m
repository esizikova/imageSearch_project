%plots for report
%img = uint8(63*rand(256,256));
%imwrite(img, '../SVDTestImages/randomBottomQuarterSpace.png','PNG');

img = uint8(255*rand(256, 256));
img = [img, img];
for i = 1:256
    for j = i:256
        img(i,j) = img(j,i);
    end
end

%imwrite(img, '../SVDTestImages/randomBottomQuarterSpace.png','PNG');

%%%%%%%%%%% Plot singular values for random images
[U,S,V] = svd(double(randomFullSpace));
x = [2:256];
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'r+')
hold on
[U,S,V] = svd(double(randomBottomHalfSpace));
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'go')
[U,S,V] = svd(double(randomBottomQuarterSpace));
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'b*')
legend('Full','Half','Quarter')
title('Singular Values')

%%%%%%%%%%%% Plot symmetry
img = uint8(255*rand(256, 256));
for i = 1:256
    for j = i:256
        img(i,j) = img(j,i);
    end
end
%imwrite(img, '../SVDTestImages/randomDiagonalSymmetry.png','PNG');

img = uint8(255*rand(256, 128));
img = [img, fliplr(img)];
%imwrite(img, '../SVDTestImages/randomHorizontalSymmetry.png','PNG');

img = uint8(255*rand(128, 256));
img = [img; flipud(img)];
%imwrite(img, '../SVDTestImages/randomVerticalSymmetry.png','PNG');

[U,S,V] = svd(double(randomFullSpace));
x = [2:256];
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'mx')
hold on
[U,S,V] = svd(double(randomHorizontalSymmetry));
x = [2:256];
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'r*')
[U,S,V] = svd(double(randomVerticalSymmetry));
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'ko')
[U,S,V] = svd(double(randomDiagonalSymmetry));
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'b+')
legend('No Symmetry','Horizontal Symmetry','Vertical Symmetry','Diagonal Symmetry')
title('Singular Values Under Symmetry')
hold off

%%%%%%%%%% Singular Values - Natural Images
[U,S,V] = svd(double(coast));
x = [2:256];
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'mx')
hold on
[U,S,V] = svd(double(forest));
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'r*')
[U,S,V] = svd(double(street));
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'ko')
[U,S,V] = svd(double(tallbuilding));
temp = diag(S); plot(x(2:10:256),temp(2:10:256), 'b+')
legend('Coast','Forest','Street','Tall Building')
title('Singular Values of Natural Images')
hold off
