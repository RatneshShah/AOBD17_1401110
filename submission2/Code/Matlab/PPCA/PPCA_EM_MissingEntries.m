% This Code performs calculation of Error in recovering an Image containing
% missing entries by using Probabilistic PCA approach calculated using EM
% Group - 10
clc
clear all
close all
%Read an Image
img1 = imread('input_img.png');
missing_entries = [6554,13107,19661,26214,32768];
for m = 1:length(missing_entries)
    r = randi(256,missing_entries(m),2);
    [r1,c1] = size(r);
    img = im2double(img1);
    for i=1:r1
        img(r(i,1),r(i,2))=NaN;
    end
    figure,
    subplot(1,2,1),imshow(img),title('Image with Missing Entries')
    [a,b,c,d,e]=ppca_mv(img,20,1);
    subplot(1,2,2),imshow(e),title('Recovered Image');
    suptitle('PPCA EM for Missing Values');   
    [p(m),q(m),r(m),s(m)]= measerr(img1,e);
end
miss_per = 100*(0.1:0.1:0.5);
figure,plot(miss_per,q);
title('Error Plot for Recovering Image having Missing Entries using PPCA - EM');
xlabel('% of Missing Values');
ylabel('Mean Square Error');