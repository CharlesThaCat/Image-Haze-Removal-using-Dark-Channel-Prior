% main function for demonstrating the function of this project
% all resulting figures from each step will be shown
clear; clc;
imagename = 'C:\Users\Charles Lin\Documents\Git--VSCode--GitHub\Image Haze Removal using Dark Channel Prior\frida\M080-000002.png';
I = imread(imagename);
[height,width,~] = size(I);
figure;
imshow(uint8(I)); title('figure(1): original image');

% parameters' initialization
patch_size = 7;     % dark channel patch size
patch_size1 = 41;   % atmospheric light patch size
omega = 0.93*255;   % omega in transmission map estimation
epsilon = 10^-3;    % coefficients in guided filtering
r = 81;             % coefficients in guided filtering

% dark channel
tic;
[darkchannel] = DarkChannel(I,height,width,patch_size);
toc;
figure;
imshow(uint8(darkchannel)); title('figure(2): dark channel');

% atmospheric light A
tic;
[darkchannel1] = DarkChannel(I,height,width,patch_size1);
[A] = AtmosphericLight(I,darkchannel1,height,width);
toc;

% transmission t_tilde(x)
tic;
[transmission] = Transmission(omega,darkchannel,A);
toc;
figure;
imshow(uint8(transmission)); title('figure(3): transmission before refinement');

% show the haze free image before soft matting
transmission_normalized = transmission/255;
% [transmission_normalized,~] = mapminmax(transmission,0,1);
result1 = zeros(height,width,3);
I1 = double(I);
result1(:,:,1) = (I1(:,:,1) - (1-transmission_normalized)*A)./transmission_normalized;
result1(:,:,2) = (I1(:,:,2) - (1-transmission_normalized)*A)./transmission_normalized;
result1(:,:,3) = (I1(:,:,3) - (1-transmission_normalized)*A)./transmission_normalized;
figure;
imshow(uint8(result1)); title('figure(4): haze free image without refinement');

% soft matting(very slow when dealing with large image)
% [ filtered_transmission ] = matting( I1, transmission );

% guided filter transmission refinement
tic;
[filtered_transmission] = GuidedFilter(transmission_normalized,double(I)/255,r,epsilon);
figure;
imshow(filtered_transmission,[]); title('figure(5): guided filtered transmission');
toc;

% show the haze free image after guided filtering
result2 = zeros(height,width,3);
result2(:,:,1) = (I1(:,:,1) - (1-filtered_transmission)*A)./filtered_transmission;
result2(:,:,2) = (I1(:,:,2) - (1-filtered_transmission)*A)./filtered_transmission;
result2(:,:,3) = (I1(:,:,3) - (1-filtered_transmission)*A)./filtered_transmission;
figure;
imshow(uint8(result2)); title('figure(6): haze free image after guided filtering');
figure;
subplot(2,1,1); imshow(uint8(I)); title('figure(7): hazy image');
subplot(2,1,2); imshow(uint8(result2)); title('figure(7): haze free image');
