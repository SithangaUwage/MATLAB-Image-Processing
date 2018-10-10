% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Images/Zebra.jpg');
%figure, imshow(I),title('Step-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);
figure(1), imshow(Igray), title('Conversion of input image to greyscale');

% Getting the size of the rows and coloumns of the Image.
[r,c] = size(Igray);

% Scale Factor.
scale = [3 3];         

% Nearest Neighbour

% Multiplying each row and coloumn with the scale factor to create a matrix of zeros.
outputI = zeros(scale(1)*r,scale(2)*c, class(Igray));

% Nearest Neighbour
for i=1:scale(1)*r
    for j=1:scale(2)*c
        % Map output image location to input image location
        ii = round( (i-1)*(r-1)/(scale(1)*r-1)+1 );
        jj = round( (j-1)*(c-1)/(scale(2)*c-1)+1 );
        outputI(i,j) = Igray(ii,jj);
    end
end

% Display Nearest Neighbour Image
figure(2), imshow(outputI), title('Grayscale Image enlarged to size of 1668x1836 using Nearest Neighbour');

% Bilinear Interpolation

% Mapping Pixels of the Grayscale Image to a New Array.
for i=1:r
    for j=1:c
      Bilinear(1+(i-1)*scale(1),1+(j-1)*scale(2),:)=Igray(i,j); 
    end
end

for i = 1:1+(r-2)*scale(1)     
    for j = 1:1+(c-2)*scale(2) 
    
       % Bilinear equation
       if ((rem(i-1,scale(1))==0) && (rem(j-1,scale(2))==0)) 
       else  
           Num1 = Bilinear( ceil(i/scale(1))*scale(2)-scale(1)+1,ceil(j/scale(2))*scale(1)-scale(2)+1,:); 
           Num2 = Bilinear( ceil(i/scale(1))*scale(2)-scale(1)+1+scale(2),ceil(j/scale(1))*scale(2)-scale(1)+1,:);
           Num3 = Bilinear( ceil(i/scale(1))*scale(2)-scale(1)+1,ceil(j/scale(2))*scale(1)-scale(2)+1+scale(1),:);
           Num4 = Bilinear( ceil(i/scale(1))*scale(2)-scale(1)+1+scale(2),ceil(j/scale(1))*scale(2)-scale(1)+1+scale(2),:);
           
           % Coordinates of calculating pixel.
           x = rem(i-1,scale(1)); 
           y = rem(j-1,scale(2));
           
           % Limiting the  pixel being calculated to the nearest four pixels.
           dx = x/scale(1); 
           dy = y/scale(2);
           
           Eq1 = Num1;    % Constants of bilinear interpolation.
           Eq2 = Num2-Num1;
           Eq3 = Num3-Num1;
           Eq4 = Num1-Num2-Num3+Num4;           
           Bilinear(i,j,:) = Eq1+Eq2*dx+Eq3*dy+Eq4*dx*dy;
         end
    end
end
% Display Bilinear Interpolation Image
figure(3),imshow(uint8(Bilinear)), title('Grayscale Image enlarged to size of 1668x1836 using Bilinear Interpolation');


