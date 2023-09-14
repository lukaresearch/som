function [cellClass, w] = KohonenBatch(M, N1, x)
K = M*M;  % #neurons
dim = size(x, 1);
N = size(x, 2);

eps = 0.01;
maxIter = 50;

r = zeros(2, K); % 2D lattice
m = 0;
for i=0:M-1
    for k=0:M-1
        m = m + 1;
        r(:, m) = [i; k];
    end
end

h = zeros(K, K);
radius = 2;
cr = -0.5/(radius * radius);
for i=1:K
    for k=1:K
        tmp = r(:, i) - r(:, k);
        h(i, k) = exp(cr * tmp' * tmp);
    end
end

w = rand(dim, K);
for iter=0:maxIter
    wold = w;
    [cellClass, w] = Kohonen1(dim, N, K, N1, h, x, wold);
    
    err = 0.;
    for k=1:K
        e = w(:,k) - wold(:,k);
        err = err + e'*e;
    end    
    err = err / K;
    if err < eps
        break
    end
    fprintf("%d]  err = %f\n", iter, err);
end
%voronoi(w(1,:),w(2,:)), hold on