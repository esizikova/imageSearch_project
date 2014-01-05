function [ functionMap ] = createFunctionHandleMap()
%CREATEFUNCTIONHANDLEMAP Put your decriptor here, so then it can be found
%using a name - the function handle will be returned..

names = { 'stackedLab', 'combinedLab', 'statisticsLab',...
          'singularValues'};
functionHandles = ...
   { @LabStackedHistograms, @LabCombinedHistogram, @LabImageStatistics,...
     @SVDDescriptor };
 
functionMap = containers.Map ( names, functionHandles );

end

