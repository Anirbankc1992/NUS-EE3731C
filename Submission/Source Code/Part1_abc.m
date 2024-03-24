% Part 1. Image Denoising
% a, b, c
% 1. Load image camera
% 2. Perform Haar wavelet transform
% 3. Perform inverse Harr wavelet transform
% 4. Display results

%% Init
clear; clc; 
close all;

%% Parameters
J = 3;

%% Load image
load camera.mat;

%% Perform Haar wavelet transform
imTr = haar_dec(im, J);

%% Perform inverse iHaar wavelet transform
imRe = haar_rec(imTr, J);

%% Plot results
figure; imagesc(im); 
colormap 'gray'; axis image; axis off; title('Original');
figure; imagesc(imTr); 
colormap 'lines'; axis image; axis off; title(['Wavelet Transform, J = ', num2str(J)]);
figure; imagesc(imRe); 
colormap 'gray'; axis image; axis off; title('Reconstruction');
     