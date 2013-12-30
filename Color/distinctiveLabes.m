function [ nUnique ] = distinctiveLabes( strings )
%DISTINCTIVELABES Given a cell matrix of strings finds the number of unique
%ones

uniqueElements = unique ( strings );
nUnique = size ( uniqueElements, 1 );

end

