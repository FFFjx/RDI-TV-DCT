function [ val ] = RSNR( true, estimated )
% RSNR calculation formula corresponding to Reference[1] P89 left side.

true = reshapeByRow(true, [], 1);
estimated = reshapeByRow(estimated, [], 1);
a = true.' * true;
b = (true - estimated).' * (true - estimated);
val = 10 * log10(a/b);

end

