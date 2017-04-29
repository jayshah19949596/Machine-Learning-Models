function [] = main(train_file, M, iterations)
    % =================================================%
    %            Loading and Initialising Data
    % =================================================%
    train_data = load(train_file);
    train_data = double(train_data);
    A = train_data*transpose(train_data);
    A_1 = train_data*transpose(train_data);
    U = zeros(size(train_data, 1), M);
    
    % =================================================%
    %         Calculating Eigen Vectors - U
    % =================================================%
    for d = 1: M
       U(:, d) = svd_power(A*A', iterations);
       %disp(size(U))
       for i = 1:size(A, 1)
           value = transpose(U(:, d)) * transpose(A(i, 1:end))*U(:, d);
           A(i, :) = A(i, :) - transpose(value);
       end
    end

    % =================================================%
    %  Calculating Lambda, Eigen Values, and S Diagonal
    % =================================================%
    lambda = transpose(U)*A_1*U;
    eigen_values = sqrt(max(lambda));
    S = zeros(M, M);
    for i = 1:M
        S(i, i) = eigen_values(1, i);
    end

    % =================================================%
    %                   Calculating V
    % =================================================%
    V = zeros(size(train_data, 2), M); 
    A = transpose(train_data)*train_data;
    for d = 1: M
       V(:, d) = svd_power(A*A', iterations);
       %disp(size(U))
       for i = 1:size(A, 1)
           value = transpose(V(:, d)) * transpose(A(i, 1:end))*V(:, d);
           A(i, :) = A(i, :) - transpose(value);
       end
    end
    
    % =================================================%
    %            Performing Reconstruction
    % =================================================%
    reconstruction = U*S*transpose(V);
    display(U, S, V, reconstruction)  
end

function [] = display(U, S, V, reconstruction)
    % =================================================%
    %            Displaying  Eigen Vectors - U
    % =================================================%
    fprintf('Matrix U: \n')
    for row = 1:size(U, 1)
        fprintf('Row%3d:', row);
        for col = 1:size(U, 2)
            fprintf('%8.4f', U(row, col));
        end
        fprintf('\n')
    end
    
    % =================================================%
    %            Displaying Diagonal Matrix - S
    % =================================================%
    fprintf('\n');
    fprintf('Matrix S: \n')
    for row = 1:size(S, 1)
        fprintf('Row%3d:', row);
        for col = 1:size(S, 2)
            fprintf('%8.4f', S(row, col));
        end
        fprintf('\n')
    end
    
    % =================================================%
    %            Displaying Matrix - V
    % =================================================%
    fprintf('\n');
    fprintf('Matrix V: \n')
    for row = 1:size(V, 1)
        fprintf('Row%3d:', row);
        for col = 1:size(V, 2)
            fprintf('%8.4f', V(row, col));
        end
        fprintf('\n')
    end
    
    
    % =================================================%
    %            Displaying Reconstruction Matrix
    % =================================================%
    fprintf('\n');
    fprintf('Reconstruction (U*S*V''): \n')
    for row = 1:size(reconstruction, 1)
        fprintf('Row%3d:', row);
        for col = 1:size(reconstruction, 2)
            fprintf('%8.4f', reconstruction(row, col));
        end
        fprintf('\n')
    end
    
end
    
