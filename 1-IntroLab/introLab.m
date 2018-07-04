% IntroLab
% Name: Md Maheenul Islam
%
%
%
%% Task 1
x=imread('data/lenacolor.tiff');
x2=imread('data/lena.bmp');

figure();
subplot(1,2,1);
imshow(x);
title('Lena colour');

subplot(1,2,2);
imshow(x2);
title('Lena grayscale');

imwrite(x,'result/IntroTask1.jpg','jpg','Comment','My JPEG file')

% Views information about the new file.
imfinfo('result/IntroTask1.jpg')
%
%
%
%% Task 2
clear,clc;
x2 = imread('data/lena.bmp');
black_tlc=x2;
black_tlc(1:100,1:100)=0;
figure();
subplot(1,3,1);
imshow(black_tlc);
title('Black square at top left corner');
imwrite(black_tlc,'result/IntroTask2.bmp','bmp');

% Optional 1
xcen = (size(x2,1)-100)/2;
ycen = (size(x2,2)-100)/2;
black_cen=x2;
black_cen(xcen:xcen+100,ycen:ycen+100)=0;
subplot(1,3,2);
imshow(black_cen);
title('Black square at the center');

% Optional 2
xbrc = (size(x2,1)-100);
ybrc = (size(x2,2)-100);
white_brc = x2;
white_brc(xbrc:end,ybrc:end)=255;
subplot(1,3,3);
imshow(white_brc);
title('White square at bottom right corner');
%
%
%
%% Task 3
threshold = 128;

x2 = 255.*(x2>threshold);
figure();
imshow(x2);
imwrite(x2,'result/IntroTask3.bmp','bmp');
title('Binary image');
%
%
%
%% Task 4
% Step 1 and 2
vidFrog= VideoReader('data/video.m4v');
Frames = vidFrog.FrameRate * vidFrog.Duration;

% Step 3
MyVariable = read(vidFrog,1000);
figure()
imshow(MyVariable);
title('1000th frame of the video');
%
% Step 4 and 5
writerObj = VideoWriter('result/IntroTask4.avi')
writerObj.FrameRate = 20;
open(writerObj);

for iter = 1:1:200
    MyFrame = read(vidFrog,iter);
    GrayFrame = rgb2gray(MyFrame);
    writeVideo(writerObj,GrayFrame);
end

close(writerObj);
%
%
%
%% Task 5
writerObj = VideoWriter('result/IntroTask5.avi')
writerObj.FrameRate = 20;
open(writerObj);

for iter = 1:1:200
    MyFrame = read(vidFrog,iter);
    GrayFrame = rgb2gray(MyFrame);
    ThGrayFrame = double(GrayFrame>200);
    writeVideo(writerObj,ThGrayFrame);
end

close(writerObj);