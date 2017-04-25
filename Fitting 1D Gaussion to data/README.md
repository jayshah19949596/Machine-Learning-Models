### Task
    Write code that fits 1-dimensional Gaussians to data. The input file will be a single text file, like the text files in the datasets directory. 
    A description of the datasets and the file format can be found on this link.
    Your code will be given as a command-line argument the path of a text file. 
    This text file could be any of the six files in the UCI datasets directory, but it could also be ANY OTHER file using the same format as the files in the UCI datasets directory. Link is mentioned below:
    
    
<pre>
    <i><a href="http://vlm1.uta.edu/~athitsos/courses/cse6363_spring2017/assignments/uci_datasets/">UCI dataset</a></i> directory
</pre>
 
    A description of the datasets and the file format can be found on this link. 
    As the description states, do NOT use data from the last column (i.e., the class labels) in your calculations. 
    In these files, all columns except for the last one contain example inputs. The last column contains the class label.

### Outout

    The output of your code should contain one line for each dimension of each class. Such a line should look like this:
    Class %d, dimension %d, mean = %.2f, variance = %.2f

    In your answers.pdf document, provide the output produced by your program when given yeast_training.txt as the input file

### Running The Program 

    Commands to Execute:

      -python gaussian_1d.py
      -yeast_training.txt(or the path to any other file as user input)
