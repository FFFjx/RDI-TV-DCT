function [ z1, z2, err_gather ] = model_TV( K_diag, t_ML, r_ML, pra )
% The model of TV regularization optimization.

[Nr, Nc] = size(t_ML);
N = Nr * Nc;

% Input normalization.
t_scaler = max(max(t_ML));
r_scaler = max(max(r_ML));
t_ML = t_ML/max(max(t_ML));
r_ML = r_ML/max(max(r_ML));

z1 = reshapeByRow(t_ML, [], 1);
z2 = reshapeByRow(r_ML, [], 1);
operator = cell(4, 1);
operator{1,1}.u = K_diag.*z2;
operator{2,1}.u = K_diag.*z1;
operator{3,1}.u = [z1; z2];
operator{4,1}.u = z1;
for i=1:4
    operator{i,1}.d = zeros(size(operator{i,1}.u));
end
M_diag = zeros(2*N, 1);
M_diag(1:N, 1) = 2 * ones(N, 1) + K_diag;
M_diag(N+1:2*N, 1) = ones(N, 1) + K_diag;
inverse_M_diag = ones(2*N, 1)./M_diag;

iteration = pra{1,1}.iteration;
err_gather = zeros(3, iteration);
for k=1:iteration
    if k==1
        z_pre = updateZ_TV( inverse_M_diag , K_diag , operator );
    else
        z_pre = z;
    end 
    
    operator = updateU_TV(K_diag, r_ML, t_ML, z_pre, operator, pra{1,1}, pra{1,2} );
    operator = updateD_TV(K_diag, z_pre, operator);
    z = updateZ_TV( inverse_M_diag , K_diag , operator );
    
    t = z(1:N, 1);
    r = z(N+1:2*N, 1);
    [ err, err1, err2 ] = loss_TV( K_diag, t_ML, r_ML, t, r, pra{1,2}.tau_1, ...
        pra{1,2}.tau_2, pra{1, 1}.sigma );
    err_gather(1, k) = err;
    err_gather(2, k) = err1;
    err_gather(3, k) = err2;
    
end

% Reverse normalization.
z1 = reshapeByRow(z(1:N, 1), Nr, Nc);
z2 = reshapeByRow(z(N+1:2*N, 1), Nr, Nc);
z1 = z1 * t_scaler;
z2 = z2 * r_scaler;

end

