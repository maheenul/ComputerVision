% MD MAHEENUL ISLAM
% 24861030
%% Task 5
inputPath = './data/imageDatabase/';             % Directory of the folder,
                                            % where data files are located
                                            
outputPath = './result/';              % Directory of the folder,
                                            % where the results are saved
                                            
liste = dir(strcat(inputPath,'*.jpg'));     % Creates a list of all files 
                                            % in inputPath
                                            
files = {liste.name};                       % Creates a cell array with the 
                                            % name of the data file
                                            
addpath('./data/customFunctions');          % Adding path to custom functions

for k=1:numel(files)
    %% Reading image
    fileName = strcat(inputPath,files{k});
    resultName = strcat(outputPath,files{k});

    img = imread(fileName);
    img_norm=double(img);

    resultImg = figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(2,2,1)
    imshow(img);
    title('Original image')
    %% Parameters
    inorm=5;    % Number of times images are normalized according to 
                % ECCV98-finlayson. Recommended inorm is 4 or 5.
                % inorm=0 means no normalisation.

    cluster=6; % The number of clusters (k) for kmeans operation.

    repeat=6;   % The number of times erosion and dilations are repeated
                % It determines the magnitude of the opening and closing 
                % performed on the images.
                % repeat=0 means no erosion or dilation of the image.
                
    blur=0;     % Determines whether the image should be blurred prior to 
                % image RGB normalisation. 
                % blur=0 means off; otherwise on. Recommended blur=0.
    %% Blur image
    if (blur)
        img_norm = rgb2gray(img);
        img_norm = imgaussfilt(img_norm,2);
        img_norm = double(img).*(double(img_norm)/255);
    end
    
    %% Normalisation of image
    tic
    for i=1:inorm
        % Lighting geometry normalisation
        % temp added to avoid nan which occurs when divided by 0.
        temp=sum(img_norm,3);
        temp(temp==0)=1;
        img_norm1=img_norm./temp;

        % Illumination color normalisation
        img_norm2=numel(img_norm1(:,:,1))*img_norm1./sum(sum(img_norm1,1),2);
    end

    if(inorm)
    img_norm=double(img).*img_norm2;
    % Scaling values to the range 0-256
    img_norm=img_norm./(max(max(img_norm)))*256;
    end

    subplot(2,2,2)
    imshow(uint8(img_norm));
    title('Normalized image')
    toc

    %% Performing K-means on YCbCr image
    tic
    ycbcrImg = rgb2ycbcr(uint8(img_norm));
    X = double(reshape(ycbcrImg,[numel(ycbcrImg(:,:,1)),size(ycbcrImg,3)]));
    [ki,kvalue] = kmeans(X,cluster);
    X = ones(size(ki,1),size(img,3));
    for i = 1:size(kvalue,1)
        X(ki==i,:)=kvalue(i,:).*X(ki==i,:);
    end
    X = reshape(X,size(ycbcrImg));
    X=uint8(X);
    toc
    subplot(2,2,3)
    imshow(X);
    title('Clustered normalized image')

    XN=img;
    XN = XN.*uint8((X(:,:,2)>=77 & X(:,:,2)<=127));
    XN = XN.*uint8((X(:,:,3)>=133 & X(:,:,3)<=173));

    %% Erosion and dilation of image
    tic;
    mask=logical(sum(XN,3));
    structure_mat=[0 1 0;1 1 1;0 1 0];

    % Closing
    for i=1:repeat
    mask=imdilate(mask,structure_mat);
    end
    for i=1:repeat
    mask=imerode(mask,structure_mat);
    end

    % Opening
    for i=1:repeat
    mask=imerode(mask,structure_mat);
    end
    for i=1:repeat
    mask=imdilate(mask,structure_mat);
    end

    if (repeat)
        XN=img.*uint8(mask);
    end
    toc

    subplot(2,2,4)
    imshow(XN);
    title('Masked image')

    saveas(resultImg,resultName,'jpeg');
    close(resultImg);
end