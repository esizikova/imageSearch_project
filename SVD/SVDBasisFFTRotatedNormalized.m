function [ desc ] = SVDBasisFFTRotated(img, varargin)
    if nargin < 1
        disp('Invalid no. of arguments! ');
        return;
    elseif nargin < 4
        if size(img,3) == 3
            img = rgb2gray(img);
        end
        [U,S,V] = svd(double(img));
    end
    
    N = 256; %sampling frequecy
    num_sv = 1;

    %FFT of first col of U
    U_fft = [];
    V_fft = [];
    for i = 1:num_sv
        y = abs(fft(U(:,1),N));
        U_fft = [U_fft; y(1:N/2)];

        %FFT of first col of V
        y = abs(fft(V(:,1),N));
        V_fft = [V_fft; y(1:N/2)];
    end

    desc = [(U_fft/sum(U_fft))', (V_fft/sum(V_fft))'];
    
    %do rotation 45 degrees
    A = imrotate(img, 45,'crop');
    A = A(42:211,42:211);
    [U,S,V] = svd(double(A));
    
    N = 170;
    U_fft = [];
    V_fft = [];
    for i = 1:num_sv
        y = abs(fft(U(:,1),N));
        U_fft = [U_fft; y(1:N/2)];

        %FFT of first col of V
        y = abs(fft(V(:,1),N));
        V_fft = [V_fft; y(1:N/2)];
    end
    
    desc = [desc, (U_fft/sum(U_fft))', (V_fft/sum(V_fft))'];
end