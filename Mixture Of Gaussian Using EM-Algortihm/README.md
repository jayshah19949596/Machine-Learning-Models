### Task
    You must implement a program that learns a naive Bayes classifier for a classification problem. 
    
    
### Command-line Arguments
    Given some training data and some additional options. In particular, your program can be invoked as follows:
      naive_bayes <training_file> <test_file> mixtures <number>

### Training: Mixtures of Gaussians

    If the third commandline argument is mixtures, then you should model P(x | class) as a mixture of Gaussians separately for each dimension of the data. 
    The number of Gaussians for each mixture is specified by the fourth command line argument.
    Suppose that you are building a mixture of N Gaussians for the j-th dimension of the data and for the c-th class. 
    Let S be the smallest and L be the largest value in the j-th dimension among all training data belonging to the c-th class. 
    Let G = (L-S)/N. Then, you should initialize all standard deviations of the mixture to 1, you should initialize all weights to 1/N, and you should initialize the means as follows:

      For the first Gaussian, the initial mean should be S + G/2.
      For the second Gaussian, the initial mean should be S + G + G/2.
      For the third Gaussian, the initial mean should be S + 2G + G/2.
      ...
      For the N-th Gaussian, the initial mean should be S + (N-1)G + G/2.
      You should repeat the main loop of the EM algorithm 50 times. So, no need to worry about any other stopping criterion.
      Your stopping criterion is simply that the loop has been executed 50 times.
      In certain cases, it is possible that the M-step computes a value for the standard deviation that is equal to zero. 
      Your code should make sure that the variance of the Gaussian is NEVER smaller than 0.0001. 
      Since the variance is the square of the standard deviation, this means that the standard deviation should never be smaller than sqrt(0.0001) = 0.01. 
      Any time the M-step computes a value for the standard deviation that is smaller than 0.01, your code should replace that value with 0.01.

    The output of the training phase should be a sequence of lines like this:

    Class %d, attribute %d, Gaussian %d, mean = %.2f, std = %.2f
    The output lines should be sorted by class number. Within the same class, lines should be sorted by attribute number. 
    Within the same attribute, lines should be sorted by Gaussian number. 
    Attributes and Gaussians should be numbered starting from 0, not from 1.
    In your answers.pdf document, provide the output produced by the training stage of your program when given yeast_training.txt as the input file, using three Gaussians for each mixture.
    
    
### Classification

      For each test object you should print a line containing the following info:
      object ID. This is the line number where that object occurs in the test file. Start with 0 in numbering the objects, not with 1.
      predicted class (the result of the classification). If your classification result is a tie among two or more classes, choose one of them randomly.
      probability of the predicted class given the data.
      true class (from the last column of the test file).
      accuracy. This is defined as follows:
      If there were no ties in your classification result, and the predicted class is correct, the accuracy is 1.
      If there were no ties in your classification result, and the predicted class is incorrect, the accuracy is 0.
      If there were ties in your classification result, and the correct class was one of the classes that tied for best, the accuracy is 1 divided by the number of classes that tied for best.
      If there were ties in your classification result, and the correct class was NOT one of the classes that tied for best, the accuracy is 0.
      To produce this output in a uniform manner, use these printing statements:
      use:
      printf("ID=%5d, predicted=%3d, probability = %.4lf, true=%3d, accuracy=%4.2lf\n", 
             object_id, probability, predicted_class, true_class, accuracy);
      
      For Python or any other language, just make sure that you use formatting specifies that produce aligned output that matches the specs given for C and Java.
      Object IDs should be numbered starting from 0, not 1.
      After you have printed the results for all test objects, you should print the overall classification accuracy, which is defined as the average of the classification accuracies you printed out for each test object. 
      
 ### Running The Program 
        For Mixture of Gaussians:
            1) type "python naive_bayes.py"
            2) press enter.
            3) type "naive_bayes yeast_training.txt yeast_test.txt mixtures 3"
            4) press enter.
