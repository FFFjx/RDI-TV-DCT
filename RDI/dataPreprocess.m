clear;clc;
% Preprocess the original data and save the output as '.mat' file.

% Parameters need to be set.
binWidth = 4000; % The bin width for the histogram.(Unit:ps)

s = load('2021-06-23_17-37-0.002-15-20-1800.mat');
A = cell2mat(struct2cell(s));
clear s;

tic
[ t_ML, r_ML, K_diag ] = preprocess( A, binWidth);
toc
load('true_06_23_20ms.mat')

figure(1);
subplot(1,2,1);
imagesc(t_ML*6e-4);
colorbar;
subplot(1,2,2);
imagesc(true_06_23_20ms*6e-4);
colorbar;
