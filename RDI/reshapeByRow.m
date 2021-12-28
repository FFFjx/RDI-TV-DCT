function [ a ] = reshapeByRow( A, m, n )
% Realize a simple reshape function arrange by row.

a = reshape(A.', n, m).';

end

