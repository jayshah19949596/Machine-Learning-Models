### Task
    In this assignment you will implement neural networks, using the backpropagation algorithm
    
### Command-line Arguments

    Your program takes five command-line arguments: <training_file>, <test_file>, <layers>, <units_per_layer>, <rounds>. 
    The program should be invoked as follows:
    neural_network <training_file> <test_file> <layers> <units_per_layer> <rounds>
    The arguments provide to the program the following information:
    The first argument, <training_file>, is the path name of the training file, where the training data is stored. 
    The path name can specify any file stored on the local computer.
    The second argument, <test_file>, is the path name of the test file, where the test data is stored. 
    The path name can specify any file stored on the local computer.
    The third argument, <layers>, specifies how many layers to use. 
    Note that the input layer is layer 1, so the number of layers cannot be smaller than 2.
    The fourth argument,<units_per_layer>, specifies how many perceptrons to place at each hidden layer. 
    This number excludes the bias input. So, each hidden layer should contain <units_per_layer> perceptrons and one bias input unit. 
    Note that this number is not applicable to units in the input layer, since those units are not perceptrons but simply provide the values of the input object and the bias input. 
    Also, note that the number of perceptrons in the output layer is equal to the number of classes, and thus this number is independent of the <units_per_layer> argument.
    The fifth argument, <rounds>, is the number of training rounds that you should use.
    The training and test files will follow the same format as the text files in the UCI datasets directory.
    
### Training

Training

    In your implementation, you should use these guidelines:
    Every perceptron should have a bias input, that is always set to 1. 
    The weight of that bias input is changed during backpropagation, and is treated exactly the same way as any other weight.
    For each dataset, for all training and test objects in that dataset, you should normalize all attribute values, by dividing them with the MAXIMUM value over all attributes over all training objects for that dataset. 
    This is a single MAXIMUM value, you should NOT use a different maximum value for each dimension. In other words, for each dataset, you need to find the single highest value across all dimensions and all training objects. 
    Every value in every dimension of every training and test object should be divided by that highest value.
    The weights of each unit in the network should be initialized to random values, chosen between -.05 and 0.05.
    You should initialize your learning rate to 1 for the first training round, and then multiply it by 0.98 for each subsequent training round. So, the learning_rate used for training round r should be 0.98r - 1.
    Your stopping criterion should simply be the number of training rounds, which is specified as the fifth command-line argument. 
    The number of training rounds specifies how many times you iterate over the entire training set. A single training round consists of a single execution of steps 4, 5, 6 in the backpropagation summary, on slide 71 of the neural networks slides. 
    In step 6 of that summary, set threshold equal to -1, so that the error is never used as the stopping criterion.
    The number of layers in the neural network is specified by the <layers> command-line argument. If we have L layers:

    Layer 1 is the input layer, that contains no perceptrons, it just specifies the inputs to the neural network. Thus, 2 is the minimum legal value for L.
    Each perceptron at layer 2 has D+1 inputs, where D is the number of attributes. The attributes of the input object provide the D non-bias inputs to each perceptron at this layer.
    Layer L is the output layer, containing as many perceptrons as the number of classes.
    If L > 2, then layers 2, ..., L-1 are the hidden layers. Each of these layers has as many perceptrons as specified in <units_per_layer>, the third command-line argument. 
    The bias input is a unit, but not a perceptron, so it is NOT counted in those <units_per_layer> perceptrons. If L = 2, then the fourth command-line argument (<units_per_layer>) is ignored.
    If L > 2, each perceptron at layers 3, ..., L has as inputs the outputs of ALL perceptrons at the previous layer, in addition to the bias input.
    
    Note that each dataset contains more than two classes, so your output layer needs to contain a number of units (perceptrons) equal to the number of classes, as discussed in the slides.
    
 ### Classification

    For each test object you should print a line containing the following info:
    Object ID. This is the line number where that object occurs in the test file. Start with 0 in numbering the objects, not with 1.
    Predicted class (the result of the classification). If your classification result is a tie among two or more classes, choose one of them randomly.
    True class (from the last column of the test file).
    Accuracy. This is defined as follows:
    If there were no ties in your classification result, and the predicted class is correct, the accuracy is 1.
    If there were no ties in your classification result, and the predicted class is incorrect, the accuracy is 0.
    If there were ties in your classification result, and the correct class was one of the classes that tied for best, the accuracy is 1 divided by the number of classes that tied for best.
    If there were ties in your classification result, and the correct class was NOT one of the classes that tied for best, the accuracy is 0.
    To produce this output in a uniform manner, use these printing statements:
    For C or C++, use:
    printf("ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2lf\n", 
           object_id, predicted_class, true_class, accuracy);
    For Java, use:
    System.out.printf("ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n", 
                      object_id, predicted_class, true_class, accuracy);
    For Python, Matlab, or any other language, just make sure that you use formatting specifies that produce aligned output that matches the specs given for C and Java.
    After you have printed the results for all test objects, you should print the overall classification accuracy, which is defined as the average of the classification accuracies you printed out for each test object. To print the classification accuracy in a uniform manner, use these printing statements:
    For C or C++, use:
    printf("classification accuracy=%6.4lf\n", classification_accuracy);
    
### Running The program
    1) type "neural_network('pendigits_training.txt', 'pendigits_test.txt', 2, 20, 50)"
   where the argument format is : "neural_network(training file, testing file, layers, units, rounds)"

    2) press enter.
