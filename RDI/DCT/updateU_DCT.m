function [ operator ] = updateU_DCT( K_diag, r_ML, t_ML, z, operator, pra1, pra2 )
% Update variable u corresponding to line(10) from Algorithm 1.

sigma = pra1.sigma;
mu = pra1.mu;

tau1 = pra2.tau_1;
tau2 = pra2.tau_2;

m = size(z, 1);
N = m/2;
z1 = z(1:N, 1);
z2 = z(N+1:2*N, 1);
r_ML = reshapeByRow(r_ML, [], 1);
t_ML = reshapeByRow(t_ML, [], 1);

v1 = K_diag.*z2 - operator{1,1}.d;
[ u ] = best_g1( r_ML, v1, mu );
operator{1,1}.u = u;

v2 = K_diag.*z1 - operator{2,1}.d;
[ u ] = best_g2( r_ML, t_ML, v2, sigma, mu );
operator{2,1}.u = u;

v3_t = DCToperation(z1, 1) - operator{3,1}.d(1:N, 1);
v3_r = DCToperation(z2, 1) - operator{3,1}.d(N+1:2*N, 1);
v3_t = softThreshold(v3_t, tau1/mu);
v3_r = softThreshold(v3_r, tau2/mu);
operator{3,1}.u = [v3_t; v3_r];

v4 = z1 - operator{4,1}.d;
v4(v4<0) = 0;
operator{4,1}.u = v4;

end

