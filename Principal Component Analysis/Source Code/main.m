function [] = main(train_file, test_file, M, iterations)
    %train_file = 'pendigits_training.txt';
    %test_file = 'pendigits_test.txt';
    
    train_data = load(train_file);
    train_data = double(train_data);
    test_data = load(test_file);
    test_data = test_data(:, 1:end-1);
    
    
    %disp(size(train_data))
    %train_data = train_data(1:5, :);
    %disp(train_data)
    %M = 3;
    %N = size(train_data, 1);
    U = zeros(size(train_data, 2)-1, M);
    data = train_data(:, 1:end-1);
    %disp(data)
    for d = 1:M
        
        covariance = cov(data, 1);
        %size(U(1:end, d))
        U(1:end, d) = power_method(covariance, iterations, size(data, 2));
        %disp(U)
        data = compute_X(data, U(1:end, d));
        
    end
    
    for i = 1:M
        fprintf('Eigenvector %d \n', i);
        for j = 1:size(train_data, 2)-1
            fprintf('%d : %.4f \n', j, U(j, i));
        end
    end
    
    proj_mat = transpose(U);    
    proj_value =  proj_mat * transpose(test_data);
    
    for i = 1:1 %size(test_data)
        fprintf('Test object %d \n', i-1);
        for j = 1:M
            fprintf('%d : %.4f\n', j, proj_value(j, i));
        end
    end
end