function [ u ] = best_g2( r_ML, t_ML, v, sigma, mu )
% The exact solution for the optimization problems in Algorithm 1 line (10)
% for j = 2.

% u = zeros(size(v));
% for i=1:size(u,1)
%     a = mu * v(i, 1) + r_ML(i, 1) * t_ML(i, 1) / sigma;
%     b = mu + r_ML(i, 1) / sigma;
%     u(i,1) = a/b;
% end
a = mu * v + r_ML.* t_ML / sigma;
b = mu + r_ML / sigma;
u = a./b;
end
