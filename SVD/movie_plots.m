[U,S,V] = svd ( double( image ) );
im_final = zeros(874,1381);

for s = 1:120;
    % only use single singular value to create image component
    im_r = U(:,s) * S(s,s) * V(:,s)';
    im_final = im_final + im_r;
    
    % visualize
    subplot(1,2,1)
    imshow(im_r, []);
    subplot(1,2,2)
    imshow(im_final, []);
    saveas(gca, strcat('movie/',sprintf('%3.3d',s),'.jpg'),'jpg')
    drawnow;
    pause(0.3)
end;