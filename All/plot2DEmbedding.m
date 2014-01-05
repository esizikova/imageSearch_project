function [] = plot2DEmbedding ( embedding, images, imSize )
noOfDatapoints = size(images,2);

figure; hold on; axis equal;
for i = 1:noOfDatapoints
    loc_x = embedding(i,1);
    loc_y = embedding(i,2);
    imagesc ( [loc_x loc_x+imSize],...
        [loc_y+imSize loc_y], images{i} );
end;
plot( embedding(:,1), embedding(:,2), 'r.', 'MarkerSize', 20 );

set(gcf,'PaperPositionMode','auto')
set(gcf, 'Position', [700 100 900 900])

end

