function [rmse_score] = RMSE(A1,A2)
% average root-mean-square error between A1 and A2
% A1 is the normalized ground truth array
% A2 is the normalized estimated array
RMSE_array = sqrt(((A2-A1).^2)./3);
rmse_score = mean(RMSE_array(:));
end