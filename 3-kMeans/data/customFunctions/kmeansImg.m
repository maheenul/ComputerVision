function [X_clustered]= kmeansImg(img,k,repeat)
%% Task 4
% MD MAHEENUL ISLAM
% K-means algorithm
% img: RGB input image
% k: Number of clusters to be assigned to that image.
% repeat: Number of times the k-mean algorithm is repeated.


% Check number of inputs.
if nargin > 3
    error('kmeansImg:TooManyInputs', ...
        'requires at most 3 optional inputs');
end

% Fill in unset optional values.
switch nargin
    case 1
        k = 4;
        repeat = 5;
    case 2
        repeat = 5;
end

n = 3; %For RGB n=3, k = cluster no

img = double(img);
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

    % Assigning new cluster
    cluster = ClusterMean;
end

% Assigning each pixels to one of the k means
X_clustered = zeros(size(X));
X_clustered(:,:)= ClusterMean(dataClusterMap(:,1),:);
X_clustered = reshape(X_clustered,[size(img,1),size(img,2),3]);
X_clustered = uint8(X_clustered);
