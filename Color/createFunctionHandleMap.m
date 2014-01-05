function [ functionMap ] = createFunctionHandleMap()
%CREATEFUNCTIONHANDLEMAP Put your decriptor here, so then it can be found
%using a name - the function hanlde will be returned to use
names = { 'stackedRGB', 'combinedRGB', 'statisticsRGB',...
          'stackedHSV', 'combinedHSV', 'statisticsHSV',...
          'stackedLab', 'combinedLab', 'statisticsLab',...
          'singularValues'};
functionHandles = ...
   { @stackedHistogramsRGB, @combinedHistogramRGB, @imageStatisticsRGB,...
     @stackedHistogramsHSV, @combinedHistogramHSV, @imageStatisticsHSV,...
     @stackedHistogramsLab, @combinedHistogramLab, @imageStatisticsLab,...
     @SVDDescriptor };
 
functionMap = containers.Map ( names, functionHandles );

end
