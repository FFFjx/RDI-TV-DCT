function [ im_true ] = trueDepth_v2( A, m_data, threshold )
% Given a Lidar waveform A[Nr, Nc]. Seek its true depth images.

[Nr, Nc] = size(A);
im_true = zeros(Nr, Nc);
for i=1:Nr
    for j=1:Nc
        % If length(A(i,j).TOF)==0, it's a noise.
        if isempty(A(i,j).TOF)
            im_true(i, j) = nan;
            continue;
        end
        
        % Build hisogram by total time bins = 100.
        [c, d] = hist(A(i, j).TOF, 100);
        
        % Find index of peak.
        peak_index = find(c==max(c));
        
        % Deal with the situation that more than 1 peak in the given 
        % histogram. Preserve the 1 peaks lied in the middle.
        if length(peak_index)>1
            redundant = length(peak_index) - 1;
            redundant_front = floor(redundant / 2);
            peak_index = peak_index(1, redundant_front+1);
        end
        
        % Calculate true depth for each pixel(i, j)
        % Find the index that satisfied [t_med-m_data, t_med+m_data]
        index = A(i, j).TOF<=(d(peak_index(1, 1)) + m_data)...
                & A(i, j).TOF>=(d(peak_index(1, 1)) - m_data);
        total = sum(A(i, j).TOF(index));
        count = length(index);
        
        if count<threshold
            im_true(i, j) = nan;
            continue;
        end
        
        im_true(i, j) = total / count;
    end
end

end

