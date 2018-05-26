function [transmission] = Transmission(omega,darkchannel,A)
% calculate the transmission t_tilde(x) of image I 
% with given atmospheric light A and parameter omega

% the two min in equation (12) in the paper form the dark channel actually 
% because the paper treats A as a fix value for the whole image, thus we can 
% pull A out of the 2 min
transmission = 255 - omega.*darkchannel./A; 
end

