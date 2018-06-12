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
% parameters' initialization
patch_size = 7;     % dark channel patch size
patch_size1 = 81;   % atmospheric light patch size
omega = 0.93*255;   % omega in transmission map estimation
epsilon = 10^-6;    % coefficients in guided filtering
r = 81;             % coefficients in guided filtering
frida_path = 'C:\\Users\\Charles Lin\\Documents\\Git--VSCode--GitHub\\Image Haze Removal using Dark Channel Prior\\frida';
D_path = strcat(frida_path, '\\Dmap-%.6d.fdd');
U_path = strcat(frida_path, '\\U080-%.6d.png');
K_path = strcat(frida_path, '\\K080-%.6d.png');
L_path = strcat(frida_path, '\\L080-%.6d.png');
M_path = strcat(frida_path, '\\M080-%.6d.png');

while (i<18)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ground truth depth map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    depthmapname = sprintf(D_path,i);
    depthmap = double(load(depthmapname))/1000.0;
    depthmap_normalized = depthmap./max(depthmap(:));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% uniform fog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imagename = sprintf(U_path,i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % dark channel  
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
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

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% heterogeneous fog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imagename = sprintf(K_path,i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % dark channel
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
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
    imagename = sprintf(L_path,i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % dark channel
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
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
    %imagename = sprintf('C:\\Users\\Charles Lin\\Documents\\Git--VSCode--GitHub\\Image Haze Removal using Dark Channel Prior\\frida\\M080-%.6d.png',i);
    imagename = sprintf(M_path,i);
    I = imread(imagename);
    [height,width,~] = size(I);

    % dark channel
    [darkchannel] = DarkChannel(I,height,width,patch_size);
    
    % atmospheric light A
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
avg_rmse_score