function [ desc ] = SVDBasisFFTRotatedNormalized(img, num_sv, varargin)
    if nargin < 2
        disp('Invalid no. of arguments! ');
        return;
    elseif nargin < 4
        if size(img,3) == 3
            img = rgb2gray(img);
        end
        [U,S,V] = svd(double(img));
    end
    
    N = size(img,1); %sampling frequecy

    %FFT of first col of U
    U_fft = [];
    V_fft = [];
    for i = 1:num_sv
        y = abs(fft(U(:,1),N));
        U_fft = [U_fft; y(1:30)/sum(y(1:30))];
        
        %FFT of first col of V
        y = abs(fft(V(:,1),N));
        V_fft = [V_fft; y(1:30)/sum(y(1:30))];
    end

    desc = [U_fft; V_fft];
    
    %do rotation 45 degrees
    A = imrotate(img, 45,'crop');
    
    %only take non-black portion of image
    A = A(round(.16*size(img,1)):round(.84*size(img,2)),round(.16*size(img,1)):round(.84*size(img,2)));
    
    [U,S,V] = svd(double(A));
    
    N = 170;
    U_fft = [];
    V_fft = [];
    for i = 1:num_sv
        y = abs(fft(U(:,1),N));
        U_fft = [U_fft; y(1:30)/sum(y(1:30))];

        %FFT of first col of V
        y = abs(fft(V(:,1),N));
        V_fft = [V_fft; y(1:30)/sum(y(1:30))];
    end
    
    desc = [desc; U_fft; V_fft];
    
    %do rotation -45 degrees
    A = imrotate(img, -45,'crop');
    
    %only take non-black portion of image
    A = A(round(.16*size(img,1)):round(.84*size(img,2)),round(.16*size(img,1)):round(.84*size(img,2)));
    
    [U,S,V] = svd(double(A));
    
    N = 170;
    U_fft = [];
    V_fft = [];
    for i = 1:num_sv
        y = abs(fft(U(:,1),N));
        U_fft = [U_fft; y(1:30)/sum(y(1:30))];

        %FFT of first col of V
        y = abs(fft(V(:,1),N));
        V_fft = [V_fft; y(1:30)/sum(y(1:30))];
    end
    
    desc = [desc; U_fft; V_fft];

end