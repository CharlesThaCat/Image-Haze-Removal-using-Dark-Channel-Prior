function Y = VanHerkMin(X,N,Type)
% fast implementation of 1-D minimum filter using van Herk's algorithm
% X is the input array
% N is the frame length / 1-D patch size
% Type specifies do van Herk minimum filter in row of column dimension
% Y is the local minima for 

% row or column type
if strcmp(Type,'column')
	X = X';
end

% correcting X size to a multiple of N by padding the array on the right side
fixsize = 0;    % indicator of correcting size
addel = 0;      % the number of copies of the last column of X when padding
if mod(size(X,2),N) ~= 0    % concerning the number of columns of X
    fixsize = 1;
    addel = N-mod(size(X,2),N);
    f = [X repmat(X(:,end),1,addel)];   % copy the last column of X for addel times in the dimension of rows
else
   f = X;
end
lf = size(f,2);
clear X

% recursive morphological filter in two directions
g = f;
h = g;

% Filling g & h initially according to the fixed patch size
% Figure 1 in that paper
ig = 1:N:size(f,2); % starting index of the forward recursive morphological filter
ih = ig + N - 1;    % ending index of the backward recursive morphological filter

g(:,ig) = f(:,ig);
h(:,ih) = f(:,ih);

% Recursive procedure 
% Equation (4a) and (4b) in that paper
for i = 2 : N
    igold = ig;
    ihold = ih;
    
    % index correspond to those in Equation (4a) and (4b)
    ig = ig + 1;
    ih = ih - 1;
    
    g(:,ig) = min(f(:,ig),g(:,igold));
    h(:,ih) = min(f(:,ih),h(:,ihold));
end
clear f

% Comparing g & h
% Equation (4c) in that paper
if fixsize
    if addel > (N-1)/2
        % index correspond to those in Equation (4c)
		ig = [ N : 1 : lf - addel + floor((N-1)/2) ];
		ih = [ 1 : 1 : lf-N+1 - addel + floor((N-1)/2)];
		Y = [ g(:,1+ceil((N-1)/2):N-1)  min(g(:,ig), h(:,ih)) ];
    else   
		ig = [ N : 1 : lf ];
		ih = [ 1 : 1 : lf-N+1 ];
		Y = [ g(:,1+ceil((N-1)/2):N-1)  min(g(:,ig), h(:,ih))  h(:,lf-N+2:lf-N+1+floor((N-1)/2)-addel) ];
    end            
else % not fixsize (addel=0, lf=lf) 
    ig = [ N : 1 : lf ];
    ih = [ 1 : 1 : lf-N+1 ];
    Y = [  g(:,N-ceil((N-1)/2):N-1) min( g(:,ig), h(:,ih) )  h(:,lf-N+2:lf-N+1+floor((N-1)/2)) ];
end 

% row or column type
if strcmp(Type,'column')
	Y = Y';
end

end