function Y = VanHerkMin(X,N)
% fast implementation of 1-D minimum filter
% X is the input array
% N is the frame length / 1-D patch size
% Y is the local minima

% correcting X size
fixsize = 0;
addel = 0;
if mod(size(X,2),N) ~= 0
    fixsize = 1;
    addel = N-mod(size(X,2),N);
    f = [X repmat(X(:,end),1,addel)];
else
   f = X;
end
lf = size(f,2);
lx = size(X,2);
clear X

% Declaring aux. mat.
g = f;
h = g;

% Filling g & h (aux. mat.)
ig = 1:N:size(f,2);
ih = ig + N - 1;

g(:,ig) = f(:,ig);
h(:,ih) = f(:,ih);

for i = 2 : N
    igold = ig;
    ihold = ih;
    
    ig = ig + 1;
    ih = ih - 1;
    
    g(:,ig) = min(f(:,ig),g(:,igold));
    h(:,ih) = min(f(:,ih),h(:,ihold));
end
clear f

% Comparing g & h
if fixsize
    if addel > (N-1)/2
%          disp('hoi')
       ig = [ N : 1 : lf - addel + floor((N-1)/2) ];
       ih = [ 1 : 1 : lf-N+1 - addel + floor((N-1)/2)];
       Y = [ g(:,1+ceil((N-1)/2):N-1)  min(g(:,ig), h(:,ih)) ];
    else   
       ig = [ N : 1 : lf ];
       ih = [ 1 : 1 : lf-N+1 ];
       Y = [ g(:,1+ceil((N-1)/2):N-1)  min(g(:,ig), h(:,ih))  h(:,lf-N+2:lf-N+1+floor((N-1)/2)-addel) ];
    end            
else % not fixsize (addel=0, lf=lx) 
    ig = [ N : 1 : lx ];
    ih = [ 1 : 1 : lx-N+1 ];
    Y = [  g(:,N-ceil((N-1)/2):N-1) min( g(:,ig), h(:,ih) )  h(:,lx-N+2:lx-N+1+floor((N-1)/2)) ];
end 


end