function [ desc ] = SVDBasisFFT(img, U, S, V)
    if nargin < 1
        disp('Invalid no. of arguments! ');
        return;
    elseif nargin < 4
        img = rgb2gray(img);
        [U,S,V] = svd(double(img));
    end
    
    N = 256; %sampling frequecy

    %FFT of first col of U
    y = abs(fft(U(:,1),N));
    U_fft = y(1:N/2);

    %FFT of first col of V
    y = abs(fft(V(:,1),N));
    V_fft = y(1:N/2);

    desc = [U_fft', V_fft'];
end