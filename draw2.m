function draw2(cellClass, w, x)

K = size(w, 2);
N = size(x, 2);

figure,   xlabel('x'), ylabel('y')
for n=1:N
    plot(x(1, n), x(2,n), 'k.'), hold on    
end

for k=1:K
    if (cellClass(k) == 1)
        plot(w(1, k), w(2,k), 'r*'), hold on
    else
        plot(w(1, k), w(2,k), 'g*'), hold on
    end
end

voronoi(w(1,:),w(2,:))
hold off