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
    A description of the datasets and the file format can be found on this link. 
    
<pre>
    <i><a href="http://vlm1.uta.edu/~athitsos/courses/cse6363_spring2017/assignments/uci_datasets/">UCI dataset</a></i> directory
</pre>
 
    
### Converting to Binary Classification Problem

        We have only covered logistic regression for binary classification problems. In this assignment, you should convert the class labels found in the files as follows:
        If the class label is equal to 1, it stays equal to 1.
        If the class label is not equal to 1, you must set it equal to 0.
        This way, your code will only see class labels that are 1 or 0.

### Weight Initialisation 
        All weights must be initialized to 0.
        

### Stopping Criteria

    For logistic regression, the training goes through iterations. At each iteration, you should decide as follows if you should stop the training:
    Compare the new weight values, computed at this iteration, with the previous weight values. If the sum of absolute values of differences of individual weights is less than 0.001, then you should stop the training.
    Compute the cross-entropy error, using the new weights computed at this iteration. Compare it with the cross-entropy error computed using the previous value of weights. If the change in the error is less than 0.001, then you should stop the training.
    
### Numerical Issues for Yeast Dataset

    Your code will probably not work on the yeast dataset for degree=2. Don't worry about that, we will not test for that case. As an optional (and zero-credit) task, figure out how to make the code work in this case. Feel free to do any changes you want, including ignoring some dimensions of the data. If you succeed, describe in your answers.pdf file what you did.
    
    
### Output of Training Stage
    printf("w0=%.4lf\n", w0);
    printf("w1=%.4lf\n", w1);
    printf("w2=%.4lf\n", w2);
    ...
    For any other language, just make sure that you use formatting specifies that produce aligned output that matches EXACTLY the specs given above for C. You should print exactly as many lines as the number of weights that you are estimating (D+1 weights if degree=1, 2D+1 weights if degree=2).
    
### Output of Test Stage

    After the training stage, you should apply the classifier that you have learned on the test data. For each test object (following the order in which each test object appears in the test file), you should print a line containing the following info:
    object ID. This is the line number where that object occurs in the test file. Start with 0 in numbering the objects, not with 1.
    predicted class (the result of the classification). If your classification result is a tie, choose one of them randomly.
    probability of the predicted class given the data. This probability is the output of the classifier if the predicted class is 1. 
    If the predicted class is 0, then the probability is 1 minus the output of the classifier.
    true class (should be binary, 0 or 1).
    accuracy. This is defined as follows:
    If there were no ties in your classification result, and the predicted class is correct, the accuracy is 1.
    If there were no ties in your classification result, and the predicted class is incorrect, the accuracy is 0.
    If there were ties in your classification result, and the correct class was one of the classes that tied for best, the accuracy is 1 divided by the number of classes that tied for best.
    If there were ties in your classification result, since we only have two classes, the accuracy is 0.5.
    To produce this output in a uniform manner, use these printing statements:
    Use:
    printf("ID=%5d, predicted=%3d, probability = %.4lf, true=%3d, accuracy=%4.2lf\n", 
           object_id, probability, predicted_class, true_class, accuracy);
           
 ### Running The Program
        1) type "logistic_regression(training_filename, degree, testing_filename)
        2) press enter.
        3) for example : logistic_regression('pendigits_training.txt', 1, 'pendigits_test.txt')
