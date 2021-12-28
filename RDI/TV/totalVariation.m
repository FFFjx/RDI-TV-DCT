function [ TV_u ] = totalVariation( g_u )
% Input:
% g_u:Denotes the gradient of an image u. It is a [Nr, 2*Nc] matrix where 
% [Nr, Nc] is the size of images.
% Output:
% TV_u:Total variation matrix of g_u, the size is [Nr, Nc].
[m, n] = size(g_u);
Nr = m;
Nc = n/2;
g_u1 = g_u(:, 1:Nc);
g_u2 = g_u(:, Nc+1:n);
% TV_u = zeros(Nr, Nc);
% 
% for i=1:Nr
%     for j=1:Nc
%         TV_u(i, j) = sqrt(g_u1(i, j)*g_u1(i, j) + g_u2(i, j)*g_u2(i, j));
%     end
% end
TV_u = sqrt(g_u1.*g_u1 + g_u2.*g_u2);

end

