%% ********************This program finds the key points and their descriptors**************************************
%% **********************Submitted to Texas Instruments on October 1st 2013*****************************************
%% ****************************************By:Ch.Naveen*************************************************************
%% Loading image
% Modified by : Maheenul
%
%
clc;
close all;
clear all;
%
%% Task 1
% img1 and img2 images which will be converted to an double image(img)
img1=imread('data/image1.pgm');%('data/a.jpg');
img2=imread('data/image2.pgm');%('data/b.jpg');
img=[img1,img2];
imwrite(img,'result/c.jpg');
%
% Resize the image
a=imresize(img,[size(img,1),size(img,2)]);
%
threshold = 0.10;   % Threshold controlling the matching criterion
%
partition=0.5;      % Decides the seperation point of the double image
                    % partion ranged from 0-1.
%                   
%
%% Important Variables
% Task 2
% a : Input image
% kpmag : keypoints magnitude
% kpori : keypoints orientation
% kpd   : key point descriptors
% kp    : keypoints
% kpl_n   : keypoint locations

[m,n,plane]=size(a);
if plane==3
a=rgb2gray(a);
end
a=im2double(a);
original=a;
store1=[];
store2=[];
store3=[];
tic
%% 1st octave generation
k2=0;
a(m:m+6,n:n+6)=0;
clear c;
for k1=0:3
    k=sqrt(2);
sigma=(k^(k1+(2*k2)))*1.6;
for x=-3:3
    for y=-3:3
        h(x+4,y+4)=(1/((2*pi)*((k*sigma)*(k*sigma))))*exp(-((x*x)+(y*y))/(2*(k*k)*(sigma*sigma)));
    end
end
for i=1:m
    for j=1:n
        t=a(i:i+6,j:j+6)'.*h;
        c(i,j)=sum(sum(t));
    end
end
store1=[store1 c];
end
clear a;
a=imresize(original,1/((k2+1)*2));

%% 2nd Octave generation
k2=1;
[m,n]=size(a);
a(m:m+6,n:n+6)=0;
clear c;
for k1=0:3
    k=sqrt(2);
sigma=(k^(k1+(2*k2)))*1.6;
for x=-3:3
    for y=-3:3
        h(x+4,y+4)=(1/((2*pi)*((k*sigma)*(k*sigma))))*exp(-((x*x)+(y*y))/(2*(k*k)*(sigma*sigma)));
    end
end
for i=1:m
    for j=1:n
        t=a(i:i+6,j:j+6)'.*h;
        c(i,j)=sum(sum(t));
    end
end
store2=[store2 c];
end
clear a;
a=imresize(original,1/((k2+1)*2));

%% 3rd octave generation
k2=2;
[m,n]=size(a);
a(m:m+6,n:n+6)=0;
clear c;
for k1=0:3
    k=sqrt(2);
sigma=(k^(k1+(2*k2)))*1.6;
for x=-3:3
    for y=-3:3
        h(x+4,y+4)=(1/((2*pi)*((k*sigma)*(k*sigma))))*exp(-((x*x)+(y*y))/(2*(k*k)*(sigma*sigma)));
    end
end
for i=1:m
    for j=1:n
        t=a(i:i+6,j:j+6)'.*h;
        c(i,j)=sum(sum(t));
    end
end
store3=[store3 c];
end
[m,n]=size(original);
fprintf('\nTime taken for Pyramid level generation is :%f\n',toc);

%% Obtaining key point from the image
i1=store1(1:m,1:n)-store1(1:m,n+1:2*n);
i2=store1(1:m,n+1:2*n)-store1(1:m,2*n+1:3*n);
i3=store1(1:m,2*n+1:3*n)-store1(1:m,3*n+1:4*n);
[m,n]=size(i2);
kp=[];
kpl=[];
tic
for i=2:m-1
    for j=2:n-1
        x=i1(i-1:i+1,j-1:j+1);
        y=i2(i-1:i+1,j-1:j+1);
        z=i3(i-1:i+1,j-1:j+1);
        y(1:4)=y(1:4);
        y(5:8)=y(6:9);
        mx=max(max(x));
        mz=max(max(z));
        mix=min(min(x));
        miz=min(min(z));
        my=max(max(y));
        miy=min(min(y));
        if (i2(i,j)>my && i2(i,j)>mz) || (i2(i,j)<miy && i2(i,j)<miz)
            kp=[kp i2(i,j)];
            kpl=[kpl i j];
        end
    end
