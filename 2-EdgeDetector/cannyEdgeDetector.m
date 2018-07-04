% Canny Edge Detector
% MD MAHEENUL ISLAM
%
%
%
%% Task 1
clc,clear all;

addpath('./data/');

%Gaussian Blur Kernel
Blur_mat= (1/159)*[2,4,5,4,2;4,9,12,9,4;5,12,15,12,5;4,9,12,9,4;2,4,5,4,2];
img = imread('data/lena.bmp','bmp');
Blur_img = myConv(img,Blur_mat);
figure();
imshow(uint8(Blur_img));
title('Blurred image')
imwrite(uint8(Blur_img),'result/blurredImage.jpg','jpg','Comment','Blurred Image')
%
%
%
%% Task 2
Gx_mat = [-1,0,1;-2,0,2;-1,0,1];
Gy_mat = [1,2,1;0,0,0;-1,-2,-1];

Gx_img = myConv(Blur_img,Gx_mat);
figure();
subplot(1,2,1);
imshow(uint8(Gx_img));
title('Gx * A');
imwrite(uint8(Gx_img),'result/Gx.jpg','jpg','Comment','Gradient x')

Gy_img = myConv(Blur_img,Gy_mat);
subplot(1,2,2);
imshow(uint8(Gy_img));
title('Gy * A');
imwrite(uint8(Gy_img),'result/Gy.jpg','jpg','Comment','Gradient y')
%
%
%
%% Task 3
Gxy_img = (Gx_img.^2 + Gy_img.^2).^(0.5);
figure();
imshow(uint8(Gxy_img));
title('Image gradient magnitude');
imwrite(uint8(Gxy_img),'result/Gxy.jpg','jpg','Comment','Gradient Magnitude');
%
%
%
%% Task 4
G_dir_raw = (atan2(Gy_img,Gx_img)*(180/pi));
G_dir = zeros(size(Gxy_img));
half_range = 22.5;

for ix = 1:1:size(Gxy_img,2)
    for iy = 1:1:size(Gxy_img,1)
        %East%
        if G_dir_raw(iy,ix)> -half_range && G_dir_raw(iy,ix)< half_range
            G_dir(iy,ix)=0;
        %West%
        elseif (G_dir_raw(iy,ix)> 180-half_range || G_dir_raw(iy,ix)< -180+half_range)
                G_dir(iy,ix)=180;
        %North%
        elseif G_dir_raw(iy,ix)> 90-half_range && G_dir_raw(iy,ix)< 90+half_range
                G_dir(iy,ix)=90;
        %South%
        elseif G_dir_raw(iy,ix)> -90-half_range && G_dir_raw(iy,ix)< -90+half_range
                G_dir(iy,ix)=-90;
        %South-East%
        elseif G_dir_raw(iy,ix)> -45-half_range && G_dir_raw(iy,ix)< -45+half_range
                G_dir(iy,ix)=-45;
        %North-East%
        elseif G_dir_raw(iy,ix)> 45-half_range && G_dir_raw(iy,ix)< 45+half_range
                G_dir(iy,ix)=45;
        %North-West%
        elseif G_dir_raw(iy,ix)> 135-half_range && G_dir_raw(iy,ix)< 135+half_range
                G_dir(iy,ix)=135;
        %South-West%
        elseif G_dir_raw(iy,ix)> -135-half_range && G_dir_raw(iy,ix)< -135+half_range
                G_dir(iy,ix)=-135;
        end
    end
end
figure();
imagesc(uint8(G_dir));
title('Image gradient direction');
imwrite(uint8(G_dir),'result/GDirection.jpg','jpg','Comment','Gradient Direction');
%
%
%
%% Task 5
sizeG = size(Gxy_img);
image_supp = zeros(sizeG(1),sizeG(2));
threshold = 60;

for ix = 2:1:sizeG(2)-1
    for iy = 2:1:sizeG(1)-1
        %East or West%
        if (G_dir(iy,ix)== 0 || (G_dir(iy,ix))==180) 
            if (Gxy_img(iy,ix)>Gxy_img(iy,ix-1) && Gxy_img(iy,ix)>Gxy_img(iy,ix+1))
                image_supp(iy,ix)=Gxy_img(iy,ix);
            else
                image_supp(iy,ix)=0;
            end
        end
        
        %North or South%
        if (G_dir(iy,ix)==90 || G_dir(iy,ix)==-90)
            if (Gxy_img(iy,ix)>Gxy_img(iy-1,ix) && Gxy_img(iy,ix)>Gxy_img(iy+1,ix))
                image_supp(iy,ix)=Gxy_img(iy,ix);
            else
                image_supp(iy,ix)=0;
            end
        end
        %South-East or North-West%
        if (G_dir(iy,ix)==-45 || G_dir(iy,ix)==135)
            if (Gxy_img(iy,ix)>Gxy_img(iy+1,ix+1) && Gxy_img(iy,ix)>Gxy_img(iy-1,ix-1))
                image_supp(iy,ix)=Gxy_img(iy,ix);
            else
                image_supp(iy,ix)=0;
            end
        end
        %North-East or South-West%
        if (G_dir(iy,ix)==45 || G_dir(iy,ix)==-135)
            if (Gxy_img(iy,ix)>Gxy_img(iy-1,ix+1) && Gxy_img(iy,ix)>Gxy_img(iy+1,ix-1))
                image_supp(iy,ix)=Gxy_img(iy,ix);
            else
                image_supp(iy,ix)=0;
            end
        end
    end
end
figure();
histogram(image_supp,20);
title('Histogram for selection of threshold');

figure();
tImage=image_supp>threshold;
imshow(tImage);
title('Result using canny edge detector');
imwrite(tImage,'result/detectedEdge.jpg','jpg','Comment','Edge Detection');