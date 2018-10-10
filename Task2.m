% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

% Reading Image.
X = imread('/SC.png');  

% Displaying the input.
subplot(2,2,1), imshow(X), title('Original Image');
subplot(2,2,3),imhist(X),title('Original Image');

% Values of A, B & C.
a = 80;
b = 100;
c = 220;

% Highlighing the range of A and B.
X(X >= a) = c; 
X(X >= b) = c; 

% Displaying the output.
subplot(2,2,2), imshow(X), title('Contrast Streached Image')
subplot(2,2,4),imhist(X),title('Contrast Streached Image');