end
fprintf('\nTime taken for finding the key points is :%f\n',toc);

%% Key points plotting on to the image
for i=1:2:length(kpl);
    k1=kpl(i);
    j1=kpl(i+1);
    i2(k1,j1)=1;
end
%figure, imshow(i2);
%title('Image with key points mapped onto it');

%%
for i=1:m-1
    for j=1:n-1
         mag(i,j)=sqrt(((i2(i+1,j)-i2(i,j))^2)+((i2(i,j+1)-i2(i,j))^2));
         oric(i,j)=atan2(((i2(i+1,j)-i2(i,j))),(i2(i,j+1)-i2(i,j)))*(180/pi);
    end
end
%% Added code for reduced keypoint selection
kpl_n=[];
for x1=1:2:length(kpl)
    k1=kpl(x1);
    j1=kpl(x1+1);
    if k1 > 7 && j1 > 7 && k1 < m-8 && j1 < n-8
        kpl_n= [kpl_n,k1,j1];
    end
end
%%
%% Forming key point neighbourhooods
kpmag=[];
kpori=[];
for x1=1:2:length(kpl)
    k1=kpl(x1);
    j1=kpl(x1+1);
    if k1 > 7 && j1 > 7 && k1 < m-8 && j1 < n-8 %k1 > 2 && j1 > 2 && k1 < m-2 && j1 < n-2
    p1=mag(k1-2:k1+2,j1-2:j1+2);
    q1=oric(k1-2:k1+2,j1-2:j1+2);
    else
        continue;
    end
    %% Finding orientation and magnitude for the key point
[m1,n1]=size(p1);
magcounts=[];
for x=0:10:359
    magcount=0;
for i=1:m1
    for j=1:n1
        ch1=-180+x;
        ch2=-171+x;
        if ch1<0  ||  ch2<0
        if abs(q1(i,j))<abs(ch1) && abs(q1(i,j))>=abs(ch2)
            ori(i,j)=(ch1+ch2+1)/2;
            magcount=magcount+p1(i,j);
        end
        else
        if abs(q1(i,j))>abs(ch1) && abs(q1(i,j))<=abs(ch2)
            ori(i,j)=(ch1+ch2+1)/2;
            magcount=magcount+p1(i,j);
        end
        end
    end
end
magcounts=[magcounts magcount];
end
[maxvm maxvp]=max(magcounts);
kmag=maxvm;
kori=(((maxvp*10)+((maxvp-1)*10))/2)-180;
kpmag=[kpmag kmag];
kpori=[kpori kori];
% maxstore=[];
% for i=1:length(magcounts)
%     if magcounts(i)>=0.8*maxvm
%         maxstore=[maxstore magcounts(i) i];
%     end
% end
% 
% if maxstore > 2
%     kmag=maxstore(1:2:length(maxstore));
%     maxvp1=maxstore(2:2:length(maxstore));
%     temp=(countl((2*maxvp1)-1)+countl(2*maxvp1)+1)/2;
%     kori=temp;
% end
end
fprintf('\nTime taken for magnitude and orientation assignment is :%f\n',toc);


%% Forming key point Descriptors
kpd=[];
for x1=1:2:length(kpl)
    k1=kpl(x1);
    j1=kpl(x1+1);
    if k1 > 7 && j1 > 7 && k1 < m-8 && j1 < n-8
    p2=mag(k1-7:k1+8,j1-7:j1+8);
    q2=oric(k1-7:k1+8,j1-7:j1+8);
    else
        continue;
    end
    kpmagd=[];
    kporid=[];
