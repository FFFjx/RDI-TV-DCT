function [ Z ] = updateZ_TV( inverse_M_diag , K_diag , operator )
% Update variable z corresponding to line(7) from Algorithm 1.

m = size(inverse_M_diag, 1);
N = m/2;
Z = zeros(2*N, 1);
Z(N+1:2*N, 1) = Z(N+1:2*N, 1) + K_diag.*(operator{1,1}.u + operator{1,1}.d);
Z(1:N, 1) = Z(1:N, 1) + K_diag.*(operator{2,1}.u + operator{2,1}.d);
Z = Z + (operator{3,1}.u + operator{3,1}.d);
Z(1:N, 1) = Z(1:N, 1) + (operator{4,1}.u + operator{4,1}.d);
Z = inverse_M_diag.*Z;

end

