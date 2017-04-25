### Task
    Write code that fits 2-dimensional Gaussians to data. 
    The input file will be a single text file, like the text files in the UCI datasets directory. 
    A description of the datasets and the file format can be found on this link.
    Your code will be given as a command-line argument the path of a text file. 
    This text file could be any of the six files in the UCI datasets directory, but it could also be ANY OTHER file using the same format as the files in the datasets directory.
    
  <pre>
    <i><a href="http://vlm1.uta.edu/~athitsos/courses/cse6363_spring2017/assignments/uci_datasets/">UCI dataset</a></i> directory
</pre>
 
    A description of the datasets and the file format can be found on above link.
    You should only fit a 2D Gaussian to the first two dimensions of the data. You can ignore the other dimensions.
    
### Output
    The output of your code should contain one line for each class. Such a line should look like this:
    Class %d, mean = [%.2f, %.2f], sigma = [%.2f, %.2f, %.2f, %.2f]
    Note that, in the above output sample, %d is a place holder for an integer, and %.2f is a placeholder for a number with two decimal digits, following the Java and C printf conventions. With sigma we denote the covariance matrix. 
    The values of sigma should be printed in this order: [(row=1 col=1), (row=1 col=2), (row=2 col=1), (row=2 col=2)].
    In your answers.pdf document, provide the output produced by your program when given satellite_training.txt as the input file
  
### Running The Program 
  Execute the Commands :

       - python gaussian_2d.py
       - satellite_training.txt(or path to another file as user input)
