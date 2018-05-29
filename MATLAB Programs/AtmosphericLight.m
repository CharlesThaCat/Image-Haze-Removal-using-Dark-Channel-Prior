function [A] = AtmosphericLight(I,darkchannel,height,width)
% calculate the atmospheric light A of image I with size [height, width]

%%%%%%%%%%%%%%%%%%%%%% verison 1 (selection sort) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WARNING: This version only works for image in small size, since the time complexity of selection sort is O(N^2)
% K = round(height*width*0.001);
% X = darkchannel(:);
% [corrsepond_index] = K_max_value(X, K);
% I_gray = rgb2gray(I); I_gray = I_gray(:);
% A = max(I_gray(corrsepond_index));
%%%%%%%%%%%%%%%%%%%%% verison 2 (quick sort) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
% K = round(height*width*0.001);
% X = darkchannel(:);
% I_gray = rgb2gray(I); I_gray = I_gray(:);
% [sorted_darkchannel]=quicksort(X);
% corrsepond_index = find(X == sorted_darkchannel(length(sorted_darkchannel)));
% A = max(I_gray(corrsepond_index));
% A = double(A);
%%%%%%%%%%%%%%%%%%%%%% verison 3 (given sort function in MATLAB) p% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K = round(height*width*0.001);
% X = darkchannel(:);
% I_gray = rgb2gray(I); I_gray = I_gray(:);
% [~,corrsepond_index] = sort(X,'descend');
% p = 0.2;
% index_end = round(p*length(corrsepond_index)/100);
% corrsepond_index = corrsepond_index(1:index_end,:);
% A = max(I_gray(corrsepond_index));
% A = double(A);
%%%%%%%%%%%%%%%%%%%%%% verison 4 (given sort function in MATLAB) max %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = round(height*width*0.001);
X = darkchannel(:);
I_gray = rgb2gray(I); I_gray = I_gray(:);
[~,corrsepond_index] = sort(X,'descend');
corrsepond_index = corrsepond_index(1,:);
A = max(I_gray(corrsepond_index));
A = double(A);
%%%%%%%%%%%%%%%%%%%%%% verison 5 (given entropy function in MATLAB) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nhood = true(31);
% I_gray = rgb2gray(I); 
% J = entropyfilt(I_gray,nhood);
% J = J(:);
% [~,corrsepond_index] = sort(J,'descend');
% I_gray = I_gray(:);
% A = max(I_gray(corrsepond_index));
% A = double(A);
end