function [ operator ] = updateD_DCT( K_diag, z, operator )
% Update variable d corresponding to line(13) from Algorithm 1.

m = size(z, 1);
N = m/2;
z1 = z(1:N, 1);
z2 = z(N+1:2*N, 1);
operator{1,1}.d = operator{1,1}.d - (K_diag.*z2 - operator{1,1}.u);
operator{2,1}.d = operator{2,1}.d - (K_diag.*z1 - operator{2,1}.u);
u1 = DCToperation( z1, 1 );
u2 = DCToperation( z2, 1 );
u = [u1; u2];
operator{3,1}.d = operator{3,1}.d - (u - operator{3,1}.u);
operator{4,1}.d = operator{4,1}.d - (z1 - operator{4,1}.u);

end

