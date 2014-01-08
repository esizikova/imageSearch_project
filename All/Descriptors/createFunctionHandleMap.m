function [ functionMap ] = createFunctionHandleMap()
%CREATEFUNCTIONHANDLEMAP Put your decriptor here, so then it can be found
%using a name - the function handle will be returned..

names = { 'stackedLab', 'combinedLab', 'statisticsLab',...
          'stackedRGB', 'combinedRGB', 'statisticsRGB',...
          'statisticsHSV',...
          'singularValues','singularValues2','stackedUV','stackedUSV',...
          'compressedDiagonal','UVBasisFFT','UVBasisRot','UVBasisRotNorm',...
          'RectangularWindowFFTAngle','RectangularWindowFFTMagnitude',...
          'FFTBandDescriptor','FFTLocalization' };

functionHandles = ...
   { @LabStackedHistograms, @LabCombinedHistogram, @LabImageStatistics,...
     @RGBstackedHistograms, @RGBCombinedHistogram, @RGBImageStatistics,...
     @HSVimageStatistics,...
     @SVDDescriptor, @SVDSingularValue, @SVD_UV_Stacked, @SVD_USV_Stacked,...
     @SVDDiagonal, @SVDBasisFFT, @SVDBasisFFTRotated, @SVDBasisFFTRotatedNormalized, ...
     @computeBoundedFFTAngle, @computeBoundedFFTMagnitude, ...
     @FFTBandDescriptor, @FFTLocalization };

functionMap = containers.Map ( names, functionHandles );

end

