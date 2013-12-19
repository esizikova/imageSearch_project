function [] = plotMatrix( matrix, labels )

figure; imagesc( matrix ); hold on;

L = get(gca,'XLim');
set( gca,'XTick',linspace( L(1),L(2), size( matrix,1 ) ) );
set( gca, 'xtickLabel', labels );

K = get(gca,'YLim');
set( gca,'YTick',linspace( K(1),K(2), size( matrix,1 ) ) );
set( gca, 'ytickLabel', labels );


end

