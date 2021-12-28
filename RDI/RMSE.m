function [ val ] = RMSE( true, estimated )
% RMSE calculation formula.

[Nr, Nc] = size(true);
mat = (true - estimated).*(true - estimated);
val = sqrt(sum(sum(mat/(Nr * Nc))));

end

