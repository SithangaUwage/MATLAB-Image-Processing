# MATLAB-Image-Processing

Image interpolation is the process by which a small image is made larger by increasing the number of pixels comprising the small image. The task 1 of the assignment was to convert an image to grayscale and resize the new image by a scale factor of 3, using the nearest neighbour and bilinear interpolation, without using the built-in functions. At the beginning of the task, I read in the image to the script ```“I = imread('Zebra.jpg');”``` and converted the image into grayscale using ```“Igray = rgb2gray(I);”```, Figure 1.

Figure 1
![alt text](/Images/Figure1.PNG)


Afterwards, I got the size of the rows and columns of the image ```“[r,c] = size(Igray);”```, which is needed when both of the interpolation methods are applied and created a variable called scale factor to resize the image ```“scale = [3 3];”```.

The first method I used was the nearest neighbour interpolation, which determines the nearest neighbouring pixel and assumes the intensity value of it. In this technique, the empty spaces will be filled in with the nearest neighbouring pixel value. This concept is very useful when the speed is the main concern. In the script, I created a variable called “outputI” that multiplies the rows and the columns of the grayscale image with the scale factor, as the image needs to be resized to 1668*1836. However, the variable will create a matrix of zeros ```“outputI = zeros(scale(1)*r,scale(2)*c, class(Igray));”```, as the empty space will be filled in later in the script.

A for loop was then created to go through each row and column to map the output image location to the input image location and the new location will equal the “outputI” variable, ```“outputI(i,j) = Igray(ii,jj);”```. This is the process of the nearest neighbour interpolation where each empty space in the image is being filled with the nearest neighbour pixel value. Finally, the resized image is displayed using ```“imshow(outputI)”```, Figure 1.1.

Figure 1.1
![alt text](/Images/Figure1.1.PNG)


The second technique I used to complete the task was bilinear interpolation, which is an algorithm used to map a pixel location to a corresponding point on the texture map. Bilinear interpolation is an extension of linear interpolation, where the key idea is to perform linear interpolation first in one direction (horizontal) and then again in the other direction (vertical). The algorithm uses the weighted average of two translated pixel values for each output pixel value.    

The first step I took was to map the pixels in the greyscale image into a new array of size 1668x1836, using a for loop and multiplying the variables with the scale factor, as this is the size for the resize image ```“Bilinear(1+(i-1)*scale(1),1+(j-1)*scale(2),:)=Igray(i,j);”```. Secondly, I created a for loop that would go through each row and column of the image and calculate the weighted average of the pixels using the bilinear equation. Also, calculating the coordinates of the remainder of pixels, so that I can limit the pixels being calculated to the nearest four pixels. Finally displaying the output of the bilinear interpolated image ```“imshow(uint8(Bilinear))”```, Figure 1.2.

Figure 1.2
![alt text](/Images/Figure1.2.PNG)


The difference between the two methods depend mainly on the inputted data. From Figures 1.1 and 1.2 there is a slight difference between the two zoomed images. The enlarged image using nearest neighbour interpolation shows a better visual image compared to the bilinear interpolation image, as the image is more smooth and clear. The difference can be seen on the Zebra’s legs on Figure 1.2 as being blocky and pixelated. Nearest neighbour is best used for categorical data, as the values that go into the grid stays the same, however if the data is continuous, the results can be blocky. Bilinear interpolation works better on continuous data, such as elevation and raw slope values, rather than categorical data.     
For task 2 of the assignment I had to apply the piecewise linear transformation function to the image provided. A piecewise linear function is defined as a function in which more than one formula is used to define the output over different pieces of the domain. The function is often used to represent or to approximate nonlinear unary functions (nonlinear functions of one variable).
The task required the image to be highlight in the range of A and B values however preserving all the other grey levels (identity). To get the correct results for the task, contrast stretching had to be applied. Contrast stretching (known as normalisation) is an image enhancement technique that attempts to improve the contrast in an image by stretching the range of the intensity values. An image of low contrast has a small difference between its dark and light pixel values. The image histogram is usually skewed to the left (mostly light) or to the right (mostly dark). Contrast stretching is used to stretch the histogram of the image so that the full dynamic range of the image is filled.
The given values for the exercise was “a = 80;”, “b = 100;” and “c = 220;”. The range between A and B had to be highlighted in the image, so all the pixels that had values of 80 or greater for A ```“X(X >= a) = c;”``` and 100 or greater for B ```“X(X >= b) = c;”``` were stretched to the value of C. This process made the pixels that were 80 or greater white and the pixels that were less than 80 remained the same values, as the task required preserving all the other grey level identities.

