# Introductory Lab #

*Completed as a part of the Computer Vision course in Monash Univerity*

***

This laboratory exercise introduces the MATLAB programming environment and the functions available in the Image Processing Toolbox required for Computer Vision.

The following tasks for this exercise have been completed in the file introLab.m located inside the 1-IntroLab directory.
The inputs for the m-file are located inside the data directory and on executing the m-file all the results are saved inside the result directory.

The exercise consists of 5 main tasks:

1.  Importing and exporting an image:
    -   Use imread function to import an image.
    -   Use imwrite function to export an image.
    -   Optional:
        - Insert a figure title when using imshow.
        - Use imshow to display  two images side-by-side.

2.  Modifying image pixels:
    -   Clear workspace and command window.
    -   Import a grayscale image.
    -   Insert a black square at the top left corner of the image.
    -   Display and then export the image.
    -   Optional:
        -   Insert black square at the center of the image.
        -   Insert white square at the center of the image.

3.  Binary thresholding an image:
    -   Binary threshold a grayscale image using a threshold value of 128.
    -   Export the resuting image.

4.  Importing and Exporting a Video
    -   Import a video using the VideoReader function.
    -   Find the total number of frames in the video.
    -   Read one frame and display it using imshow function.
    -   Convert 200 frames of the video into grayscale.
    -   Export the resulting video using VideoWriter fucntion.

5.  Binary Thresholding a Video
    -   Binary threshold a video using a threshold value of 200.
    -   Export the resulting video.
