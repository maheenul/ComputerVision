# Canny Edge Detection #

*Completed as a part of the Computer Vision course in Monash University*

***

In this laboratory exercise the algorithm for canny edge detector will be written **without** using any of the in-built MATLAB edge detection functions.

The following tasks for this exercise have been completed in the file cannyEdgeDetector.m located inside the 2-EdgeDetector directory.
The inputs for the m-file are located inside the data directory and on executing the m-file all the results are saved inside the result directory.

The exercise consists of 5 main tasks:

1.  Implement gaussian blur:
    -   Write a program that performs gaussian blur on an image using a suitable 5X5 kernel.

2.  Calculate image gradients:
    -   Calculate the gradient of the blurred image in both x and y direction using respective 3X3 sobel filters.

3.  Calculate gradient magnitude:
    -   Extend the program to calculate magnitude of the image gradients.

4.  Calculate Gradient orientation
    -   Extend the program to calculate gradient orientation.

5.  Non-maxima Suppression and thresholding
    -   Extend the code to perform non-maxima supression to "thin" the edges. The summary can be found in the following [wikipedia link](https://en.wikipedia.org/wiki/Canny_edge_detector#Non-maximum_suppression)
    -   Final output should be a binary image.