% This Code calculates the Error ing recovering an image
% with missing entries using Robust PCA method
% Group-10
clc
clear 
close all
% Reading Image
img1 = imread('input_img.png');
% This below values are calculated to generate (10,20,30,40,50)% missing values
% for a 256 x 256 Image
missing_entries = [6554,13107,19661,26214,32768];

% Calculating error for range of missing entries
for m = 1:length(missing_entries)
    
    r = randi(256,missing_entries(m),2);
    [r1,c1] = size(r);
    img = im2double(img1);
    
    for i=1:r1
        img(r(i,1),r(i,2))=NaN;
    end
    
    figure,
    subplot(2,2,1),imshow(img),title('Image with Missing Values');
    % Robust PCA
    lambda = 0.0625;
    tic;
    [L, S] = rpca(img, lambda, 1.0, 1e-8);
    time(m)=toc;
    subplot(2,2,2),imshow(L),title('Recovered Image'),
    subplot(2,2,3),imshow(S),title('Sparse Image');
    suptitle('RPCA for Missing Entries');
    % MSE Error Calculation
    [a(m),b(m),c(m),d(m)] = measerr(img1,L);
end
missing_entr = 0.1:0.1:0.5;
figure,plot(100*missing_entr,b);
title('Error Plot for missing values recovered using RPCA');
xlabel('% entries missing');
ylabel('Mean Square Error');




% figure,plot(100*missing_entr,time);
% title('Time taken for missing values recovered using RPCA');
% xlabel('% entries missing');
% ylabel('Time in seconds');
