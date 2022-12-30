%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Luis ROSARIO TREMOULET         %
%                                          %
%      Tratemiento digital de imagenes     %
%                Parte 1                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Selección de los parametros

n = 0.5;
D0 = 15;
img_path = 'Lisboa.png';

%% Cargar la imagen

img = imread(img_path);
img = im2double(img);

%% Si imagen RGB -> Grayscale

if size(img, 3) == 3
    img = rgb2gray(img);
end

%% Ver la imagen original
[height, width] = size(img);

figure;
imshow(img);
title ('Original');

%% BUTTERWORTH (highpassfilter)

% fft2 : https://es.mathworks.com/help/matlab/ref/fft2.html
% fftshift : https://es.mathworks.com/help/matlab/ref/fftshift.html

img_fourrier = fft2(img);
img_fourrier = fftshift(img_fourrier);

mask = zeros(height, width);

 for i = 1:height
     for j = 1:width
         D = sqrt((i - height/2)^2 + (j - width/2)^2);
         mask(i, j) = 1 / (1 + (D0/D)^(2*n)); % Formula BUTTERWORTH
     end
 end

img_filtered = img_fourrier.*mask;


%% Inversa

% ifftshift : https://es.mathworks.com/help/matlab/ref/ifftshift.html
% ifft2 : https://es.mathworks.com/help/matlab/ref/ifft2.html

img_filtered_inv = ifftshift(img_filtered);
img_filtered_inv = ifft2(img_filtered_inv);

%% Resultado

figure;
imshow(img_filtered_inv);
title(['Orden n : ',num2str(n),'    -    D0 : ',num2str(D0)]);