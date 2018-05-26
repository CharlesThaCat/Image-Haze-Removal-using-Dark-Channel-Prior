function [A] = AtmosphericLight(I,darkchannel,height,width)
% calculate the atmospheric light A of image I with size [height, width]

%%%%%%%%%%%%%%%%%%%%%% verison 1 (selection sort) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WARNING: This version only works for image in small size, since the time complexity of selection sort is O(N^2)
% tic;
% K = round(height*width*0.001);
% X = darkchannel(:);
% [corrsepond_index] = K_max_value(X, K);
% I_gray = rgb2gray(I); I_gray = I_gray(:);
% A = max(I_gray(corrsepond_index));
% toc;
%%%%%%%%%%%%%%%%%%%%%% verison 2 (quick sort) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic;
% K = round(height*width*0.001);
% X = darkchannel(:);
% I_gray = rgb2gray(I); I_gray = I_gray(:);
% [sorted_darkchannel]=quicksort(X);
% corrsepond_index = find(X == sorted_darkchannel(length(sorted_darkchannel)));
% A = max(I_gray(corrsepond_index));
% toc;
%%%%%%%%%%%%%%%%%%%%%% verison 3 (given sort function in MATLAB) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
K = round(height*width*0.001);
X = darkchannel(:);
I_gray = rgb2gray(I); I_gray = I_gray(:);
[~,corrsepond_index] = sort(X,'descend');                                   % http://www.ilovematlab.cn/thread-446974-1-1.html
A = max(I_gray(corrsepond_index));
A = double(A);
toc;
end

