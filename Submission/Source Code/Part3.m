clear; clc;
close all;

%% Load data
ecg = load('ecg_hfn.dat');

%% Parameter
Fs = 1e3;
T = (1:length(ecg))/Fs;
a = [1];
b = [0.25, 0.5, 0.25];

%% Filter
ecg2 = filter(b,a,ecg);

%% Display result
figure; hold on;
plot(T, ecg);
plot(T, ecg2, 'r');

%% Spectrum
Hs=spectrum.welch('Hamming', 1024);
ecg_psd = psd(Hs, ecg,'Fs',Fs);
ecg2_psd = psd(Hs, ecg2,'Fs',Fs);

figure; hold on;
plot(ecg_psd.Frequencies, 10*log10(ecg_psd.Data));
plot(ecg2_psd.Frequencies, 10*log10(ecg2_psd.Data), 'r');
