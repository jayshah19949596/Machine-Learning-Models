### Task
  Write code that fits 1-dimensional Gaussians to data. The input file will be a single text file, like the text files in the datasets directory. A description of the datasets and the file format can be found on this link.
  Your code will be given as a command-line argument the path of a text file. This text file could be any of the six files in the UCI datasets directory, but it could also be ANY OTHER file using the same format as the files in the UCI datasets directory.

  As the description states, do NOT use data from the last column (i.e., the class labels) in your calculations. In these files, all columns except for the last one contain example inputs. The last column contains the class label.

  The output of your code should contain one line for each dimension of each class. Such a line should look like this:
  Class %d, dimension %d, mean = %.2f, variance = %.2f
  
  In your answers.pdf document, provide the output produced by your program when given yeast_training.txt as the input file
