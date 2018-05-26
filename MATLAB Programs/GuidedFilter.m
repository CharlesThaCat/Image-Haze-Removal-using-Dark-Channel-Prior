function [q] = GuidedFilter(p,I,r,epsilon)
% implementation of guided filter in 2D
% time complexity: O()
% p: filtering input image, for dehazing application, p should be gray
% scale image
% I: guidance image, for dehazing application, I should be RGB image
% r: radius of local window
% epsilon: regularization parameter
% q: filtering output

[height,width] = size(p);
q = zeros(height,width);

mean_I_R = imboxfilt(I(:, :, 1), r);
mean_I_G = imboxfilt(I(:, :, 2), r);
mean_I_B = imboxfilt(I(:, :, 3), r);

mean_p = imboxfilt(p(:, :), r);

corr_I_R = imboxfilt(I(:, :, 1).*I(:, :, 1), r);
corr_I_G = imboxfilt(I(:, :, 2).*I(:, :, 2), r);
corr_I_B = imboxfilt(I(:, :, 3).*I(:, :, 3), r);

corr_Ip_R = imboxfilt(I(:, :, 1).*p(:, :), r);
corr_Ip_G = imboxfilt(I(:, :, 2).*p(:, :), r);
corr_Ip_B = imboxfilt(I(:, :, 3).*p(:, :), r);

var_I_R = corr_I_R - mean_I_R.* mean_I_R;
var_I_G = corr_I_G - mean_I_G.* mean_I_G;
var_I_B = corr_I_B - mean_I_B.* mean_I_B;

cov_Ip_R = corr_Ip_R - mean_I_R.*mean_p;
cov_Ip_G = corr_Ip_G - mean_I_G.*mean_p;
cov_Ip_B = corr_Ip_B - mean_I_B.*mean_p;

a_R = cov_Ip_R./(var_I_R + epsilon);
a_G = cov_Ip_G./(var_I_G + epsilon);
a_B = cov_Ip_B./(var_I_B + epsilon);

b_R = mean_p - a_R.*mean_I_R;
b_G = mean_p - a_G.*mean_I_G;
b_B = mean_p - a_B.*mean_I_B;

mean_a_R = imboxfilt(a_R, r);
mean_a_G = imboxfilt(a_G, r);
mean_a_B = imboxfilt(a_B, r);

mean_b_R = imboxfilt(b_R, r);
mean_b_G = imboxfilt(b_G, r);
mean_b_B = imboxfilt(b_B, r);

q(:, :, 1) = mean_a_R.*I(:, :, 1) + mean_b_R;
q(:, :, 2) = mean_a_G.*I(:, :, 2) + mean_b_G;
q(:, :, 3) = mean_a_B.*I(:, :, 3) + mean_b_B;

q = rgb2gray(q);

end

