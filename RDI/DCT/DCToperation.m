function [ Dt ] = DCToperation( t, flag )
% Realize a DCT operation for a column vector t.
% t: The target of DCT operation. It should be a [N*N, 1] column vector, 
% which is transformed by a [N, N] square matrix.
% flag=1: DCT operation
% flag=0: inverse DCT operation

N = sqrt(size(t,1));
Dt = reshapeByRow(t, N, N);
if flag==1
    Dt = dct(Dt);
elseif flag==0
    Dt = idct(Dt);
end
Dt = reshapeByRow(Dt, [], 1);

end

