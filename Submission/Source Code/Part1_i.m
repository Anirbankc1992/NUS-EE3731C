% Part 1. Image Denoising
% i
% 1. Load image camera
% 2. Add noise with difference power
% 3. Perform Haar wavelet transform
% 4. Threshold detail with smal magnitude using 2 methods:
%    hard-thresholding; soft-thresholding; and ABE
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
PSNR_AfterHard = zeros(1, length(SigmaArr));
PSNR_AfterSoft = zeros(1, length(SigmaArr));
PSNR_AfterABE  = zeros(1, length(SigmaArr));
imReHard = zeros(length(SigmaArr), N, N);
imReSoft = zeros(length(SigmaArr), N, N);
imReABE  = zeros(length(SigmaArr), N, N);
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
    % (i) - Hard-thresholding       
    thr = 3*Sigma;
    imTr2Hard = imTr.*(abs(imTr)>=thr);    
    % (ii) - Soft-thresholding
    thr = 3*Sigma;
    imTr2Soft = sign(imTr).*(abs(imTr)-thr).*(abs(imTr)>=thr);   
    % (iii) - ABE
    thr = Sigma*sqrt(3);
    imTr2ABE  = (abs(imTr)>=thr).*(imTr-thr^2./imTr);
    % Reconstruction
    imReHard(i, :, :) = haar_rec(imTr2Hard, J);
    imReSoft(i, :, :) = haar_rec(imTr2Soft, J);
    imReABE(i, :, :)  = haar_rec(imTr2ABE,  J);
    PSNR_AfterHard(i) = PSNR(im, squeeze(imReHard(i, :, :)));
    PSNR_AfterSoft(i) = PSNR(im, squeeze(imReSoft(i, :, :)));
    PSNR_AfterABE(i)  = PSNR(im, squeeze(imReABE(i, :, :)));
end

%% Display result
i = 2;
figure;
subplot(1, 2, 1); imagesc(im);
colormap 'gray'; axis image; axis off; title('Original');
subplot(1, 2, 2); imagesc(squeeze(imNi(i, :, :)));
colormap 'gray'; axis image; axis off; title(['Noisy, \sigma = 20, PSNR = ', num2str(PSNR_Before(i))]);
figure;
subplot(1, 3, 1); imagesc(squeeze(imReHard(i, :, :)));
colormap 'gray'; axis image; axis off; title(['Hard-Threshold, PSNR = ', num2str(PSNR_AfterHard(i))]);
subplot(1, 3, 2); imagesc(squeeze(imReSoft(i, :, :)));
colormap 'gray'; axis image; axis off; title(['Soft-Threshold, PSNR = ', num2str(PSNR_AfterSoft(i))]);
subplot(1, 3, 3); imagesc(squeeze(imReABE(i, :, :)));
colormap 'gray'; axis image; axis off; title(['ABE, PSNR = ', num2str(PSNR_AfterABE(i))]);

figure; hold on;
xlabel('Noise STD, \sigma');
ylabel('PSNR');
h1 = plot(SigmaArr, PSNR_Before,    'LineStyle', '--', 'LineWidth', 2.5, 'Color', 'k');
h2 = plot(SigmaArr, PSNR_AfterHard, 'LineStyle', '-',  'LineWidth', 2.5, 'Color', [0.3, 0.3, 0.3]);
h3 = plot(SigmaArr, PSNR_AfterSoft, 'LineStyle', '-',  'LineWidth', 2.5, 'Color', [0.6, 0.6, 0.6]);
h4 = plot(SigmaArr, PSNR_AfterABE,  'LineStyle', '-',  'LineWidth', 2.5, 'Color', [0, 0, 0]);
legend([h1, h2, h3, h4], 'Noisy', 'Hard-Thresholding', 'Soft-Thresholding', 'ABE');
