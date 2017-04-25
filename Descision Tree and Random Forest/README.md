
The assignment should be submitted via Blackboard. Submit a file called assignment7.zip, containing your answers.pdf document and your code.
Your written answers should be in a document called answers.pdf. All text should be typed, and all figures should be computer-generated. Scans of handwriten answers will NOT be accepted. Your name and UTA ID number should appear on the top line of the answers.pdf document.

For each task requiring code to be submitted, your zip file should contain a folder containing:

The code for that task.
A text file called README.txt that fully describes the commands needed to compile (if needed) and to run your code on omega. Follow this example README.txt file as closely as you can. Notice how the example README.txt file specifies explicitly how to compile the code and how to run the code.
If your solution for a task runs in Matlab, then your solution should be a function, NOT A SCRIPT. The function should take as arguments the exact same arguments (and in the exact same order) that the task describes as command-line arguments (excluding the name of the executable file). The name of the Matlab function should be the same as the name of the executable for C and Java implementations.
All code should run on omega, unless you have written approval (via e-mail) from the instructor, or you use Matlab. Matlab code does not need to run on omega, it just needs to run on Matlab versions 2016a and later.

Make sure that you use at least 64-bit floating point numbers in your calculations. These correspond to the double type in C and Java.

Task 1 (100 points)

In this task you will implement decision trees and decision forests. Your program will learn decision trees from training data and will apply decision trees and decision forests to classify test objects.
Your zip file should have a folder called decision_trees, which contains your code and the README.txt file.

Command-line Arguments

Your program will be invoked as follows:
dtree <training_file> <test_file> <option> <pruning_thr>
The arguments provide to the program the following information:
The first argument, <training_file>, is the path name of the training file, where the training data is stored. The path name can specify any file stored on the local computer.
The second argument, <test_file>, is the path name of the test file, where the test data is stored. The path name can specify any file stored on the local computer.
The third argument, <option>, can have four possible values: optimized, randomized, forest3, or forest15. It specifies how to train (learn) the decision tree, and will be discussed later.
The fourth argument,<pruning_thr>, is a number greater than or equal to 0, that specifies the pruning threshold.
The training and test files will follow the same format as the text files in the UCI datasets directory. A description of the datasets and the file format can be found on this link. For each dataset, a training file and a test file are provided. The name of each file indicates what dataset the file belongs to, and whether the file contains training or test data. Your code should also work with ANY OTHER training and test files using the same format as the files in the UCI datasets directory.
As the description states, do NOT use data from the last column (i.e., the class labels) as features. In these files, all columns except for the last one contain example inputs. The last column contains the class label.

Training Stage

The first thing that your program should do is train a decision tree or a decision forest using the training data. What you train and how you do the training depends on the came of the third command line argument, that we called <option>. This option can take four possible values, as follows:
optimized: in this case, at each non-leaf node of the tree (starting at the root) you should identify the optimal combination of attribute (feature) and threshold, i.e., the combination that leads to the highest information gain for that node.
randomized: in this case, at each non-leaf node of the tree (starting at the root) you should choose the attribute (feature) randomly. The threshold should still be optimized, i.e., it should be chosen so as to maximize the information gain for that node and for that randomly chosen attribute.
forest3: in this case, your program trains a random forest containing three trees. Each of those trees should be trained as discussed under the "randomized" option.
forest15: in this case, your program trains a random forest containing 15 trees. Each of those trees should be trained as discussed under the "randomized" option.
Training Phase Output

After you learn your tree or forest, you should print it. Every node must be printed, in breath-first order, with left children before right children. For each node you should print a line containing the following info:
tree ID. If you are learning a single tree, the ID is 0. If you are learning multiple trees, their ID range from 0 to the number of trees - 1, and should be printed in increasing order of their ID.
node ID. The root has ID 1. If a node has ID = N, then its left child has ID 2*N and its right child has ID 2*N + 1.
a feature ID, specifying which attribute is used for the test at that node. This is a number starting from 0, indicating the position of the column that contains values for that attribute. If the node is a leaf node, print -1 for the feature ID.
a threshold that, combined with the feature ID specifies the test for that node. If feature ID = X and threshold = T, then objects whose X-th feature has a value LESS THAN T are directed to the left child of that node. If the node is a leaf node, print -1 for the threshold.
information gain achieved by the test chosen for this node.
To produce this output in a uniform manner, use these printing statements:
For C or C++, use:
printf("tree=%2d, node=%3d, feature=%2d, thr=%6.2lf, gain=%lf\n", tree_id, node_id, feature_id, threshold, gain);
For Java, use:
System.out.printf("tree=%2d, node=%3d, feature=%2d, thr=%6.2f, gain=%f\n", tree_id, node_id, feature_id, threshold, gain);
For Python or any other language, just make sure that you use formatting specifies that produce aligned output that matches the specs given for C and Java.
Classification Stage

For each test object you should print a line containing the following info:
object ID. This is the line number where that object occurs in the test file. Start with 0 in numbering the objects, not with 1.
predicted class (the result of the classification). If your classification result is a tie among two or more classes, choose one of them randomly.
true class (from the last column of the test file).
accuracy. This is defined as follows:
If there were no ties in your classification result, and the predicted class is correct, the accuracy is 1.
If there were no ties in your classification result, and the predicted class is incorrect, the accuracy is 0.
If there were ties in your classification result, and the correct class was one of the classes that tied for best, the accuracy is 1 divided by the number of classes that tied for best.
If there were ties in your classification result, and the correct class was NOT one of the classes that tied for best, the accuracy is 0.
To produce this output in a uniform manner, use these printing statements:
For C or C++, use:
printf("ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2lf\n", object_id, predicted_class, true_class, accuracy);
For Java, use:
System.out.printf("ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n", object_id, predicted_class, true_class, accuracy);

For Python or any other language, just make sure that you use formatting specifies that produce aligned output that matches the specs given for C and Java.
After you have printed the results for all test objects, you should print the overall classification accuracy, which is defined as the average of the classification accuracies you printed out for each test object. To print the classification accuracy in a uniform manner, use these printing statements:
For C or C++, use:
printf("classification accuracy=%6.4lf\n", classification_accuracy);
For Java, use:
System.out.printf("classification accuracy=%6.4f\n", classification_accuracy);

For Python or any other language, just make sure that you use formatting specifies that produce aligned output that matches the specs given for C and Java.
Output for answers.pdf

In your answers.pdf document, you need to provide parts of the output for some invocations of your program listed below. For each invocation, provide:
The full output of the training stage.
ONLY THE LAST LINE (the line printing the classification accuracy) of the output by the test stage.
Include this output for the following invocations of your program:
dtree pendigits_training pendigits_test optimized 50
dtree pendigits_training pendigits_test randomized 50
dtree pendigits_training pendigits_test forest3 50
Grading

20 points: Correct processing of the optimized option. Identifying and choosing, for each node, the (feature, threshold) pair with the highest information gain for that node, and correctly computing that information gain.
10 points: Correct processing of the randomized option. In other words, identifying and choosing, for each node, an appropriate (feature, threshold) pair, where the feature is chosen randomly, and the threshold maximizes the information gain for that feature,
10 points: Correctly directing training objects to the left or right child of each node, depending on the (threshold, value) pair used at that node.
10 points: Correct application of pruning, as specified in the slides.
15 points: Correctly applying decision trees to classify test objects.
15 points: Correctly applying decision forests to classify test objects.
20 points: Following the specifications in producing the required output.
