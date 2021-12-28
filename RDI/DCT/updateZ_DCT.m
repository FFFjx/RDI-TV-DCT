function [ Z ] = updateZ_DCT( inverse_M_diag , K_diag , operator )
% Update variable z corresponding to line(7) from Algorithm 1.

m = size(inverse_M_diag, 1);
N = m/2;
Z = zeros(2*N, 1);
Z(N+1:2*N, 1) = Z(N+1:2*N, 1) + K_diag.*(operator{1,1}.u + operator{1,1}.d);
Z(1:N, 1) = Z(1:N, 1) + K_diag.*(operator{2,1}.u + operator{2,1}.d);
xi_t = operator{3,1}.u(1:N, 1) + operator{3,1}.d(1:N, 1);
xi_r = operator{3,1}.u(N+1:2*N, 1) + operator{3,1}.d(N+1:2*N, 1);
Dxi_1 = DCToperation( xi_t, 0 );
Dxi_2 = DCToperation( xi_r, 0 );
Dxi = [Dxi_1; Dxi_2];
Z = Z + Dxi;
Z(1:N, 1) = Z(1:N, 1) + (operator{4,1}.u + operator{4,1}.d);
Z = inverse_M_diag.*Z;

end

