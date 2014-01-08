function [ images, labels ] = loadImages( directory, numInCategory )
% Load images - specify how many images fromeach category you want.
% providing -1 will output all images;

dCell = dir([ directory '*.jpg']);
images = cell ( size ( numInCategory * 8, 1 ), 1 );
labels = cell ( size ( numInCategory * 8, 1 ), 1 );
numInEachCategory = zeros ( 1, 8 );
curCatIdx = 0;
prevCatName = ['trd'];
curIdx = 1;
first = 1;

for d = 1:length(dCell)
    s = strread ( dCell(d).name, '%s', 'delimiter', '_' );
    curCatName = s{1};
    
    if( ~first )
        if( numInEachCategory( curCatIdx ) >= numInCategory ) 
            if ( strcmp ( curCatName, prevCatName ) )
                prevCatName = curCatName;
                continue;
            end;
        end
    end;
    first = 0;
        
    if ( strcmp ( curCatName, prevCatName ) ) % if names are the same
        numInEachCategory(curCatIdx) =  numInEachCategory(curCatIdx) + 1; %just increase;
    else %names are different
        curCatIdx = curCatIdx + 1;
        numInEachCategory(curCatIdx) =  numInEachCategory(curCatIdx) + 1; %just increase;
    end;
        
    images{curIdx} = imread( [directory dCell(d).name] );
    labels{curIdx} = curCatName;
    
    curIdx = curIdx + 1;
    prevCatName = curCatName;    
end

end

