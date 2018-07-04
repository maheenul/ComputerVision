% MD MAHEENUL ISLAM
% 24861030
%% Task 1

clc,clear;

addpath('./data/');

imgleft = double((imread('data/left.jpg')));
points_xl = [337, 196, 1;
             467, 289, 1;
             252, 169, 1;
             262, 255, 1;
             241, 135, 1];
         
imshow(uint8(imgleft));
hold on

for i = 1:1:size(points_xl,1)
    plot(points_xl(i,1),points_xl(i,2),'r+');
end


%% Task 2

H = [1.6010,    -0.0300,   -317.9341;
     0.1279,    1.5325,    -22.5847;
     0.0007,    0,         1.2865];
 
points_xr = (H*points_xl')';

for i = 1:1:size(points_xr,1)
    points_xr(i,:) = points_xr(i,:)./(points_xr(i,3));
end

hold off
figure()
imgright = double((imread('data/right.jpg')));
imshow(uint8(imgright));
hold on

for i = 1:1:size(points_xr,1)
    plot(points_xr(i,1),points_xr(i,2),'r+');
end

%% Task 3
w = interp2(imgright,points_xr(:,1),points_xr(:,2))
disp(uint8(w));

%% Task 4
% points_right->1 = x
% points_right->2 = y
points_right = zeros(384,1024,2);
filter = zeros(384,1024);
filter((1:384),(1:512)) = 1;
temp = [0, 0, 1];
for x_loc = 1:1:1024
    for y_loc = 1:1:384
        temp(1) = x_loc; temp(2) = y_loc; temp(3) =1;
        temp = (H*temp')';
        temp = temp./temp(3);
        points_right(y_loc,x_loc,1)=temp(1,1);
        points_right(y_loc,x_loc,2)=temp(1,2);
    end
end
imgstitch = interp2(imgright,points_right(:,:,1),points_right(:,:,2));
positionsOfNaN = isnan(imgstitch);
positionsOfNaN = filter & positionsOfNaN;
imgstitch(positionsOfNaN) = imgleft(positionsOfNaN);
figure();
imshow(uint8(imgstitch));

%% Task5
%Cropping out black portion
imgfinal = zeros(384,780);
imgfinal(1:384,1:780) = imgstitch(1:384,1:780);
%Partial brightness adjustments
brightpf = 1.06;
imgfinal(positionsOfNaN) = imgstitch(positionsOfNaN).*brightpf;
%Full image brightness adjustments
brightf=0.9;
imgfinal = brightf.*imgfinal;
%Applying Gaussian
h = fspecial('gaussian', 4);
imgfinal = myConv2(imgfinal,h);

figure();
imshow(uint8(imgfinal));
imwrite(uint8(imgfinal),'result/Stitched.jpg','jpg','Comment','Stitched Image');

