% main function of this project
clear; clc;
imagename = '3236898173_71c252a92d_o.jpg';
I = imread(imagename);
[height,width,~] = size(I);
figure;
imshow(uint8(I)); title('original image');

% patch size initialization
patch_size = 10;

% dark channel
tic;
[darkchannel] = DarkChannel(I,height,width,patch_size);
toc;
figure;
imshow(uint8(darkchannel)); title('dark channel');

% atmospheric light A
tic;
[A] = AtmosphericLight(I,darkchannel,height,width);
toc;

% transmission t_tilde(x)
tic;
omega = 0.95*255;
[transmission] = Transmission(omega,darkchannel,A);
toc;
figure;
imshow(uint8(transmission)); title('transmission before soft matting');

% show the haze free image before soft matting
transmission_normalized = transmission/255;
result1 = zeros(height,width,3);
I1 = double(I);
result1(:,:,1) = (I1(:,:,1) - (1-transmission_normalized)*A)./transmission_normalized;
result1(:,:,2) = (I1(:,:,2) - (1-transmission_normalized)*A)./transmission_normalized;
result1(:,:,3) = (I1(:,:,3) - (1-transmission_normalized)*A)./transmission_normalized;
figure;
imshow(uint8(result1)); title('haze free image without soft matting');

% soft matting(very slow when dealing with large image)
% [ filtered_transmission ] = matting( I1, transmission );

% guided filter transmission refinement
tic;
epsilon = 10^-6;
r = 81; % radius of local window, determined interactively
[filtered_transmission] = GuidedFilter(transmission_normalized,double(I)/255,r,epsilon);
figure;
imshow(filtered_transmission,[]); title('guided filtered transmission');
toc;

% show the haze free image after guided filtering
result2 = zeros(height,width,3);
result2(:,:,1) = (I1(:,:,1) - (1-filtered_transmission)*A)./filtered_transmission;
result2(:,:,2) = (I1(:,:,2) - (1-filtered_transmission)*A)./filtered_transmission;
result2(:,:,3) = (I1(:,:,3) - (1-filtered_transmission)*A)./filtered_transmission;
figure;
imshow(uint8(result2)); title('haze free image after guided filtering');
figure;
subplot(2,1,1); imshow(uint8(I)); title('hazy image');
subplot(2,1,2); imshow(uint8(result2)); title('haze free image');
