function [ t_ML, r_ML, K_diag ] = preprocess( A, binWidth )
% Preprocess the original TOF data, and output t_ML, r_ML and K_diag
% according to the paper.

[Nr, Nc] = size(A);
t_ML = zeros(Nr, Nc);
r_ML = zeros(Nr, Nc);
K_diag = zeros(Nr, Nc);

for i=1:Nr
    for j=1:Nc
        if isempty(A(i,j).TOF)
            continue;
        end
        K_diag(i, j) = 1;
        r_ML(i,j) = length(A(i,j).TOF);
        
        % Deal with the situation that length(A(i, j).TOF) = 1.
        if length(A(i,j).TOF)==1
            t_ML(i, j) = A(i, j).TOF(1, 1);
            continue;
        end
        base = min(A(i, j).TOF);
        T = (max(A(i, j).TOF) - base) / binWidth;
        T = ceil(T);
        
        x = (base + binWidth/2):binWidth:(base + binWidth*T);
        n = hist(A(i, j).TOF, x);
        range = 1:1:T;
        a = sum(n.*range)/r_ML(i,j);

        t_ML(i, j) = a*binWidth - binWidth/2 + base;
    end
end
K_diag = reshapeByRow(K_diag, [], 1);

end

