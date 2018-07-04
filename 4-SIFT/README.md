# SIFT Matching and Visualisation #

*Completed as a part of the Computer Vision course in Monash University*

***

In this laboratory exercise a SIFT algoithm will be utilized to match the features of two images.

The following tasks for this exercise have been completed in the file SIFT_algorithm.m located inside the 4-SIFT directory.
The inputs for the m-files are located inside the data directory and on executing the m-file all the results are saved inside the result directory.


The exercise consists of the following 3 tasks:

1.  Image acquisition and stitching
    -   Acquire two images of an object. The two images should be taken at slightly different angles.
    -   Load the images and join them horizontally into a single output image ("double-wide" image).

2.  Mini research and development
    -   Find a suitable SIFT detector online. Many SIFT MATLAB algorithms are available at the file exchange [MATLABCENTRAL](http://www.mathworks.com/matlabcentral/)
    -   Modify the SIFT algorithm to implement the image feature matching program.
    -   The program should plot all the keypoints onto the image.

3.  Match SIFT keypoints and show the matches
    -   Calculate the euclidean distance between each keypoint on one image with all the keypoints in the other image.
    -   Find the lowest(d1) and the second lowest(d2) euclidean distance for all the keypoints in either one of the  image.
    -   If (d1/d2)< 0.65 it is considered a match, otherwise it's not a match.
    -   Connect the keypoints that match with a straight line.