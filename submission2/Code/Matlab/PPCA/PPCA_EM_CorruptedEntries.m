% This code calculates Error and generates results by recovering
% an image which is corrupted by various %, recovery is done using
% Probabilistic PCA performed using EM algorithm 
% Group - 10

clc;
close all;
clear all;

% Read an Image
img1 = imread('input_img.png');
q = 20;%Eigenvalues
[N, d] = size(img1);
T1 = im2double(img1);
iter = 1000;
%The value of n1 is the % of corruption to be performed
n1 = 0.1:0.1:0.5;

for p = 1:length(n1)
    T = imnoise(T1,'salt & pepper',n1(p));
    for j = 1:d
        mu(j) = mean(T(:,j));
    end
    tic;
    S = zeros(d);
    for n = 1:N
        S = S + (T(n,:)' - mu') * (T(n,:)' - mu')';
    end
    S = 1/N * S;
    [d, ~] = size(S);
    
    % initialize W and sigma with random value
    W = randn(size(T,2),q);
    sigma = randn(1);
    epsilon = 0.001;
    
    for it = 1:iter
    % loop
        M = W'*W + sigma^2 * eye(q);
        W_new = S*W*inv(sigma^2 * eye(q) + inv(M)*W'*S*W);
        sigma_new = sqrt(1/d * trace(S - S*W*inv(M)*W_new'));
        W = W_new;
        sigma = sigma_new;
    end
    
    W = W_new;
    sigma = sigma_new;
    
    [N, d] = size(T);
    [~, q] = size(W);
    
    M = W'*W + sigma^2 * eye(q);
    for j = 1:d
        mu(j) = mean(T(:,j));
    end
    for i = 1:N
        Tnorm(i,:) = T(i,:) - mu;
    end
    
    X = inv(M) * W' * Tnorm';
    
    [~, N] = size(X);
    
    % Generate the recovered image
    rec = ((W/(W'*W)*M*X))';
    
    for j = 1:size(T,1)
        rec(j,1:size(T,2)) = (rec(j,1:size(T,2))+mu(1:size(T,2)));
    end
    time(p)=toc;
    % All the results are plotted
    figure,
    subplot(2,2,1),imshow(img1),title('Input Image')
    subplot(2,2,2),imshow(T),title('Corrupted Image')
    subplot(2,2,3),imshow(rec),title('Recovered Image')
    suptitle('PPCA - EM for Corrupted Values');
    Error = norm(rec-T1);
    fprintf('Bishop Error: %f\n',Error);
    
    [a(p),b(p),c(p),de(p)] = measerr(T1,rec);
    r(p)=Error;
end

% Plot MSE
figure,plot(n1*100,b);
title('Error Plot for Corrupted Entries using PPCA-EM');
xlabel('% of Corrupted Entries');
ylabel('Mean Square Error');

%Plot Error calculated using Norm
figure,plot(n1*100,r);
title('Error for Corrupted Entries using PPCA-EM');
xlabel('% of Corrupted Entries');
ylabel('Norm Error');

% figure,plot(n1*100,time);
% title('Time taken for recovering Corrupted Entries using PPCA-EM');
% xlabel('% of Corrupted Entries');
% ylabel('Time in seconds');

