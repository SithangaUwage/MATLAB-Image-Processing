% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

% Reading Image.
Im = imread('Images/Noisy.png');

% Converting to Grayscale
I = rgb2gray(Im);

% Displaying Input Grayscale Image
figure(1), subplot(1,2,1), imshow(I), title('Original');
figure(2), subplot(1,2,1), imshow(I), title('Original');
figure(3), subplot(2,2,1), imshow(I), title('Original');
figure(3), subplot(2,2,3), imshow(I), title('Original'); 

% Getting the size of the rows and coloumns of the Image
[r c] = size(I);

% Median Filter
Rep = padarray(I,[2,2],'replicate');

B = zeros(r, c);
for x = 3 : size(Rep,1)-2
    for y = 3 : size(Rep,2)-2
        % Vector Indexing
        box = Rep(x-2:x+2,y-2:y+2);
        array = reshape(box,1,25);     
        B(x-2, y-2) = median(array(:));
    end
end

% Displaying the Median Filter Output
figure(1), subplot(1,2,2), imshow(uint8(B)), title('Median Filter');
figure(3), subplot(2,2,2), imshow(uint8(B)), title('Median Filter');

% Kennel Mask
M = 5;
Mask = ones(M);
[m,n] = size(Mask);

P = 1:m;
x = round(median(P));
Out = zeros(r+2*(x-1),c+2*(x-1));

for i = x:(r+(x-1))
    for j = x:(c+(x-1))
        Out(i,j) = I(i-(x-1),j-(x-1));
    end
end

% Averaging Filter
Sum = 0;
x = 0;
y = 0;

for i = 1:r
    for j = 1:c
        for k = 1:m
            for l = 1:n 
                Sum = Sum + Out(i+x,j+y)*Mask(k,l);
                y = y + 1;
            end
            y = 0;
            x = x + 1;
        end
        x = 0;
        Output(i,j) = (1/(m*n))*(Sum);
        Sum = 0;
    end
end

% Displaying the Average Filter Output
figure(2), subplot(1,2,2), imshow(uint8(Output)), title ('Averging Filter');
figure(3), subplot(2,2,4), imshow(uint8(Output)), title ('Averging Filter');