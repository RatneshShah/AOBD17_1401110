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

[Wpca, lambda] = eig(S);
lambda = diag(lambda);
[lambda, i] = sort(lambda, 'descend');
Wpca = Wpca(:,i);
U = Wpca(:,1:q);
lambda_diag = diag(lambda);
L = lambda_diag(1:q, 1:q);

sigma = sqrt(1/(d-q) * sum(lambda(q+1:d)));
W = U * sqrt(L - sigma^2*eye(q));

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

