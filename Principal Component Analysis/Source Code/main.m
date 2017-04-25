function [] = main(train_file, test_file, M, iterations)
  
    %===================================
    %   Loading and Inistialising Data
    %===================================
    train_data = load(train_file);
    train_data = double(train_data);
    test_data = load(test_file);
    test_data = test_data(:, 1:end-1);
    U = zeros(size(train_data, 2)-1, M);
    data = train_data(:, 1:end-1);

    %===================================
    %   Calculating Eigen Vector - U
    %===================================
    for d = 1:M
        
        covariance = cov(data, 1);
        U(1:end, d) = power_method(covariance, iterations, size(data, 2));
        data = compute_X(data, U(1:end, d));
        
    end
    
    %===================================
    %   Printing Eigen Vector - U
    %===================================
    for i = 1:M
        fprintf('Eigenvector %d \n', i);
        for j = 1:size(train_data, 2)-1
            fprintf('%d : %.4f \n', j, U(j, i));
        end
    end
    
    %=========================================================
    %   Calculating Projection Matrix and Projection Values
    %=========================================================
    proj_mat = transpose(U);    
    proj_value =  proj_mat * transpose(test_data);
    
    %===================================
    %        Displaying Results
    %===================================
    for i = 1: size(test_data)
        fprintf('Test object %d \n', i-1);
        for j = 1:M
            fprintf('%d : %.4f\n', j, proj_value(j, i));
        end
    end
end
