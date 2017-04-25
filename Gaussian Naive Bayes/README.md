### Task
  
  You must implement a program that learns a naive Bayes classifier for a classification problem, given some training data and some additional options. 
  In particular, your program will be invoked as follows:
    - naive_bayes <training_file> <test_file> gaussians
    
### Training: Gaussians

If the third commandline argument is gaussians, then you should model P(x | class) as a Gaussian separately for each dimension of the data. 
The output of the training phase should be a sequence of lines like this:
  Class %d, attribute %d, mean = %.2f, std = %.2f
The output lines should be sorted by class number.
Within the same class, lines should be sorted by attribute number. 
Attributes should be numbered starting from 0, not from 1.
In certain cases, it is possible that value computed for the standard deviation is equal to zero. 
Your code should make sure that the variance of the Gaussian is NEVER smaller than 0.0001. 
Since the variance is the square of the standard deviation, this means that the standard deviation should never be smaller than sqrt(0.0001) = 0.01. 
Any time the value for the standard deviation is computed to be smaller than 0.01, your code should replace that value with 0.01.

In your answers.pdf document, provide the output produced by the training stage of your program when given yeast_training.txt as the input file.

### Running The Program
    - naive_bayes yeast_training.txt yeast_test.txt
