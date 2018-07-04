# Image stitching by homography #

*Completed as a part of the Computer Vision course in Monash University*

***

In this laboratory exercise a program to stitch two images with known homography into a single wide-angle image using bilinear interpolation is developed.

The following tasks for this exercise have been completed in the file imgStitching.m located inside the 5-ImageStitching directory.
The inputs for the m-files are located inside the data directory and on executing the m-file all the results are saved inside the result directory.


The exercise consists of the following 5 tasks:

1.  Drawing test points on the left image
    -   Draw the test points on the left image.
    -   3-element homogeneous coordinates are transformed to 2D image pixel coordinates by dividing the first and second elements by the third

2.  Use of Homography to find the right image pixels
    -   Apply the homography to transform the left image points to the corresponding locations in the right image. 
    -   Draw the transformed points as red crosses.

3.  Bilinear interpolation of the right image
    -   Use interp2 function to interpolate pixel values at non-integer pixel locations.
    -   Print the interpolated grayscale value for each transformed point.

4.  Image stitching
    -   Create a 1024x384 (width x height) image and fill the LHS with the left image.
    -   The stitched image will use the left image coordinate system (xl) throughout the stitching process.
    -   Fill in the remaining 512x384 pixels on the RHS by transforming their pixel coordinates (left image coordinates) to the right image coordinates via the homography.
    -    Sample the right image to fill in the missing parts of the stitched image pixel-by-pixel as follows:
        -   If the right pixel coordinate is valid, generate the pixel value using bilinear interpolation.
        -   If the right pixel coordinate is invalid, use a pixel value of zero.
    -   Display the stitching results.

5.  Better blending
    -   Adjust the width of the output image so that less black pixels are visible
    -   Adjust the brightness (by a scaling factor) of each image so that the seam is less visible
    -   Apply a small amount of Gaussian blur or alpha blending near the seam to make it less visible
    -   Adjust the horizontal location of the seam (it can be moved further to the left as the right image overlaps into the left by quite a few pixels).