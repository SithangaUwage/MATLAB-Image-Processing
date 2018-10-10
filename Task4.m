% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;

% Reading Image.
I = imread('Images/Starfish.jpg');
figure (1), subplot(1,2,1), imshow(I), title('Orginal');

% Converting to Grayscale.
Igray = rgb2gray(I);
figure(1), subplot(1,2,2), imshow(Igray), title('Grayscale');

% Convert to Binary Image using Threshold.
thresholdValue = 225;
binaryImage = Igray < thresholdValue;
figure(2), imshow(binaryImage), title("Binary Image");

% Fill the Holes in the Image
binaryImage = imfill(binaryImage, 'holes');
figure(3), imshow(binaryImage), title('Filling Holes');

% Remove Noise using Average Filter
Kaverage = filter2(fspecial('average',3),binaryImage)/1;
figure(4), subplot(1,2,1), imshow(Kaverage), title('Average Filter');

% Remove Noise using Median Filter
Kmedian = medfilt2(binaryImage);
figure(4), subplot(1,2,2), imshow(Kmedian), title('Median Filter');

% Remove objects fewer than 100 pixels.
bw = bwareaopen(Kmedian,100);
figure(5), imshow(bw), title('Removing objects < 100 pixels');

% Fill Gaps in the Image.
se = strel('disk',4);
bw = imclose(bw,se);

% Fill the Holes in the Image again.
bw = imfill(bw,'holes');
figure(6), imshow(bw), title('Filling Gaps & Holes');

% Label the Objects in the Image.
labeledImage = bwlabel(bw);

% Measure Image Region
measurements = regionprops(labeledImage,'Area','Perimeter');

allAreas = [measurements.Area];
allPerimeters = [measurements.Perimeter];

% Roundness of the object calculation 
circularities = allPerimeters.^2 ./ (4*pi*allAreas);

% Area Range for the Starfish
maxAllowableArea = 2000;
Starfish = circularities < 6 & allAreas < maxAllowableArea;

Objects = find(Starfish);
bw = ismember(labeledImage, Objects) > 0;
figure(7), imshow(bw), title('Object within the Range');

% Extracting the objects
BW2 = bwpropfilt(bw,'perimeter',5);

% Displaying the Output
figure(8), imshow(BW2), title('Object Recognition');
