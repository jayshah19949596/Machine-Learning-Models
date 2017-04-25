### Task
    In this task you will implement principal component analysis (PCA)
    
### Command-line Arguments

    Your program will be invoked as follows:
    pca_power <training_file> <test_file> <M> <iterations>
    The arguments provide to the program the following information:
    The first argument, <training_file>, is the path name of the training file, where the training data is stored. 
    The path name can specify any file stored on the local computer.
    The second argument, <test_file>, is the path name of the test file, where the test data is stored. 
    The path name can specify any file stored on the local computer.
    The third argument, <M>, specifies the dimension of the output space of the projection. 
    In other words, you will use the <M> with the largest eigenvalues to define the projection matrix.
    The fourth argument, <iterations>, is a number greater than or equal to 1, that specifies the number of iterations for the power method. 
    Use the power method to find the top eigenvector, using a sequence bk. 
    You should stop calculating this sequence after the specified number of iterations, and use the last bk (where k=<iterations>) as the eigenvector.
    The training and test files will follow the same format as the text files in the UCI datasets directory
### Training Stage Output

    After you compute the projection matrix using the training data, print out the top <M> eigenvectors, in decreasing order of their eigenvalues. Note that you do not need to know the eigenvalues to specify this order. You just print out the eigenvectors in the order in which they have been calculated, based on the pseudocode in slide 54 of the slides on PCA. The output should follow this format:
    Eigenvector 1
      1: %.4f
      2: %.4f
    ...
      D: %.4f

    Eigenvector 2
      1: %.4f
      2: %.4f
    ...
      D: %.4f

    ...

    Eigenvector M
      1: %.4f
      2: %.4f
    ...
      D: %.4f
    In the above output template:
    D is the number of dimensions of the training data.
    M is command-line argument <M>.
    In each line containing a value of an eigenvector, the first number (the dimension index) should be printed using the %3d format specification (an integer with three allocated spaces). The second value is simply the value of the eigenvector in that dimension, with exactly four decimal digits.
    
### Test Stage

    For each test object (in the order in which test objects appear in the test file), you should print the projection of that test object based on the projection you computed during training.
    The output should follow this format:

    Test object 0
      1: %.4f
      2: %.4f
    ...
      M: %.4f

    Test object 1
      1: %.4f
      2: %.4f
    ...
      M: %.4f

    ...
    In the above output template:
    M is command-line argument <M>.
    In each line containing a value of the projection of an object, follow the same instructions as for printing values of eigenvectors at the end of the training stage.
    Output for answers.pdf

    In your answers.pdf document, you need to provide parts of the output for some invocations of your program listed below. For each invocation, provide:
    The full output of the training stage.
    ONLY THE PROJECTION OF THE FIRST OBJECT for the test stage.
    Include this output for the following invocations of your program:
    pca_power pendigits_training pendigits_test 1 10
    pca_power satellite_training satellite_test 2 20
    pca_power yeast_training yeast_test 3 30

### Running The Program 
    
    Run any one of the below commands:

        main('pendigits_training.txt', 'pendigits_test.txt', 1, 10)

        main('satellite_training.txt', 'satellite_test.txt', 2, 20)

        main('yeast_training.txt', 'yeast_test.txt', 3, 30)
