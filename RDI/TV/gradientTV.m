function [ g_u ] = gradientTV( u )
% Input:
% u:A [Nr, Nc] matrix where [Nr, Nc] is the size of images.
% Output:
% g_u:Gradient for total variation of u, the size is [Nr, 2*Nc].
[Nr, Nc] = size(u);
g_u1 = zeros(Nr, Nc);
g_u2 = zeros(Nr, Nc);

for i=1:Nr
    for j=1:Nc
        if i~=Nr
            g_u1(i, j) = u(i+1, j) - u(i, j);
        end
    end
end
for i=1:Nr
    for j=1:Nc
        if j~=Nc
            g_u2(i, j) = u(i, j+1) - u(i, j);
        end
    end
end

g_u = [g_u1, g_u2];

end

