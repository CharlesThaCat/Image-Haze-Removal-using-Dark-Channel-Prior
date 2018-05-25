function [A] = AtmosphericLight(I,darkchannel,height,width)
% calculate the atmospheric light A of image I with size [height, width]

%%%%%%%%%%%%%%%%%%%%%% verison 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic;
% K = round(height*width*0.001);
% X = darkchannel(:);
% [corrsepond_index] = K_max_value(X, K);                                   % 这里用selection sort，改成用时间复杂度更快的排序算法会不会更好？
% I_gray = rgb2gray(I); I_gray = I_gray(:);
% A = max(I_gray(corrsepond_index));
% toc;
%%%%%%%%%%%%%%%%%%%%% verison 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic;
% A = max(max(darkchannel));
% toc;
%%%%%%%%%%%%%%%%%%%%%% verison 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic;
% maxAtomsLight = 240;
% A = min([maxAtomsLight, max(max(darkchannel))]);
% toc;
%%%%%%%%%%%%%%%%%%%%%% verison 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic;
% K = round(height*width*0.001);
% X = darkchannel(:);
% I_gray = rgb2gray(I); I_gray = I_gray(:);
% [sorted_darkchannel]=quicksort(X);
% corrsepond_index = find(X == sorted_darkchannel(length(sorted_darkchannel)));
% A = max(I_gray(corrsepond_index));
% toc;
%%%%%%%%%%%%%%%%%%%%%% verison 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
K = round(height*width*0.001);
X = darkchannel(:);
I_gray = rgb2gray(I); I_gray = I_gray(:);
[~,corrsepond_index] = sort(X,'descend');                                   % http://www.ilovematlab.cn/thread-446974-1-1.html
A = max(I_gray(corrsepond_index));
A = double(A);
toc;
end

