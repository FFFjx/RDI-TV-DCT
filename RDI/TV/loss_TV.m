function [ err, err1, err2 ] = loss_TV( K_diag, t_ML, r_ML, t, r, tau1, tau2, sigma )
% Loss function corresponding to the fomular(8) from the paper.

[Nr, Nc] = size(t_ML);
t = K_diag.*t;
r = K_diag.*r;
t = reshapeByRow(t, Nr, Nc);
r = reshapeByRow(r, Nr, Nc);
L = zeros(Nr, Nc);
for i = 1:Nr
    for j = 1:Nc
        if r(i, j)<=0
            continue;
        end
        L(i, j) = r(i, j) - r_ML(i, j).*(log(r(i, j)) - (t(i, j)-t_ML(i, j)).*(t(i, j)-t_ML(i, j))/(2*sigma));
    end
end
L = sum(sum(L));
err1 = L;

a = gradientTV( t );
TV_a = totalVariation( a );

b = gradientTV( r );
TV_b = totalVariation( b );
err2 = sum(sum(tau1*TV_a)) + sum(sum(tau2*TV_b));

err = err1 + err2;

end

