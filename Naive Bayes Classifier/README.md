### Task
    In this assignment you will implement naive Bayes classifiers based on histograms
    
### Command-line Arguments

    You must implement a program that learns a naive Bayes classifier for a classification problem.
    Given some training data and some additional options. In particular, your program will be invoked as follows:
    naive_bayes <training_file> <test_file> histograms <number>
    
### Training: Histograms

    If the third commandline argument is histograms, then you should model P(x | class) as a histogram separately for each dimension of the data. 
    The number of bins for each histogram is specified by the fourth command line argument.
    Suppose that you are building a histogram of N bins for the j-th dimension of the data and for the c-th class. 
    Let S be the smallest and L be the largest value in the j-th dimension among all training data belonging to the c-th class. 
    Let G = (L-S)/(N-3). G will be the width of all bins, except for bin 0 and bin N-1, whose width is infinite. 
    If you get a value of G that is less than 0.0001, then set G to 0.0001. Your bins should have the following ranges:

      Bin 0, covering interval (-infinity, S-G/2).
      Bin 1, covering interval [S-G/2, S+G/2).
      Bin 2, covering interval [S+G/2, S+G+G/2).
      Bin 3, covering interval [S+G+G/2, S+2G+G/2).
      ...
      Bin N-2, covering interval [S+(N-4)G+G/2, S+(N-3)G+G/2). This interval is the same as [L-G/2, L+G/2).
      Bin N-1, covering interval [S+(N-3)G+G/2, +infinity). This interval is the same as [L+G/2, +infinity).
      
    The output of the training phase should be a sequence of lines like this:
    Class %d, attribute %d, bin %d, P(bin | class) = %.2f
    The output lines should be sorted by class number. Within the same class, lines should be sorted by attribute number. 
    Within the same attribute, lines should be sorted by bin number. Attributes and bins should be numbered starting from 0, not from 1.
    In computing the value that you store at each bin of each histogram, you must use Equation 2.241 on page 120 of the textbook. 
    Notice that the width of the bin appears in the denominator of that equation. As mentioned above, the minimum width should be 0.0001. If your value of G is less than 0.0001, you should set G to 0.0001.

    In your answers.pdf document, provide the output produced by the training stage of your program when given yeast_training.txt as the input file, using seven bins for each histogram.
    
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
    For C or C++, use:
    printf("ID=%5d, predicted=%3d, probability = %.4lf, true=%3d, accuracy=%4.2lf\n", 
           object_id, probability, predicted_class, true_class, accuracy);
    For Java, use:
    System.out.printf("ID=%5d, predicted=%3d, probability = %.4f, true=%3d, accuracy=%4.2f\n", 
                      object_id, predicted_class, probability, true_class, accuracy);
