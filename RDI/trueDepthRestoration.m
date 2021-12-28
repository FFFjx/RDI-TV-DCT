function [ true ] = trueDepthRestoration( true )
% Settle the NaN problem in true depth images.

[Nr, Nc] = size(true);
for i=1:Nr
    for j=1:Nc
        if isnan(true(i, j))
           count = 0;
           total = 0;
           if j+1<=Nc&&~isnan(true(i, j+1))
               total = total + true(i, j+1);
               count = count + 1;
           end
           if j-1>=1&&~isnan(true(i, j-1))
               total = total + true(i, j-1);
               count = count + 1;
           end  
           if i-1>=1&&~isnan(true(i-1, j))
               total = total + true(i-1, j);
               count = count + 1;
           end 
           if i+1<=Nr&&~isnan(true(i+1, j))
               total = total + true(i+1, j);
               count = count + 1;
           end 
           if i-1>=1&&j-1>=1&&~isnan(true(i-1, j-1))
               total = total + true(i-1, j-1);
               count = count + 1;
           end 
           if i-1>=1&&j+1<=Nc&&~isnan(true(i-1, j+1))
               total = total + true(i-1, j+1);
               count = count + 1;
           end 
           if i+1<=Nr&&j-1>=1&&~isnan(true(i+1, j-1))
               total = total + true(i+1, j-1);
               count = count + 1;
           end
           if i+1<=Nr&&j+1<=Nc&&~isnan(true(i+1, j+1))
               total = total + true(i+1, j+1);
               count = count + 1;
           end
           true(i, j) = total/count; 
        end
    end
end


end

