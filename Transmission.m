function [transmission] = Transmission(I,height,width,patch_size,A,omega)
% calculate the transmission t_tilde(x) of image I 
% with given atmospheric light A and parameter omega
transmission = zeros(height,width);
for index1 = ceil(patch_size/2):height-floor(patch_size/2)                  % 这里不加墙会不会导致精度不佳？
    for index2 = ceil(patch_size/2):width-floor(patch_size/2)
        patch_r = I((index1-ceil(patch_size/2)+1):(index1+floor(patch_size/2)), (index2-ceil(patch_size/2)+1):(index2+floor(patch_size/2)),1);
        patch_g = I((index1-ceil(patch_size/2)+1):(index1+floor(patch_size/2)), (index2-ceil(patch_size/2)+1):(index2+floor(patch_size/2)),2);
        patch_b = I((index1-ceil(patch_size/2)+1):(index1+floor(patch_size/2)), (index2-ceil(patch_size/2)+1):(index2+floor(patch_size/2)),3);
        a = min(patch_r(:)./A);
        b = min(patch_g(:)./A);
        c = min(patch_b(:)./A);
        d = min([a b c]);
        transmission(index1,index2) = 1 - omega.*d;
    end
end

end

