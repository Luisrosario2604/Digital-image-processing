%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Luis ROSARIO TREMOULET         %
%                                          %
%      Tratemiento digital de imagenes     %
%                Parte 2                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Selección de los parametros

n = 3; % 6/64
img_path = 'Lisboa.png';

%% Generación de la mascara

mask = zeros(8,8);
for i = 1:1:n
    for j = 1:n
        if (i+j) < (n+2)
            mask(i,j) = 1;
        end
    end
end

%% Verificación mascara

disp(mask)

%% Cargar la imagen

img = imread(img_path);
img = im2double(img);

%% Si imagen RGB -> Grayscale

if size(img, 3) == 3
    img = rgb2gray(img);
end

%% Ver la imagen original

figure;
imshow(img);
title ('Original');

%% DCT de 8x8

% blockproc : https://es.mathworks.com/help/images/ref/blockproc.html
% dct2 : https://es.mathworks.com/help/images/ref/dct2.html

mask_size = [8 8];
dct = @(block_struct) dct2(block_struct.data);
img_dct = blockproc(img, mask_size, dct);

figure;
imshow(img_dct);
title ('DCT de 8x8');

%% Compresion

comp = @(block_struct) mask.* block_struct.data;
img_comp = blockproc(img_dct, mask_size, comp);

figure;
imshow(img_comp);
title ('Compresion');

%% Descompresion

invers_dct = @(block_struct) idct2(block_struct.data);
img_des = blockproc(img_comp, mask_size, invers_dct);

figure;
imshow(img_des);
title('Descompresion');