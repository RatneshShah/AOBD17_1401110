filename = 'matrix.dat';
T = importdata(filename);
q = 2;
[N, d] = size(T);

for j = 1:d
    mu(j) = mean(T(:,j));
end

S = zeros(d);
for n = 1:N
    S = S + (T(n,:)' - mu') * (T(n,:)' - mu')';
end
S = 1/N * S;
[d, ~] = size(S);

% init
W = ones(d, q);
sigma = 1;
epsilon = 0.01;

% loop
while (true)
    M = W'*W + sigma^2 * eye(q);
    W_new = S*W*inv(sigma^2 * eye(q) + inv(M)*W'*S*W);
    sigma_new = sqrt(1/d * trace(S - S*W*inv(M)*W_new'));
    if(abs(sigma_new - sigma) < epsilon && max(max(abs(W_new - W))) < epsilon)
        break;
    end
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

axis([-3, 3, -3, 3])
for i = 1:N
    text(X(1,i), X(2,i), num2str(i));
end