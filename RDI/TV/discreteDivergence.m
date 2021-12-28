function [ d_p ] = discreteDivergence( p )
% Input:
% p:A [Nr, 2*Nc] matrix where [Nr, Nc] is the size of images.
% Output:
% d_p:Discrete Divergence of p, the size is [Nr, Nc].
[m, n] = size(p);
Nr = m;
Nc = n/2;
p1 = p(:, 1:Nc);
p2 = p(:, Nc+1:n);

d_p = zeros(Nr, Nc);
for i=1:Nr
    for j=1:Nc
        if i==1
            d_p1 = p1(i, j);
        elseif i==Nr
            d_p1 = - p1(i-1, j);
        else
            d_p1 = p1(i, j) - p1(i-1, j);
        end
        
        if j==1
            d_p2 = p2(i, j);
        elseif j==Nc
            d_p2 = - p2(i, j-1);
        else
            d_p2 = p2(i, j) - p2(i, j-1);
        end
        
        d_p(i, j) = d_p1 + d_p2;
    end
end

end

