function [ u ] = best_g1( r_ML, v, mu )
% The exact solution for the optimization problems in Algorithm 1 line (10)
% for j = 1.

% u = zeros(size(v));
% for i=1:size(u,1)
%     u(i, 1) = mu * v(i, 1) - 1 + ...
%         sqrt((mu * v(i, 1) - 1)*(mu * v(i, 1) - 1)+4 * mu * r_ML(i, 1));
%     u(i, 1) = u(i, 1) / (2 * mu);
% end
u = mu * v - 1 + ...
    sqrt((mu * v - 1).*(mu * v - 1) + 4 * mu * r_ML);
u = u / (2 * mu);

end

