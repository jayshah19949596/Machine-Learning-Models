### Task
    In this task you will implement principal component analysis (PCA)
    
### Command-line Arguments

    Your program will be invoked as follows:
    pca_power <training_file> <test_file> <M> <iterations>
    The arguments provide to the program the following information:
    The first argument, <training_file>, is the path name of the training file, where the training data is stored. 
    The path name can specify any file stored on the local computer.
    The second argument, <test_file>, is the path name of the test file, where the test data is stored. 
    The path name can specify any file stored on the local computer.
    The third argument, <M>, specifies the dimension of the output space of the projection. 
    In other words, you will use the <M> with the largest eigenvalues to define the projection matrix.
    The fourth argument, <iterations>, is a number greater than or equal to 1, that specifies the number of iterations for the power method. 
    Use the power method to find the top eigenvector, using a sequence bk. 
    You should stop calculating this sequence after the specified number of iterations, and use the last bk (where k=<iterations>) as the eigenvector.
    The training and test files will follow the same format as the text files in the UCI datasets directory
