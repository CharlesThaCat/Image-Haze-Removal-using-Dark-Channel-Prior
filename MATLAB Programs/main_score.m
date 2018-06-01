% main function for calculating average RMSE score for dehazing 72 hazy images in FRIDA
% used to evaluate the qualities of different parameters
% As written in the fourth paper, the quality of the dehazed image is strongly dependent of the accuracy of transmission map, thus the quality of transmission map can 
% be used to estimate the quality of overall dehazing.
% all resulting figures from each step will not be shown
clear; clc;
tic;
i = 1;
j = 1;
sum = 0;
while (i<18)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ground truth depth map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    depthmapname = sprintf('C:\\Users\\Charles Lin\\Documents\\Git--VSCode--GitHub\\Image Haze Removal using Dark Channel Prior\\frida\\Dmap-%.6d.fdd',i);
    depthmap = double(load(depthmapname))/1000.0;
    depthmap_normalized = depthmap./max(depthmap(:));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% uniform fog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imagename = sprintf('C:\\Users\\Charles Lin\\Documents\\Git--VSCode--GitHub\\Image Haze Removal using Dark Channel Prior\\frida\\U080-%.6d.png',i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % patch size initialization
    patch_size = 7;

    % dark channel  
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
    patch_size1 = 81;
    [darkchannel1] = DarkChannel(I,height,width,patch_size1);
    [A] = AtmosphericLight(I,darkchannel1,height,width);
    
    % transmission t_tilde(x)
    omega = 0.95*255;
    [transmission] = Transmission(omega,darkchannel,A);
        
    % show the haze free image before soft matting
    transmission_normalized = transmission/255;

    % guided filter transmission refinement
    epsilon = 10^-6;
    r = 81; % radius of local window, determined interactively
    [filtered_transmission] = GuidedFilter(transmission_normalized,double(I)/255,r,epsilon);
    
    [rmse_score] = RMSE(depthmap_normalized,filtered_transmission);
    sum = sum + rmse_score;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% heterogeneous fog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imagename = sprintf('C:\\Users\\Charles Lin\\Documents\\Git--VSCode--GitHub\\Image Haze Removal using Dark Channel Prior\\frida\\K080-%.6d.png',i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % dark channel
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
    patch_size1 = 31;
    [darkchannel1] = DarkChannel(I,height,width,patch_size1);
    [A] = AtmosphericLight(I,darkchannel1,height,width);
    
    % transmission t_tilde(x)
    [transmission] = Transmission(omega,darkchannel,A);
    
    % show the haze free image before soft matting
    transmission_normalized = transmission/255;

    % guided filter transmission refinement
    [filtered_transmission] = GuidedFilter(transmission_normalized,double(I)/255,r,epsilon);
    
    [rmse_score] = RMSE(depthmap_normalized,filtered_transmission);
    sum = sum + rmse_score;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cloudy fog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imagename = sprintf('C:\\Users\\Charles Lin\\Documents\\Git--VSCode--GitHub\\Image Haze Removal using Dark Channel Prior\\frida\\L080-%.6d.png',i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % dark channel
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
    patch_size1 = 31;
    [darkchannel1] = DarkChannel(I,height,width,patch_size1);
    [A] = AtmosphericLight(I,darkchannel1,height,width);
    
    % transmission t_tilde(x)
    [transmission] = Transmission(omega,darkchannel,A);
    
    % show the haze free image before soft matting
    transmission_normalized = transmission/255;

    % guided filter transmission refinement
    [filtered_transmission] = GuidedFilter(transmission_normalized,double(I)/255,r,epsilon);
    
    [rmse_score] = RMSE(depthmap_normalized,filtered_transmission);
    sum = sum + rmse_score;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cloudy heterogeneous fog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imagename = sprintf('C:\\Users\\Charles Lin\\Documents\\Git--VSCode--GitHub\\Image Haze Removal using Dark Channel Prior\\frida\\M080-%.6d.png',i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % dark channel
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
    patch_size1 = 31;
    [darkchannel1] = DarkChannel(I,height,width,patch_size1);
    [A] = AtmosphericLight(I,darkchannel1,height,width);
    
    % transmission t_tilde(x)
    [transmission] = Transmission(omega,darkchannel,A);

    % show the haze free image before soft matting
    transmission_normalized = transmission/255;

    % guided filter transmission refinement
    [filtered_transmission] = GuidedFilter(transmission_normalized,double(I)/255,r,epsilon);

    [rmse_score] = RMSE(depthmap_normalized,filtered_transmission);
    sum = sum + rmse_score;

    i = i+1;
end
avg_rmse_score = sum./72;
toc;