### Task
    In this task you will implement k-nearest neighbor classification using Euclidean Distance.
    
### Command-line Arguments

    Your program will be invoked as follows:
    knn_classify <training_file> <test_file> <k>
    The arguments provide to the program the following information:
    The first argument, <training_file>, is the path name of the training file, where the training data is stored. 
    The path name can specify any file stored on the local computer.
    The second argument, <test_file>, is the path name of the test file, where the test data is stored. 
    The path name can specify any file stored on the local computer.
    The third argument specifies the value of k for the k-nearest neighbor classifier.
    Files used will be any of the files in the UCI datasets directory 
    A description of the datasets and the file format can be found on below link. 
    
 <pre>
    <i><a href="http://vlm1.uta.edu/~athitsos/courses/cse6363_spring2017/assignments/uci_datasets/">UCI dataset</a></i> directory
</pre>
 
 ### Implementation Guidelines

        Each dimension should be normalized, separately from all other dimensions. 
        Specifically, for both training and test objects, each dimension should be transformed using function:
                - F(v) = (v - mean) / std, using the mean and std of the values of that dimension on the TRAINING data. 
        To compute the std, divide by the number of training data (NOT the number of training data minus 1).
        Use the L2 distance (the Euclidean distance) for computing the nearest neighbors
        
 ### Classification Stage

        For each test object you should print a line containing the following info:
        object ID. This is the line number where that object occurs in the test file. Start with 0 in numbering the objects, not with 1.
        predicted class (the result of the classification). If your classification result is a tie among two or more classes, choose one of them randomly.
        true class (from the last column of the test file).
        accuracy. This is defined as follows:
        If there were no ties in your classification result, and the predicted class is correct, the accuracy is 1.
        If there were no ties in your classification result, and the predicted class is incorrect, the accuracy is 0.
        If there were ties in your classification result, and the correct class was one of the classes that tied for best, the accuracy is 1 divided by the number of classes that tied for best.
        If there were ties in your classification result, and the correct class was NOT one of the classes that tied for best, the accuracy is 0.
        To produce this output in a uniform manner, use these printing statements:
        For C or C++, use:
        printf("ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2lf\n", object_id, predicted_class, true_class, accuracy);
        For Java, use:
        System.out.printf("ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n", object_id, predicted_class, true_class, accuracy);

        For Python or any other language, just make sure that you use formatting specifies that produce aligned output that matches the specs given for C and Java.
        After you have printed the results for all test objects, you should print the overall classification accuracy, which is defined as the average of the classification accuracies you printed out for each test object. To print the classification accuracy in a uniform manner, use these printing statements:
        Use:
        printf("classification accuracy=%6.4lf\n", classification_accuracy);


     
### Running The Program 
    Run the main.m file 

      main('pendigits_training.txt','pendigits_test.txt', 1)

      main('pendigits_training.txt','pendigits_test.txt', 3)

      main('pendigits_training.txt','pendigits_test.txt', 5)
