% This code calculates the error in recovering an image
% which is corrupted with noise, recovered using Robust PCA.
% Group-10
clc;
close all;
clear all;


% read image and corrupt the image using imnoise
img = double(imread('input_img.png'))/255;
msk = zeros(size(img));
%We calculate error for (10,20,30,40,50)% corrupted entries
n = 0.1:0.1:0.5;
for p=1:length(n)
    img_corrupted = imnoise(img,'salt & pepper',n(p));
    X = img_corrupted;
    
    % apply Robust PCA
    lambda = 0.0625;
    tic
    [L, S] = rpca(X, lambda, 1.0, 1e-6);
    toc
    
    % Reconstruct the image from the corruption in matrix
    img_reconstructed = zeros(size(img));
    img_noise = zeros(size(img));
    img_final = L;
    img_noise = S;
    img_cur = L+S;
    
    % Result  Plot
    figure,
    subplot(2,2,1), imshow(img_corrupted), title('Corrupted Image')
    subplot(2,2,2), imshow(img_final), title('Recovered Image')
    subplot(2,2,3), imshow(img_cur), title('Corrupted Image - L+S')
    subplot(2,2,3), imshow(img_noise), title('Noise Image')
    suptitle('Robust PCA implmentation for Corrupted Images');
    
    % Error Calculation
    [a(p),b(p),c(p),de(p)] = measerr(img,L);
end

% Error Plot
figure,plot(n*100,b);
title('Error plot for RPCA - Corrupted Entries');
xlabel('% of Corrupted Entries');
ylabel('Mean Square Error');
