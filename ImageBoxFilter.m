function [s] = ImageBoxFilter(p,r)
% implementation of box filter in 2D
% time complexity: O(N)
% p: input image 
% r: radius of local window
% s: output moving sum of input p

[height,width] = size(p);
s = zeros(height,width);

% 1D box filter (Algorithm 2) in "height" dimension
s0 = cumsum(p,1);

% 1D box filter (Algorithm 2) in "width" dimension

end

