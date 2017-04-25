function [] = main(train_file, test_file, k)
    %===============================================
    %                Loading Data
    %===============================================
    training_data = load(train_file);
    testing_data = load(test_file);
    train_target = training_data(:, end);
    test_target = testing_data(:, end);
    train_data = training_data(:, 1: end-1);
    test_data = testing_data(:, 1: end-1);
    %===============================================
    %     Calculating mean and standard deviation
    %===============================================
    mean_of_dimension = mean(train_data);
    std_deviation = std(train_data, 1);
    %===============================================
    %               Normalising Data
    %===============================================
    train_data = normalise(train_data, std_deviation, mean_of_dimension); % normalising training data 
    test_data = normalise(test_data, std_deviation, mean_of_dimension);   % normalising testing data
    %===============================================
    %           Performing Knn calculation
    %===============================================
    knn(train_data, test_data, train_target, test_target, k);
end