%% Dividing into 4x4 blocks
    for k1=1:4
        for j1=1:4
            p1=p2(1+(k1-1)*4:k1*4,1+(j1-1)*4:j1*4);
            q1=q2(1+(k1-1)*4:k1*4,1+(j1-1)*4:j1*4);  
            [m1,n1]=size(p1);
            magcounts=[];
            for x=0:45:359
                magcount=0;
            for i=1:m1
                for j=1:n1
                    ch1=-180+x;
                    ch2=-180+45+x;
                    if ch1<0  ||  ch2<0
                    if abs(q1(i,j))<abs(ch1) && abs(q1(i,j))>=abs(ch2)
                        ori(i,j)=(ch1+ch2+1)/2;
                        magcount=magcount+p1(i,j);
                    end
                    else
                    if abs(q1(i,j))>abs(ch1) && abs(q1(i,j))<=abs(ch2)
                        ori(i,j)=(ch1+ch2+1)/2;
                        magcount=magcount+p1(i,j);
                    end
                    end
                end
            end
            magcounts=[magcounts magcount];
            end
            kpmagd=[kpmagd magcounts];
        end
    end
    kpd=[kpd kpmagd];
end
fprintf('\nTime taken for finding key point desctiptors is :%f\n',toc);

%% Task 2
%% Added code for plotting red stars
tic
kpl_resize = reshape(kpl_n,[2,(size(kpl_n,2)/2)]);
if plane==3
    img_display = double(rgb2gray(img));
else
    img_display = double(img);
end
resultImg = figure('units','normalized','outerposition',[0 0 1 1]);
imshow(uint8(img_display));
hold on

plot(kpl_resize(2,:),kpl_resize(1,:),'r*');
fprintf('\nTime taken for plotting red asterisks :%f\n',toc);

%% Finding min. Euclidian dist.
% Task 3
tic
N=size(kpmag,2);
kpd_resize=transpose(reshape(kpd,size(kpmagd,2),N));

partition=floor(partition*size(img_display,2));

% Left Image
[sorted,indexSort1]=sort(kpl_resize(2,:));
indexSort1= indexSort1(sorted<=partition);
kpl_left=kpl_resize(:,indexSort1);
[~,indexSort2]=sort(kpl_left(1,:));
kpl_left = kpl_left(:,indexSort2);
keypointsLeft=kpd_resize(indexSort1,:);
keypointsLeft=keypointsLeft(indexSort2,:);

% Right Image
[sorted,indexSort1]=sort(kpl_resize(2,:));
indexSort1= indexSort1(sorted>partition);
kpl_right = kpl_resize(:,indexSort1);
[~,indexSort2]=sort(kpl_right(1,:));
kpl_right = kpl_right(:,indexSort2);
keypointsRight=kpd_resize(indexSort1,:);
keypointsRight=keypointsRight(indexSort2,:);

fprintf('\nTime taken to seperate keypoints :%f\n',toc);

%% Task 3
tic

[limit,I] = min([size(keypointsLeft,1),size(keypointsRight,1)]);

% "if" added to select the path with lower iterations for "for loop"
if (I==1)
    for  i = 1:1:limit
        pdistKey = pdist2(keypointsLeft(i,:),keypointsRight);
        [eucOrder,eucIndex]=sort(pdistKey,2);
        eucIndex=eucIndex(1,1);
        
        d = eucOrder(1,1)/eucOrder(1,2);
        if(d<threshold)
            plot(kpl_left(2,i),kpl_left(1,i),'b*');
            plot(kpl_right(2,eucIndex),kpl_right(1,eucIndex),'b*');
            plot([kpl_left(2,i),kpl_right(2,eucIndex)],[kpl_left(1,i),kpl_right(1,eucIndex)],'g-')
        end
    end
else
    for  i = 1:1:limit
        pdistKey = pdist2(keypointsRight(i,:),keypointsLeft);
        [eucOrder,eucIndex]=sort(pdistKey,2);
        eucIndex=eucIndex(1,1);
        
        d = eucOrder(1,1)/eucOrder(1,2);
        if(d<threshold)
            plot(kpl_right(2,i),kpl_right(1,i),'b*');
            plot(kpl_left(2,eucIndex),kpl_left(1,eucIndex),'b*');
            plot([kpl_right(2,i),kpl_left(2,eucIndex)],[kpl_right(1,i),kpl_left(1,eucIndex)],'g-')
        end
    end
end
saveas(resultImg,'result/kMatching.jpeg','jpeg');


fprintf('\nTime taken to find the eucledian distance :%f\n',toc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         END OF THE PROGRAM        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%