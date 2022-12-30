%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Luis ROSARIO TREMOULET         %
%                                          %
%      Tratemiento digital de imagenes     %
%                Parte 4                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Selección de los parametros

path = 'Lisboa.png';
thresh = 8;

%% Cargar la imagen

img = imread(path);

%% Si imagen RGB -> Grayscale

if size(img, 3) == 3
    img = rgb2gray(img);
end
     
%% Operaciones de morfología
result_1 = imdilate(img, [0, 0, 1, 0, 0; 
                          0, 0, 1, 0, 0;
                          1, 1, 1, 1, 1;
                          0, 0, 1, 0, 0; 
                          0, 0, 1, 0, 0]);
result_1 = imerode(result_1, [0, 0, 1, 0, 0; 
                              0, 1, 1, 1, 0;
                              1, 1, 1, 1, 1;
                              0, 1, 1, 1, 0; 
                              0, 0, 1, 0, 0]);
result_2 = imdilate(img, [1, 0, 0, 0, 1; 
                          0, 1, 0, 1, 0;
                          0, 0, 1, 0, 0;
                          0, 1, 0, 1, 0; 
                          1, 0, 0, 0, 1]);
result_2 = imerode(result_2, [1, 1, 1, 1, 1; 
                              1, 1, 1, 1, 1;
                              1, 1, 1, 1, 1;
                              1, 1, 1, 1, 1; 
                              1, 1, 1, 1, 1]);

img_final = result_1 - result_2;

%% Tamańo del resultado
[height, width] = size(img_final);

%% Copiar el resultado

img_final_not_binarize = img_final;

for i = 1:1:height
    for j = 1:1:width
        if(img_final(i, j) > thresh)
            img_final(i, j) = 255;
        else
            img_final(i,j) = 0;
        end
    end
end

%% Ver el resultado 1
figure;
imshow(img_final_not_binarize);
title ('Not binarized');

%% Ver el resultado 2 (binarized)
figure;
imshow(img_final);
title ('Binarized');