In figure 2, I have demonstrated the task 2 while also providing the histograms of the input and the output of the images. The second histogram clearly shows that contrast stretching has been applied as the histogram is skewed to the left, showing the image contain mostly light-coloured pixels.  

Figure 2
![alt text](/Images/Figure2.PNG)


Task 3 of the assignment required an image to be loaded into MATLAB, convert the image into grayscale and apply two different smoothing filters to the image to reduce noise. The first filter was the median filter, which is a nonlinear method used to remove noise from images. The method is used widely as it is very effective at removing noise while preserving edges, as edges are an importance to the visual appearance of images.
The filter works by running through the image pixel by pixel and replacing each value with the median value of its neighbouring entries. The median is calculated by sorting all the pixel values from the pattern of neighbours (called the window) into numerical order and then replacing the pixel with the median pixel value.      
For the beginning of the task, I converted the image “Noisy.png” to greyscale using the rgb2gray function ```“I = rgb2gray(Im);”``` and collected the size of the rows and columns of the image using the size function. I then used the padarray function with the padding size of 2 x 2 and the method ‘replicate’ to pad by repeating the border elements of the noisy image ```“Rep = padarray(I,[2,2],'replicate');“```.

Finally, to reduce the noise from the image, I used vector indexing to loop through the image pixels and replace each pixel with the median value of its neighbouring entries ```“box = Rep(x-2:x+2,y-2:y+2);”```. Vector indexing is more efficient than using a for loop, as the method to go through each pixel can be written in the same line. The loop created has a kernel mask size of 5x5, where the median values of the pixels are calculated in a 5x5 neighbourhood throughout the image ```“array = reshape(box,1,25);”```. After the process is completed the new image is outputted using ```“imshow(uint8(B))”```, Figure 3.1.

Figure 3.1
![alt text](/Images/Figure3.1.PNG)

The second filter was the averaging (mean) filter, which is a method used to smoothing images by reducing the amount of intensity variation between neighbouring pixels. The method is mainly used to reduce noise from images. The filter works by running through pixel by pixel in the image and replacing each value with the average value of the neighbouring pixel, including itself. This method has the effect of eliminating pixel values which are unrepresentative of their surroundings.   
For the averaging filter exercise, I used the same grayscale and the size variables of the noisy image from the beginning of the task. I then created a kernel mask grid of 5x5 ```“[m,n] = size(Mask);”``` and inputted this grid in a for loop to calculate the mean of the pixels in a 5x5 grid in the image. After the kennel mask for loop was completed, I went to create the averaging filter to reduce the noise of the image. This was done by creating a for loop that goes through each row and column of the image, while another for loop use the mask grid calculation to replace the values of each pixel with the neighbouring average value ```“Sum = Sum + Out(i+x,j+y)*Mask(k,l);”```. Finally, when the averaging filter is completed to reduce the noise of the image, the result is displayed ```“imshow(uint8(Output))”```, Figure 3.2.  

Figure 3.2
![alt text](/Images/Figure3.2.PNG)


Both results from the median filter and the averaging filter are displayed in Figure 3.3 and the results shows that the median filter did a better job on removing the noise from the image. The averaging filters shows that noise reduction has happened, however the image is burred and the noise is more visible in this output than the output from the median filter. The median filter is less sensitive to outliers than the averaging filter, however if the image is representative with gaussian noise (statistical noise having a probability density function equal to that of the normal distribution), then the averaging filter works well. But the quality of the image diminishes due to blurring and gets worse as the size of the kernel mask increases past a neighbourhood of 3x3. To get a better result overall, both the median filter and the averaging filter could have been used together to remove the noise.  

Figure 3.3
![alt text](/Images/Figure3.3.PNG)


For task 4 of the assignment, an image must be processed through a series of methods to output a result which only shows the starfishes in the image. The beginning of the task required the image being read into the script using imread function ```“I = imread('Starfish.jpg');”``` and converting the image to grayscale, Figure 4.

