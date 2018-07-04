# k-Means Clustering #

*Completed as a part of the Computer Vision course in Monash University*

***

In this laboratory exercise the algorithm for k-means will be programmed and applied on some images.

The following tasks for this exercise have been completed in the file kMeans.m and skinExtractor.m located inside the 3-kMeans directory.
The inputs for the m-files are located inside the data directory and on executing the m-files all the results are saved inside the result directory.
k-Means.m contains task-1 to task-4 and skinExtractor.m contains task-5.

The data directory contains an image directory named imageDatabase which contains images that are used to test the skin segmentation program (skinExtractor.m file). It also contains another directory names customFunctions which contains some self-written function to perform convolution, kmeans, erosion and dilation of image. These functions were initially used by the skin segmentation program, but were later dropped to optimise the program.

The exercise consists of the following 5 tasks:

1.  Load and display a coloured image and convert it to a 2D image.
    -   Load and display a coloured image.
    -   Convert the 3D colour image(M rows, N columns, 3 colours) to a 2D colour image(M X N rows, 3 columns for R,G,B)

2.  Perform K-means clustering on the image (Part-1):
    -   Step-1:   Randomly choose 4 pixels from the image and initialise each of the means to the colour values of these pixels.
    -   Step-2:   Go through all the pixels in the image and calculate which of the 4 means that it is closest to. For each pixel, store the index of the nearest mean at the same pixel location in a separate array.
    -   Step-3:   Recompute each mean by going through all the pixels in the colour image that were assigned to that mean.

3.  Perform K-means clustering on the image (Part-2):
    -   Step-4:  Create an output RGB image where each pixel is colour coded with the newly computed mean to which it was assigned in Step 2.
    -   Step-5:   Wait for a keypress and redo steps 2-4.

4.  Repeatability:
    -   Run the program a different number of times and check whether it converges to the same answer.
    -   Change k and observe how it effects the program.

5.  Skin segmentation program (Mini Project):
    -   Design a skin segmentation program using k-means algorithm.
    -   Skin thresholding in the YCbCr color mode can be used.
    -   Other image processing techniques such as normalisation, erosion and dilation can also be used in conjuction.
