function [cellClass, w] = Kohonen1(dim, N, K, N1, h, x, wold)
Nv = zeros(1, K);
s = zeros(dim, K);
nClass = zeros(2,K);
for n=1:N
    xn = x(:, n);
    
    minDist = 10000;
    bmu = 1;
    for k=1:K
        e = xn - wold(:, k);
        dist = e'*e;
        if(dist < minDist)
            minDist = dist;
            bmu = k;
        end
    end
    Nv(bmu) = Nv(bmu) + 1;
    s(:, bmu) = s(:, bmu) + xn; 
    
    if (n > N1)
        nClass(2, bmu) = nClass(2, bmu) + 1;
    else
        nClass(1, bmu) = nClass(1, bmu) + 1;
    end
end

cellClass = zeros(1,K);
for k=1:K
    if ( nClass(1, k) > nClass(2, k) )
        cellClass(k) = 1;
    else
        cellClass(k) = 2;
    end
end

w = zeros(dim, K);
for i=1:K
    htot = 0;
    for k=1:K
        htot = htot + h(i,k) * Nv(k);
        w(:,i) = w(:,i) + h(i,k) * s(:,k);
    end
    w(:,i) = w(:,i) / htot;
end