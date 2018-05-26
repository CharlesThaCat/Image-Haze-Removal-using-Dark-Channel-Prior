function Y = MinFilt(X,N)
% 2-D minimum filter using van-Herk algorithm
% X is the input 2-D array
% N is the 2-D patch size
% Y is the minimum
Y = VanHerkMin(X,N(1),'row');
Y = VanHerkMin(Y,N(2),'column');
    
end