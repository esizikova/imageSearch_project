clear all;
close all;

scrsz = get(0,'ScreenSize');
figure('Position',[20 scrsz(4)/2-100 scrsz(3)/2 scrsz(4)/2]),

% prepare image and global variables
im = imread('cameraman.tif');
N = size(im, 2);

% explicit method
tic
row = [1 zeros(1,N-2) 1 -4 1 zeros(1,N-2) 1];
dd = repmat(row, N*N, 1);
A = spdiags(dd, -N:N,  N^2, N^2);
toc

% make sure the laplacian values are okay
S = sum(A,1);
ind = find(S);
for( i = 1:2*N )
    cur_idx = ind(i);
    sum_val = sum(S(cur_idx));
    A(cur_idx, cur_idx) = A(cur_idx, cur_idx) - sum_val;
end;


% prepared delta time and reshape im into f
dt = 0.25; % max =
f = double(reshape(im, N*N, 1));
for(k = 1:1000)
    f = f + dt*A*f;
    im = reshape(f, N, N);
    imshow( im, [] );
    drawnow
end;
return

% =========================================================================
% implicit method

dd = repmat( [ 1 -2 1 ], N*N, 1 );
A = spdiags( dd, -1:1, N^2, N^2 );

A(1, 1)  = -1;
A(1, N^2) = -1;
I = speye( N*N );
dt = 0.4;

f = double(im)/255; % <- f for first step
rows = [];
cols = [];
mask = zeros(size(im));
mask(160:end, 160:end) = 1;

for(k = 1 : 100)
    % reshape into ocolumn
    f = reshape(f, N*N, 1);
    
    % solve first step
    fhalf = (I-(dt/2)*A)\f;
    
    % reshape into row major column
    fhalf = reshape(fhalf,N,N)';
    f = double(reshape(fhalf, N*N,1));
    
    % solve second step and reshape back to an image
    f = (I-(dt/2)*A)\f;
    f = reshape(f, N, N)';
    
    % show image
    im = f;
    % find maxima minima
%     [~, ind] = max(im(:).*mask(:));
%     [r,c]    = ind2sub( size(f),ind );
    imshow( im, [] );
%     hold on;
%     plot(r, c, 'r.');
%     rows = [rows r];
%     cols = [cols c];
    drawnow;
%   if(k == 10)
%         figure,
%         imshow( im, [] ), title('k = 10');
%         hold on;
%         plot(c, r, 'r.');
%     elseif(k == 35)
%         figure,
%         imshow( im, [] ),title('k = 35');
%         hold on;
%         plot(c, r, 'r.');
%     elseif(k == 70)
%         figure,
%         imshow( im, [] ),title('k = 70');
%         hold on;
%         plot(c, r, 'r.');
%     elseif(k == 100)
%         figure,
%         imshow( im, [] ),title('k = 100');
%         hold on;
%         plot(c, r, 'r.');
%     end;
end;

figure, plot(rows, cols, 'r.', 'MarkerSize', 20);