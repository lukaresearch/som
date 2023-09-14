function [xmean, Cx, xd] = sampleGen(d, N, mu_v, A)

xmean = 0.;
xd = zeros(d, N);
Cx = zeros(d);
for k=1:N
    y = randn(d,1);       % y ~ Normal(0,I)
    x0 = A * y;
    x = x0 + mu_v;      % x ~ Normal(mu_v, A*Ah)
    xd(:, k) = x;

    Cx = Cx + x0 * x0';
    xmean = xmean + x;
end
xmean = xmean / N;
Cx = Cx / N;