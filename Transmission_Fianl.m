function [transmission] = Transmission_Fianl(omega,darkchannel,A)
% % calculate the un-normalized transmission t_tilde(x) of image 
transmission = 255 - omega.*darkchannel./A; % un-normalized
end

