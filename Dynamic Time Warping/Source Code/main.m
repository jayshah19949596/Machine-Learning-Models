function [] = main(train_file, test_file)
    %===============================================
    %              Reading the files
    %===============================================
    [train_data_col1, train_data_col2, train_class, train_lenght] = load_data(train_file);
    [test_data_col1, test_data_col2, test_class, test_lenght] = load_data(test_file);
    
    %===============================================
    %                Perfrom DTW 
    %===============================================
    dtw(train_data_col1, train_data_col2, train_class, train_lenght, test_data_col1, test_data_col2, test_class, test_lenght)
end