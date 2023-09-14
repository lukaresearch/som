function p = Pe(class, cellClass, x, w)

dim = size(x, 1);
N = size(x, 2);
K = size(w, 2);

err = 0;
for n=1:N
    xn = x(:, n);    
    minDist1 = 10000;
    minCell = 1;
    for k=1:K
        e = xn - w(:, k);
        dx = e'*e;
        if(minDist1 > dx)
            minDist1 = dx;
            minCell = k;
        end
    end
    
    if(class ~= cellClass(minCell))
        err = err + 1;
    end
end
p = err / N;      