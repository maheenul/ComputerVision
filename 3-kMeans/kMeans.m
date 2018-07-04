% MD MAHEENUL ISLAM
% K-means algorithm
%
%
%% Task 1
clc,clear;

img = double(imread('data/mandrill.png'));
% RGB to 2-D linear data
X = reshape(img,[size(img,1)*size(img,2),3]);
%
%
%
%% Task 2 and 3

randindex = randsample(1:(size(X,1)),4);
cluster = X(randindex,(1:size(X,2)));
repeat=0;

for ki = 1:1:repeat
    distance1 = zeros(size(X));
    distance2 = zeros(size(X));
    distance3 = zeros(size(X));
    distance4 = zeros(size(X));

    for i = 1:1:size(X,1)
        distance1(i,:) = X(i,:) - cluster(1,:);
        distance2(i,:) = X(i,:) - cluster(2,:);
        distance3(i,:) = X(i,:) - cluster(3,:);
        distance4(i,:) = X(i,:) - cluster(4,:);
    end

    % Squares each element in mean and then sums up the columns->(,2)
    EucDistance1 = sum(distance1.^2,2); EucDistance2 = sum(distance2.^2,2);
    EucDistance3 = sum(distance3.^2,2); EucDistance4 = sum(distance4.^2,2);
    EucDistanceAll = [EucDistance1,EucDistance2,EucDistance3,EucDistance4];

    dataCluster_index = zeros(size(X,1),1);
    cluster_total =zeros(4,4);
    cluster_mean =zeros(4,3);
    % Column-1: red, Column-2: blue, Column-3: green, Column-4: number of
    % pixels
    % Row-1: Cluster 1, Cluster 2, Cluster 3.......

    % Cluster labelling and sum of each cluster using all the pixels
    for i=1:1:size(X,1)
       [value,dataCluster_index(i,1)] = min(EucDistanceAll(i,:));

        if dataCluster_index(i,1) == 1
            cluster_total(1,4) = cluster_total(1,4) + 1;
            cluster_total(1,1) = cluster_total(1,1) + X(i,1);
            cluster_total(1,2) = cluster_total(1,2) + X(i,2);
            cluster_total(1,3) = cluster_total(1,3) + X(i,3);
        elseif dataCluster_index(i,1) == 2
            cluster_total(2,4) = cluster_total(2,4) + 1;
            cluster_total(2,1) = cluster_total(2,1) + X(i,1);
            cluster_total(2,2) = cluster_total(2,2) + X(i,2);
            cluster_total(2,3) = cluster_total(2,3) + X(i,3);
        elseif dataCluster_index(i,1) == 3
            cluster_total(3,4) = cluster_total(3,4) + 1;
            cluster_total(3,1) = cluster_total(3,1) + X(i,1);
            cluster_total(3,2) = cluster_total(3,2) + X(i,2);
            cluster_total(3,3) = cluster_total(3,3) + X(i,3);
        elseif dataCluster_index(i,1) == 4
            cluster_total(4,4) = cluster_total(4,4) + 1;
            cluster_total(4,1) = cluster_total(4,1) + X(i,1);
            cluster_total(4,2) = cluster_total(4,2) + X(i,2);
            cluster_total(4,3) = cluster_total(4,3) + X(i,3);
        end
    end

    % Calculation of means for each cluster
    for i=1:1:size(cluster_total,1)
       cluster_mean(i,:) = cluster_total(i,1:3) ./ cluster_total(i,4);
    end
    
    % Assigning each pixels to one of the 4 clusters
    X_new = zeros(size(X));
    for i=1:1:size(X,1)
        X_new(i,:) = cluster_mean(dataCluster_index(i,1),1:3);

    end

    X_new = reshape(X_new,[size(img,1),size(img,2),3]);
    imshow(uint8(X_new));

    cluster = cluster_mean;
    pause()
end
%
%
%
%
%% Task 4
clc,clear;

k = 4; n = 3; %For RGB n=3, k = cluster no
repeat = 6; % No. of times k-means algorithm is repeated

img = double(imread('mandrill.png'));
% RGB to 2-D linear data
X = reshape(img,[size(img,1)*size(img,2),n]);

% Random sampling of cluster points from image
randindex = randsample(1:(size(X,1)),k);
cluster = X(randindex,(1:size(X,2)));


for ki = 1:1:repeat
    % First n data columns for cluster 1, next n data columns for cluster 2 ..
    % n -> feature vector
    cluster_data = zeros(size(X,1),k*n);

    % Distance for each n for each point from each cluster
    for i = 1:n:(k*n)
        cluster_data(:,i:(i+n-1)) = X - cluster((i+n-1)/n,:);
    end

    % Squared distance for each n for each point from each cluster
    cluster_data = cluster_data.^2;

    % Eucleadian distance calculation for all points from each cluster
    EucDistance = zeros(size(X,1),k);
    for i = 1:n:(k*n)
        EucDistance(:,(i+n-1)/n) = sum(cluster_data(:,(i:(i+n-1))),2);
    end

    dataClusterMap = zeros(size(EucDistance,1),1);
    ClusterSum =zeros(k,n+1);
    ClusterMean =zeros(k,n);

    % ClusterSum
    % Columns:  1st to (end-1)th column = sum of n features. 
    %           end column = no. of data in cluster
    % Rows:     Number of clusters
    %
    % Calculation of cluster sums required for calculation of mean
    [~,dataClusterMap(:,:)] = min(EucDistance,[],2);
    for i=1:1:k
        temp=X(dataClusterMap==i,:);
        ClusterSum(i,:) = [sum(temp,1),size(temp,1)];
    end

    % Calculation of means for all cluster
    ClusterMean(:,:) = ClusterSum(:,1:end-1) ./ ClusterSum(:,4);
    
    % Assigning each pixels to one of the k means
    X_clustered = zeros(size(X));
    X_clustered(:,:)= ClusterMean(dataClusterMap(:,1),:);

    X_clustered = reshape(X_clustered,[size(img,1),size(img,2),3]);
    imshow(uint8(X_clustered));
    titleStr = strcat('K-means repreat = ',num2str(ki));
    title(titleStr);
    
    % Assigning new cluster
    cluster = ClusterMean;
    
    fprintf("Press any key to continue\n");
    pause()
end








