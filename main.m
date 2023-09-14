clear all; close all

M = 2:16;
N = 100000;
d = 50;
Nhalf = N/2;

rho1 = 0.9;
mu1 = 0;
rho2 = 0.7;
mu2 = 0.5;

[log_detC1, A1, Bh1] = sqrtCov(rho1, d);
mv1 = mu1 * ones(d,1);

[log_detC2, A2, Bh2] = sqrtCov(rho2, d);
mv2 = mu2 * ones(d,1);

[xmean1, Cx1, x1] = sampleGen(d, N, mv1, A1);
[xmean2, Cx2, x2] = sampleGen(d, N, mv2, A2);

Pe1 = zeros(1, length(M));
Pe2 = zeros(1, length(M));
K = M .* M;
for i = 1:length(M)
    fprintf("\n[%d] #weight = %d\n", i, K(i));
    [cellClass, w] = KohonenBatch(M(i), Nhalf, [x1(:, 1:Nhalf), x2(:, 1:Nhalf)]);
    Pe1(i) = Pe(1, cellClass, x1(:, Nhalf+1:N), w);
    Pe2(i) = Pe(2, cellClass, x2(:, Nhalf+1:N), w);
    %draw2(cellClass, w,  [x1(:, 1:Nhalf), x2(:, 1:Nhalf)]);
end

plot(K, Pe1, 'b-', K, Pe2, 'r-.'), legend('class-1', 'class-2'), ...
    xlabel('#weights'), ylabel('P(error)'), title('Kohonen')