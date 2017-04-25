### Task
    In this task you will implement logistic regression using Iterative Reweighted Least Square
    
### Command-line Arguments

    You must implement a program that uses linear regression to fit a line or a second-degree polynomial to a set of training data. 
    Your program can be invoked as follows:
        logistic_regression <training_file> <degree> <test_file>
    The arguments provide to the program the following information:
    The first argument, <training_file>, is the path name of the training file, where the training data is stored. 
    The path name can specify any file stored on the local computer.
    The second argument, <degree> is a number equal to either 1 or 2. 
    We will not test your code with any other values. The degree specifies what function φ you should use. 
    Suppose that you have an input vector x = (x1, x2, ..., xD)T,.
    If the degree is 1, then φ(x) = (1, x1, x2, ..., xD)T.
    If the number is 2, then φ(x) = (1, x1, (x1)2, x2, (x2)2..., xD, (xD)2)T.
    The third argument, <test_file>, is the path name of the test file, where the test data is stored. 
    The path name can specify any file stored on the local computer.
    The training and test files will follow the same format as the text files in the UCI datasets directory.
    A description of the datasets and the file format can be found on this link. 
    For each dataset, a training file and a test file are provided. 
    The name of each file indicates what dataset the file belongs to, and whether the file contains training or test data. 
    Your code should also work with ANY OTHER training and test files using the same format as the files in the UCI datasets directory.
