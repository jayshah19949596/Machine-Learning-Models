function [] = random(training_file, testing_file, option, pruning_thr)
    %train_file = 'pendigits_training.txt';
    %test_file = 'pendigits_test.txt';
    train_file = training_file;
    test_file = testing_file;
    train_data = load(train_file);
    test_data = load(test_file);
    target = train_data(:, end);
    test_target = test_data(:, end);
    unique_class = unique(target);
    pruning_thrsld = pruning_thr;
    classificatio_acc=0;
    class_max = max(target);
    
    tree1 = [];
    thrsldeshold1 = [];
    gainin1 = [];
    index1 = 1;

    
    tree2 = [];
    thrsldeshold2 = [];
    gainin2 = [];
    index2 = 1;
    
    
    tree3 = [];
    thrsldeshold3 = [];
    gainin3 = [];
    index3 = 1;

    attributes = zeros(1, size(train_data, 2)-1);
    for col = 1: size(train_data, 2)-1
        attributes(1, col) = col;
    end
    
    % = [1, 2, 3, 4, 5 ,6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];

    
    
    [tree1,thrsldeshold1,gainin1] = make_tree(train_data,pruning_thrsld,option,attributes,class_max,tree1,thrsldeshold1,gainin1,index1);
    [tree2,thrsldeshold2,gainin2] = make_tree(train_data,pruning_thrsld,option,attributes,class_max,tree2,thrsldeshold2,gainin2,index2);
    [tree3,thrsldeshold3,gainin3] = make_tree(train_data,pruning_thrsld,option,attributes,class_max,tree3,thrsldeshold3,gainin3,index3);

    for i=1:size(tree1,2)
        if (tree1(:,i)-1) ~= -1
            fprintf('tree=%2d, node=%3d, feature=%2d, thr=%6.2f, gain=%f\n',0,i,tree1(:,i)-1,thrsldeshold1(:,i),gainin1(:,i)); 
        end
    end
    
    for i=1:size(tree2, 2)
        if (tree2(:,i)-1) ~= -1
            fprintf('tree=%2d, node=%3d, feature=%2d, thr=%6.2f, gain=%f\n',1,i,tree2(:,i)-1,thrsldeshold2(:,i),gainin2(:,i)); 
        end
    end
    
    for i=1:size(tree3, 2)
        if (tree3(:,i)-1) ~= -1
            fprintf('tree=%2d, node=%3d, feature=%2d, thr=%6.2f, gain=%f\n',2,i,tree3(:,i)-1,thrsldeshold3(:,i),gainin3(:,i)); 
        end
    end
    
    
    for test_row=1:size(test_data,1)
        index=1;
        is_leaf=1;
        while is_leaf == 1
            atest_classr = tree1(index);
            thrsld = thrsldeshold1(index);
            gain = gainin1(index);
            if thrsld == -1 && gain == -1
                tree_1_values = atest_classr;
                is_leaf=0;
            else
                if (test_data(test_row,atest_classr))>=thrsld
                    index=(2*index)+1;
                else
                    index=(2*index);
                end
            end
        end
        index=1;
        is_leaf=1;
        while is_leaf == 1
            atest_classr = tree2(index);
            thrsld=thrsldeshold2(index);
            gain=gainin2(index);
            if thrsld ~= -1 && gain ~= -1
                if (test_data(test_row,atest_classr))<thrsld
                    index=(2*index);
                else
                    index=(2*index)+1;
                end
            else 
                tree_2_values = atest_classr;
                is_leaf=0;
            end
        end
        index=1;
        is_leaf=1;
        while is_leaf == 1
            atest_classr=tree3(index);
            thrsld=thrsldeshold3(index);
            gain=gainin3(index);
            if thrsld==-1 && gain==-1
                tree_3_values=atest_classr;
                is_leaf=0;
            else
                if (test_data(test_row,atest_classr))<thrsld
                    index=(2*index);
                else
                    index=(2*index)+1;
                end
            end
        end
        test_class = test_data(test_row,end);
        tree_1_values=int16(tree_1_values);
        tree_2_values=int16(tree_2_values);
        tree_3_values=int16(tree_3_values);
        data_1_mat=zeros(1, class_max+1);
        data_1_mat(tree_1_values+1) = 1;
        data_2_mat=zeros(1, class_max+1);
        data_2_mat(tree_2_values+1) = 1;
        data_3_mat=zeros(1, class_max+1);
        data_3_mat(tree_3_values+1) = 1;
        probability_distribution = data_1_mat+data_2_mat+data_3_mat;
        probability_distribution = probability_distribution/3;
        [nothing, id] = max(probability_distribution);
        if (id-1)==test_class
            acc=1;
        else
            acc=0;
        end
        classificatio_acc=classificatio_acc+acc;
        fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n',test_row, id-1, test_class, acc);
    
        
    end
    fprintf('classification accuracy=%6.4f\n',classificatio_acc/size(test_data,1));