Figure 4
![alt text](/Images/Figure4.PNG)


I decided to use threshold to convert the grayscale image into a binary image ```“binaryImage = Igray < thresholdValue;”```. Image thresholding is an effective way of partitioning an image into a foreground and background, as this is a common technique used to isolate object by converting grayscale images to binary images, Figure 4.1.

Figure 4.1
![alt text](/Images/Figure4.1.PNG)


After this part was completed, I wanted to fill the holes in the isolated objects using the imfill function ```“binaryImage = imfill(binaryImage, 'holes');”```. The function helps to fill holes (a set of background pixels) that cannot be reached by filling the background from the edge of the image, Figure 4.2. This process makes the objects look clearer and helps when the objects needed to be highlighted later in the image segmentation process.

Figure 4.2
![alt text](/Images/Figure4.2.PNG)

The next step I took was to remove the noise in the image. I decided to use the median and average filters together to get a clearer image, Figure 4.3. I choose these filters because I have used them in task 3 and I knew that using one of them won’t give the clearest image I need to segment the objects. The first filter I used was the average filter with a mask size of 3x3 neighbourhood, as this size gives the best result without blurring the image too much. Secondly, I used the median filter to remove the rest of the impulse noise from the image, also the filter preserves the edge of the image, giving a more visual appearance.

Figure 4.3
![alt text](/Images/Figure4.3.PNG)


Now that all the noise has been removed from the image, I decided to remove objects that were fewer than 100 pixels from the binary image, as I needed to isolate just the starfish objects. I used the bwareaopen function ```“bw = bwareaopen(Kmedian,100);”``` to remove these object, as shown on Figure 4.4.

Figure 4.4
![alt text](/Images/Figure4.4.PNG)


Afterwards, I wanted to fill the gaps in the objects, so I used the strel disk function with a radius of 4 ```“se = strel('disk',4);”```. This allowed the objects to be seen fuller on the outlines of their shapes. I again decided to use the imfill function ```“bw = imfill(bw,'holes');”``` to fill a set of background pixels to make the image clearer, Figure 4.5. I could have just used the imfill function once in the script, however as you can see in Figure 4.8, there is a slight difference between the two images and I decided to keep the functions in the script, as it provides a better suited image, Figure 4.7.

Figure 4.5
![alt text](/Images/Figure4.5.PNG)


To identify each object in the image, I had to use the label function ```“labeledImage = bwlabel(bw);”```. This function helps to identify each object in the image, as each of the objects will have a unique label. The next step I took was to measure the image region using the regionprops function ```“measurements = regionprops(labeledImage,'Area','Perimeter');”```, to calculate both the area and the perimeter of all the objects. After calculating the both the area and the perimeter of the objects, I then calculated the roundness of the objects to help identify which ones are the starfish in the binary image using this calculation ```“circularities = allPerimeters.^2 ./ (4*pi*allAreas);”```.

The next step I took was to get the area range of the starfish, by using the roundness and the area calculation ```“Starfish = circularities < 6 & allAreas < maxAllowableArea;”```. I estimated the max area of the starfish using trial and error ```“maxAllowableArea = 2000;”```. If the objects fitted the area range then they will be labelled as a starfish and the value will be bigger than zero. A non-zero value in the generated binary image will mean that the pixel belongs to a starfish ```“bw = ismember(labeledImage, Objects) > 0;”```, Figure 4.6.

Figure 4.6
![alt text](/Images/Figure4.6.PNG)


Finally, to complete the image segmentation process the objects were extracted from the binary image using the perimeter of the starfish and the number of the starfish in the image, which was 5 ```“BW2 = bwpropfilt(bw,'perimeter',5);”```. The extracted starfish were then displayed using the imshow function ```“imshow(BW2)”```, Figure 4.7.

Figure 4.7
![alt text](/Images/Figure4.7.PNG)

To improve the process taken to complete the task, I could have identified round objects using the boundary function “bwboundaries”, as this would be more efficient than using the trial and error method to estimate the area of the starfish. The use of this method would have saved time to find the starfish or any other object, as the function calculate the exterior boundary of the object.       

Figure 4.8
![alt text](/Images/Figure4.8.PNG)
