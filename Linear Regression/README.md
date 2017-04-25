### Task
    In this task you will implement linear regression
    Data used is in the Data folder
    
### Command-line Arguments

    You must implement a program that uses linear regression to fit a line or a second-degree polynomial to a set of training data. 
    Your program can be invoked as follows:
    linear_regression <training_file> <degree> <λ>
    The arguments provide to the program the following information:
    The first argument is the path name of the training file, where the training data is stored. 
    The path name can specify any file stored on the local computer.
    The second argument is a number. This number should be either 1 or 2. 
    We will not test your code with any other values. If the number is 1, you should fit a line to the data. 
    If the number is 2, you should fit a second-degree polynomial to the data.
    The third number is a non-negative real number (it can be zero or greater than zero). 
    This is the value of λ that you should use for regularization. If λ = 0, then no regularization is used.
    The training file is a text file, containing data in tabular format. Each value is a number, and values are separated by white space. 
    Each row contains two numbers: the first of those numbers is the training input, and the second of those numbers is the target output.
    
### Output
    At the end, your program should print out the values of the weights that you have estimated.

    For C or C++, use:
    printf("w0=%.4lf\n", w0);
    printf("w1=%.4lf\n", w1);
    printf("w2=%.4lf\n", w2);
    For any other language, just make sure that you use formatting specifies that produce aligned output that matches EXACTLY the specs given above for C. Note that you print the value of w2 even when the command-line degree argument is 1. In that case, just print 0 for w2.
    
### Running the Program
     Run linear_regression.m
     In command Window type : 
            - linear_regression('sample_data1.txt', degree, lambda)
