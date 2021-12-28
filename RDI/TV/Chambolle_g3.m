function [ u, err ] = Chambolle_g3( g, lambda, tau, iteration )
% Chambolle Algorithm reproducted by reference[4]. It is applied to
% minimize total variation like 

[Nr, Nc] = size(g);
p = rand(Nr, 2*Nc);
err = zeros(1, iteration);
for i=1:iteration
    d_p = discreteDivergence(p);
    u = d_p - g/lambda;
    a = gradientTV( u );
    TV_u = totalVariation( a );
    b = [TV_u, TV_u];
    p = (p + tau*a)./(1 + tau*b);
    
%     % This section is used to check the loss of Chambolle Algorithm.
%     d_p = discreteDivergence(p);
%     u = g - lambda * d_p;
%     s = reshapeByRow(u - g, [], 1);
%     a = gradientTV( u );
%     TV_u = totalVariation( a );
%     loss = (s.'*s/(2*lambda) + sum(sum(TV_u)))/(Nr * Nc);
%     err(1, i) = loss;
end
d_p = discreteDivergence(p);
u = g - lambda * d_p;

end

