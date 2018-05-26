function [corrsepond_index] = K_max_value(X, K)
% give the K max value of array X
% selection sort -- time complexity O(n^2)
index = 1;
corrsepond_index = zeros(1,length(X));
for i = 1:length(X)
    max_grad = X(i);
    for j = 1:length(X)
        if j ~= i
            if X(j) >= max_grad
                max_grad = X(j);
                index = j;
            end
        end
    end
    corrsepond_index(i) = index;
    X(index) = 0;
end
corrsepond_index = corrsepond_index(1:K);
end
