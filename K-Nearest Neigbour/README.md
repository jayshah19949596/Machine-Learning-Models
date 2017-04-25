### Task
    In this task you will implement k-nearest neighbor classification.
    
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
 
    
     
### Running The Program 
    Run the main.m file 

      main('pendigits_training.txt','pendigits_test.txt', 1)

      main('pendigits_training.txt','pendigits_test.txt', 3)

      main('pendigits_training.txt','pendigits_test.txt', 5)
