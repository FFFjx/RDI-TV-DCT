function [ operator ] = updateD_TV( K_diag, z, operator )
% Update variable d corresponding to line(13) from Algorithm 1.

m = size(z, 1);
N = m/2;
z1 = z(1:N, 1);
z2 = z(N+1:2*N, 1);
operator{1,1}.d = operator{1,1}.d - (K_diag.*z2 - operator{1,1}.u);
operator{2,1}.d = operator{2,1}.d - (K_diag.*z1 - operator{2,1}.u);
operator{3,1}.d = operator{3,1}.d - (z - operator{3,1}.u);
operator{4,1}.d = operator{4,1}.d - (z1 - operator{4,1}.u);

end

