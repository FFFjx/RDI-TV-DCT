function [ mpo ] = softThreshold( v, lambda )
% Corresponding to formula(24) in reference[2]. It is applied to the
% situation that g_j function is a L1 norm.
mpo = sign(v).*max(abs(v)-lambda, 0);

end

