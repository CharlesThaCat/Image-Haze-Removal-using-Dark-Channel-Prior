function [y]=quicksort(x)
% Uses quicksort to sort an array. Two dimensional arrays are sorted column-wise.
% [n,m]=size(x);
% if(m>1)
%     y=x;
%     for j=1:m
%         y(:,j)=quicksort(x(:,j));
%     end
%     return;
% end
% % The trivial cases
% if(n<=1);y=x;return;end
%     if(n==2)
%         if(x(1)>x(2))
%             x=[x(2); x(1)];
%         end
%         y=x;
%     return;
%     end
% The non-trivial case
% Find a pivot, and divide the array into two parts.
% All elements of the first part are less than the
% pivot, and the elements of the other part are greater 
% than or equal to the pivot.
m=round(length(x.value)/2);
pivot=x.value(m);
a = x.value;
ltIndices=find(a<pivot); % Indices of all elements less than pivot.
if(isempty(ltIndices)) % This happens when pivot is miniumum of all elements.
    ind=find(a>pivot); % Find the indices of elements greater than pivot.
    if(isempty(ind))
        y= x; return;
    end % This happens when all elements are the same.
        pivot=x.value(ind(1)); % Use new pivot.
        ltIndices=find(a<pivot);
end
% Now find the indices of all elements not less than pivot.
% Since the pivot is an element of the array, 
% geIndices cannot be empty.
geIndices=find(a>=pivot);
% Recursively sort the two parts of the array and concatenate 
% the sorted parts.
x1 = struct('index',ltIndices,'value',x.value(ltIndices));
x2 = struct('index',geIndices,'value',x.value(geIndices));
y= [quicksort(x1); quicksort(x2)];