### Task 1 (100 points)

      In this task you will implement 1-nearest neighbor classification of time series using dynamic time warping (DTW) as the distance measure.
      Your zip file should have a folder called dtw_classification, which contains your code and the README.txt file.

### Command-line Arguments

      Your program will be invoked as follows:
      dtw_classify <training_file> <test_file>
      The arguments provide to the program the following information:
      The first argument, <training_file>, is the path name of the training file, where the training data is stored. The path name can specify any file stored on the local computer.
      The second argument, <test_file>, is the path name of the test file, where the test data is stored. The path name can specify any file stored on the local computer.
      The training and test files will follow the same format as the text files asl_training.txt and asl_test.txt. For example, for test object 40, file asl_test.txt contains the following information:
      object ID: 40
      class label: 53
      sign meaning: advice

      dominant hand trajectory:
            -0.098205	    0.584317
            -0.108025	    0.554856
            -0.088384	    0.535215
            -0.088384	    0.535215
            -0.068743	    0.545035
            -0.039282	    0.574497
             0.009820	    0.574497
             0.058923	    0.643240
             0.108025	    0.702162
             0.147307	    0.751265
             0.186589	    0.790547
             0.216050	    0.829828
             0.216050	    0.859290
             0.225870	    0.888751
             0.235691	    0.918212
             0.245511	    0.928033
             0.265152	    0.947674
      The object ID for that object is 40. The class label is 53, so classification of that object is correct if and only if its nearest neighbor among the training objects also has class label 53. In the example training and test files, for every test object there are only two training objects with the same class label.
      Each time series is a sequence of two-dimensional vectors. For the example shown above (test example 40), after the line with text "dominant hand trajectory", there is a sequence of 17 lines. The n-th line in that sequence contains the value of the n-th vector in the time series. Different objects have different length.

### Implementation Guidelines

      In contrast to the previous assignment, do NOT do any type of normalization on the time series values that you read from the files. Just use those values as they are.
      Use the L2 distance (the Euclidean distance) for computing the cost of matching two 2D vectors to each other. Use DTW, as described in the course slides, to compute the distance between two time series.

### Classification Stage

      For each test object you should print a line containing the following info:
      object ID. This number is explicitly stated in the file for each object. Note that object IDs are numbered starting from 1.
      predicted class (the result of the classification). If your classification result is a tie among two or more classes, choose one of them randomly.
      true class (from the last column of the test file).
      accuracy. This is defined as follows:
      If there were no ties in your classification result, and the predicted class is correct, the accuracy is 1.
      If there were no ties in your classification result, and the predicted class is incorrect, the accuracy is 0.
      If there were ties in your classification result, and the correct class was one of the classes that tied for best, the accuracy is 1 divided by the number of classes that tied for best.
      If there were ties in your classification result, and the correct class was NOT one of the classes that tied for best, the accuracy is 0.
      the DTW distance of the test object to its nearest neighbor in the training objects.
      To produce this output in a uniform manner, use these printing statements:
      Use:
      printf("ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2lf, distance = %.2lf\n", object_id, predicted_class, true_class, accuracy, distance);


      After you have printed the results for all test objects, you should print the overall classification accuracy, which is defined as the average of the classification accuracies you printed out for each test object. To print the classification accuracy in a uniform manner, use these printing statements:
      use:
      printf("classification accuracy=%6.4lf\n", classification_accuracy);

### Output for answers.pdf

      In your answers.pdf document, you need to provide the COMPLETE output for the following invocation of your program:
      dtw_classify asl_training.txt asl_test.txt

### Grading

      75 points: Correct implementation of the 1-nearest neighbor classifier with DTW as the distance measure.
      25 points: Following the specifications in producing the required output and in producing the answers.pdf file.

### Running The Program 
      1) open "main.m"
      2) type main('asl_training.txt', 'asl_test.txt') in the command window
      3) press enter.
