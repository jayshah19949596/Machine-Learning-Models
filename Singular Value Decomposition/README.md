### Task
  In this task you will implement singular value decomposition (SVD). 
  More specifically, you will compute the matrices U, S, V for a specific input matrix, and for a specific target dimensionality. 
  Where needed, you will find eigenvectors using the power method.
  
### Command-line Arguments

    Your program will be invoked as follows:
    svd_power <data_file> <M> <iterations>
    The arguments provide to the program the following information:
    The first argument, <data_file>, is the path name of the file where the input matrix is stored. 
    The path name can specify any file stored on the local computer. 
    The data file will have as many lines as the rows of the input matrix. 
    Line n will contain the values in the n-th row of the matrix. 
    Within that line n, values will be separated by white space. An example data file is input1.txt. 
    Values can be any real numbers, and the input matrix can have any number of rows and columns.
    The second argument, <M>, specifies the number of dimensions for the SVD output. 
    In other words, the U matrix should have <M> columns, the V matrix should have <M> columns, and the S matrix should have <M> rows and <M> columns. Remember, the diagonal entries Sd,d of S should contain values that decrease as d increases.
    The third argument, <iterations>, is a number greater than or equal to 1, that specifies the number of iterations for the power method. 
    Slide 44 in the slides on PCA describes how to use the power method to find the top eigenvector, using a sequence bk. You should stop calculating this sequence after the specified number of iterations, and use the last bk (where k=<iterations>) as the eigenvector.

### Output

    After you compute matrices U, S, V, you need to print each of those matrices. You also need to print the reconstruction of the original matrix. This reconstruction is computed as U*S*VT. The output should follow this format:
    Matrix U:
      Row   1: %8.4f %8.4f ... %8.4f 
      Row   2: %8.4f %8.4f ... %8.4f 
      ...
      Row   X: %8.4f %8.4f ... %8.4f 

    Matrix S:
      Row   1: %8.4f %8.4f ... %8.4f 
      Row   2: %8.4f %8.4f ... %8.4f 
      ...
      Row   M: %8.4f %8.4f ... %8.4f 

    Matrix V:
      Row   1: %8.4f %8.4f ... %8.4f 
      Row   2: %8.4f %8.4f ... %8.4f 
      ...
      Row   Y: %8.4f %8.4f ... %8.4f 

    Reconstruction (U*S*V'):
      Row   1: %8.4f %8.4f ... %8.4f 
      Row   2: %8.4f %8.4f ... %8.4f 
      ...
      Row   X: %8.4f %8.4f ... %8.4f 
    In the above output template:
    X is the number of rows in the data file.
    Y is the number of columns in the data file.
    M is command-line argument <M>.
    In each line printing the row of a matrix, the row numbershould be printed using the %3d format specification (an integer with three allocated spaces). The actual values of the matrix should be printed with the %8.4f format specifier (or equivalent format if using a language different than Java).
    In your answers.pdf file, include the output for the following invocations of your program:

    svd_power input1.txt 2 10
    svd_power input1.txt 4 100

### Running The Program
    IN command window type : main('input1.txt', 2, 10)

    Here :
      M = 2
      iterations = 10

