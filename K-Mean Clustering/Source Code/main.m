function [] = main(file, k, iterations)
    %=======================================
    %           Initialising Data
    %=======================================
    % k = 3;
    % iterations = 20;
    % file = 'yeast_test.txt';
    data = load(file);
    rows = size(data, 1);
    cols = size(data, 2);
    data = data(1:rows, 1:cols-1);
    clusters = randi([1 k], rows, 1);
    clustered_data = [data clusters];
    mean_matrix = zeros(k, cols-1);
    
    %=======================================
    %           Calculating Mean
    %=======================================
    for i = 1:k
       index = clustered_data(:, end) == i;
       indexed_data = clustered_data(index, 1:end-1);
       mean_matrix(i, :) = mean(indexed_data);
       
    end
    
    %=======================================
    %           Computing Error
    %=======================================
    error = get_error(clustered_data, mean_matrix);
    fprintf('After initialization: error = %.4f \n', error);
    
    %=======================================
    %           Starting Iterations
    %=======================================
    for p = 1:iterations
       for q = 1:rows
          %=======================================
          % Deciding which Cluster data belongs
          %=======================================
          dist = get_euclidean(data(q, :), mean_matrix);
          [minimum_row, minimum_col] = min(dist);
          clusters(q) = minimum_col;
       end
       clustered_data = [data, clusters];
       
       %=======================================
       %          Calculating Mean
       %=======================================
       for i = 1:k
          index = clustered_data(:, end) == i;
          indexed_data = clustered_data(index, 1:end-1);
          mean_matrix(i, :) = mean(indexed_data);
       end
       %=======================================
       %           Computing Error
       %=======================================
       error = get_error(clustered_data, mean_matrix);
       fprintf('After iteration %d: error = %.4f \n', p, error);
    end
end

function [error] = get_error(data, mean_matrix)
    %=======================================
    %           Computing Error
    %=======================================
    error = 0;
    for j = 1: size(data, 1)
       c = data(j, end);
       dist = get_euclidean(data(j, 1:end-1), mean_matrix(c, 1:end));
       error = error + dist;
    end
end

function [distance_matrix] = get_euclidean(data, mean_matrix)
    %=======================================
    %           Calculating Euclidean
    %=======================================
    dist = data - mean_matrix;
    dist = dist.^2;
    dist = sum(dist, 2);
    distance_matrix = sqrt(dist);
end