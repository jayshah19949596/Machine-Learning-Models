### Task 1 
    In this task you will implement k-means clustering.
    
### Command-line Arguments
    Your program will be invoked as follows:
    k_means_cluster <data_file> <k> <iterations>
    The arguments provide to the program the following information:
    The first argument, <data_file>, is the path name of a file where the data is stored. 
    The path name can specify any file stored on the local computer.
    The second argument, <k>, specifies the number of clusters.
    The third argument, <iterations>, specifies the number of iterations of the main loop. 
    The initialization stage (giving a random assignment of objects to clusters, and computing the means of those random assignments) does not count as an iteration.
    The data file will follow the same format as the training and test files in the UCI datasets directory. 
    A description of the datasets and the file format can be found on this link. 
    Your code should also work with ANY OTHER training and test files using the same format as the files in the UCI datasets directory.
    As the description states, do NOT use data from the last column (i.e., the class labels) as features. 
    In these files, all columns except for the last one contain example inputs. The last column contains the class label.
    Link to data set is given below :
    
<pre>
    <i><a href="http://vlm1.uta.edu/~athitsos/courses/cse6363_spring2017/assignments/uci_datasets/">UCI dataset</a></i> directory
</pre>
    
### Implementation Guidelines
    Use the L2 distance (the Euclidean distance) for computing the distance between any two objects in the dataset.
    
### Output

    After the initialization stage, and after each iteration, you should print the value E(S1,S2,...,SK), as defined in page 27 of the clustering slides.
    The output should follow this format:

    After initialization: error = %.4f
    After iteration 1: error = %.4f
    After iteration 2: error = %.4f
    ...

### Running The Program
    1) open main.m file
    2) type  main('yeast_test.txt', 2, 5) in command window
    3) Press Enter
