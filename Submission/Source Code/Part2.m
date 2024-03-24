clear; clc;
% close all;

%% Load image
% load camera.mat;
load lena512.mat;
N = size(im, 1);
figure; imagesc(im); 
colormap 'gray'; axis image; axis off; title('Original');
   
%% Parameter 
J = 5;
Compr = 0.10;

%% Transform
imTr = haar_dec(im, J);

%% Sort pixel
Pixel = reshape(imTr, N^2, 1);
Pixel = sort(abs(Pixel), 'descend');

%% Compression
for Compr = [0.20, 0.10, 0.05, 0.01]        
    % Compress
    thr = Pixel(round(Compr*N^2));
    imCp = imTr;
    for r = 1:N
        for c = 1:N
            if abs(imCp(r, c)) < thr, imCp(r, c) = 0; end
        end
    end
    % Reconstruct
    imRe = haar_rec(imCp, J);
    psnr = PSNR(im, imRe);
    % Display result
    figure; imagesc(imRe); 
    colormap 'gray'; axis image; axis off; title(['Compression = ', num2str(Compr*100), '%, PSNR = ', num2str(psnr), 'dB']);
end
