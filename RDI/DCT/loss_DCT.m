function [ err, err1, err2 ] = loss_DCT( K_diag, t_ML, r_ML, t, r,...
    tau1, tau2, sigma )
% The loss function with RDI-DCT, which is divided to 3 parts, the total
% loss, the g1, g2 loss and the DCT loss.

[Nr, Nc] = size(t_ML);
t_DCT = DCToperation(t, 1);
r_DCT = DCToperation(r, 1);
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
        L(i, j) = r(i, j) - r_ML(i, j).*(log(r(i, j)) - ...
            (t(i, j) - t_ML(i, j)).*(t(i, j) - t_ML(i, j))/(2 * sigma));
    end
end
L = sum(sum(L));
err1 = L;

err2 = tau1*sum(abs(t_DCT)) + tau2*sum(abs(r_DCT));

err = err1 + err2;

end

