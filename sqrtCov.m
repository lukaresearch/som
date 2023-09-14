function [log_detC, A, Bh] = sqrtCov(rho, n)

r = rho.^(linspace(0,n-1,n));
C = toeplitz(r);

[U,D] = eig(C);
d = diag(D);
sqrt_d = sqrt(d);
A = U * diag(sqrt_d);

log_detC = log(prod(d));
Bh = diag(1 ./ sqrt_d) * U';