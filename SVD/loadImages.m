function [ images, labels ] = loadImages( directory )

dCell = dir([ directory '*.jpg']);
labels = cell ( size ( dCell, 1 ), 1 );
images = cell ( size ( dCell, 1 ), 1 );
for d = 1:length(dCell) 
    images{d} = imread( [directory dCell(d).name] );
    s = strread ( dCell(d).name, '%s', 'delimiter', '_' );
    labels{d} = s{1};
end

end

