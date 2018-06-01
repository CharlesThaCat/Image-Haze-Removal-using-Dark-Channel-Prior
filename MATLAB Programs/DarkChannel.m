function [darkchannel] = DarkChannel(I,height,width,patch_size)
% calculate the dark channel of image I with size [height, width]
darkchannel = zeros(height,width);
%%%%%%%%%%%%%%%%%%%%%% verison 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for index1 = ceil(patch_size/2):height-floor(patch_size/2)                  
%     for index2 = ceil(patch_size/2):width-floor(patch_size/2)
%         patch_r = I((index1-ceil(patch_size/2)+1):(index1+floor(patch_size/2)), (index2-ceil(patch_size/2)+1):(index2+floor(patch_size/2)),1);
%         patch_g = I((index1-ceil(patch_size/2)+1):(index1+floor(patch_size/2)), (index2-ceil(patch_size/2)+1):(index2+floor(patch_size/2)),2);
%         patch_b = I((index1-ceil(patch_size/2)+1):(index1+floor(patch_size/2)), (index2-ceil(patch_size/2)+1):(index2+floor(patch_size/2)),3);
%         a = min(patch_r(:));
%         b = min(patch_g(:));
%         c = min(patch_b(:));
%         darkchannel(index1,index2) = min([a b c]);
%     end
% end

%%%%%%%%%%%%%%%%%%%%%% verison 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% local minima for each patch in RGB channel
darkchannel_r = MinFilt(I(:,:,1),[patch_size patch_size]);
darkchannel_g = MinFilt(I(:,:,2),[patch_size patch_size]);
darkchannel_b = MinFilt(I(:,:,3),[patch_size patch_size]);
darkchannel_r(height,width)=0;
darkchannel_g(height,width)=0;
darkchannel_b(height,width)=0;
for index1 = 1:height
    for index2 = 1:width
        darkchannel(index1,index2) = min([darkchannel_r(index1,index2) darkchannel_g(index1,index2) darkchannel_b(index1,index2)]);
    end
end

darkchannel = double(darkchannel);

end
