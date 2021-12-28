function [ operator ] = updateU_TV( K_diag, r_ML, t_ML, z, operator, pra1, pra2 )
% Update variable u corresponding to line(10) from Algorithm 1.

sigma = pra1.sigma;
mu = pra1.mu;

tau1 = pra2.tau_1;
tau2 = pra2.tau_2;
iteration = pra2.iteration;

[Nr, Nc] = size(r_ML);
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

v3 = z - operator{3,1}.d;
v3_t = reshapeByRow(v3(1:N, 1), Nr, Nc);
v3_r = reshapeByRow(v3(N+1:2*N, 1), Nr, Nc);
[u_t, err1] = Chambolle_g3( v3_t, tau1/mu, 0.25, iteration );
[u_r, err2] = Chambolle_g3( v3_r, tau2/mu, 0.25, iteration );
u_t = reshapeByRow(u_t, [], 1);
u_r = reshapeByRow(u_r, [], 1);
operator{3,1}.u = [u_t; u_r];


v4 = z1 - operator{4,1}.d;
v4(v4<0) = 0;
operator{4,1}.u = v4;

end

