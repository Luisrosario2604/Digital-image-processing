%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Luis ROSARIO TREMOULET         %
%                                          %
%      Tratemiento digital de imagenes     %
%                Parte 3                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Selección de los parametros

left_path = 'data/1.png';
right_path = 'data/2.png';
kernel_size = 11;
thresh = 2;
thresh1 = 50;
thresh2 = 1000;
thresh3 = 10000;

%% Cargar las imagenes

left_img = imread(left_path);
right_img = imread(right_path);

%% Si imagen RGB -> Grayscale

if size(left_img, 3) == 3
    left_img = rgb2gray(left_img);
end

if size(right_img, 3) == 3
    right_img = rgb2gray(right_img);
end

%% Ver las imagenes originales
[height, width] = size(left_img);

% left
figure;
imshow(left_img);
title ('Original left');

%% right
figure;
imshow(right_img);
title ('Original right');

%% Inicializamos una mascara / imagen de unos y de zeros

mask = ones(height - kernel_size + 1, width - kernel_size + 1) * thresh;
final_img = zeros(height - kernel_size + 1, width - kernel_size + 1);

mask1 = ones(height - kernel_size + 1, width - kernel_size + 1) * thresh1;
final_img1 = zeros(height - kernel_size + 1, width - kernel_size + 1);

mask2 = ones(height - kernel_size + 1, width - kernel_size + 1) * thresh2;
final_img2 = zeros(height - kernel_size + 1, width - kernel_size + 1);

mask3 = ones(height - kernel_size + 1, width - kernel_size + 1) * thresh3;
final_img3 = zeros(height - kernel_size + 1, width - kernel_size + 1);

%% main algoritmo

for i=1:1:height - kernel_size + 1
    for j=1:1:width - kernel_size + 1
        for d=1:1:width - kernel_size + 1

            left_sum = left_img(i:i+ kernel_size - 1, j:j+ kernel_size - 1);
            right_sum = right_img(i:i + kernel_size - 1, d:d + kernel_size - 1);
            pxl_value = sum(sum((left_sum - right_sum).^2));

            if mask(i, j) > pxl_value
                final_img(i,j) = abs(d-j)/2;
                mask(i,j) = pxl_value;
            end
               
            if mask1(i, j) > pxl_value
                final_img1(i,j) = abs(d-j)/2;
                mask1(i,j) = pxl_value;
            end

            if mask2(i, j) > pxl_value
                final_img2(i,j) = abs(d-j)/2;
                mask2(i,j) = pxl_value;
            end
             
            if mask3(i, j) > pxl_value
                final_img3(i,j) = abs(d-j)/2;
                mask3(i,j) = pxl_value;

            disp(['->', num2str(d), ' ', num2str(j), '/', num2str(width-10), ' ', num2str(i), '/', num2str(height- kernel_size + 1)])
            end
        end
    end
end

%% Resultado 1

final_img = uint8(final_img);

figure;
imshow(final_img);
title ('Final result');
%% Resultado 2

final_img1 = uint8(final_img1);

figure;
imshow(final_img1);
title ('Final result1');
%% Resultado 3

final_img2 = uint8(final_img2);

figure;
imshow(final_img2);
title ('Final result2');
%% Resultado 4

final_img3 = uint8(final_img3);

figure;
imshow(final_img3);
title ('Final result3');