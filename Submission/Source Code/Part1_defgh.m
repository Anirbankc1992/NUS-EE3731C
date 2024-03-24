% Part 1. Image Denoising
% d, e, f, g, h
% 1. Load image camera
% 2. Add noise with difference power
% 3. Perform Haar wavelet transform
% 4. Threshold detail with smal magnitude 
% 5. Perform inverse Harr wavelet transform, compute PSNR
% 6. Display results

%% Init
clear; clc; rng('shuffle');
close all;

%% Load image
load camera.mat;
N = size(im, 1);
   
%% Parameter 
J = 4;
SigmaArr = 10:10:80;

%% Denoise
PSNR_Before = zeros(1, length(SigmaArr));
PSNR_After = zeros(1, length(SigmaArr));
imRe = zeros(length(SigmaArr), N, N);
imNi = zeros(length(SigmaArr), N, N);
for i = 1:length(SigmaArr)
    % Progress
    clc; disp(i/length(SigmaArr));
    % Add noise
    Sigma = SigmaArr(i); 
    imNi(i, :, :) = im + randn(size(im))*Sigma;
    PSNR_Before(i) = PSNR(im, squeeze(imNi(i, :, :)));
    % Transform
    imTr = haar_dec(squeeze(imNi(i, :, :)), J);
    % Threshold        
    thr = 3*Sigma;
    imTr2 = imTr.*(abs(imTr)>=thr);    
    % Reconstruction
    imRe(i, :, :) = haar_rec(imTr2, J);
    PSNR_After(i) = PSNR(im, squeeze(imRe(i, :, :)));
end

%% Display result
for i = 1:length(SigmaArr)
    figure;
    subplot(1, 2, 1); imagesc(squeeze(imNi(i, :, :)));
    colormap 'gray'; axis image; axis off; title(['Noisy, \sigma = ', num2str(SigmaArr(i)), ', PSNR = ', num2str(PSNR_Before(i))]);
    subplot(1, 2, 2); imagesc(squeeze(imRe(i, :, :)));
    colormap 'gray'; axis image; axis off; title(['Denoised, \sigma = ', num2str(SigmaArr(i)), ', PSNR = ', num2str(PSNR_After(i))]);     
end
figure; hold on;
xlabel('Noise STD, \sigma');
ylabel('PSNR');
title('PSNR vs. Noise STD, With & Without Wavelet Transform Denoising');
h1 = plot(SigmaArr, PSNR_Before, 'LineWidth', 2.5, 'Color', 'r');
h2 = plot(SigmaArr, PSNR_After,  'LineWidth', 2.5, 'Color', 'b');
legend([h1, h2], 'Without Wavelet Denoising', 'With Wavelet Denoising');
