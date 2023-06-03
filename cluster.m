% Generate random data
rng(1);
X = [randn(100,2)*0.75+ones(100,2); randn(100,2)*0.5-ones(100,2)];

% Apply k-means clustering with k=2
k = 2;
[idx, centroids] = kmeans(X, k);

% Plot the results
figure;
gscatter(X(:,1), X(:,2), idx, 'bgr', '.', 10);
hold on;
plot(centroids(:,1), centroids(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
legend('Cluster 1', 'Cluster 2', 'Centroids');
title('K-Means Clustering Results');
xlabel('X1');
ylabel('X2');
