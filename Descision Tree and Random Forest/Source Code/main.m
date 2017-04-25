function [] = main(string, training_file, testing_file, option, pruning_thr)
    there = strfind(option,'forest');
    if size(there) > 0
        %disp('in if')
        option = 'forest3';
    end
    if isequal(option,'forest3')
        random(training_file, testing_file, 'randomized', pruning_thr);

    else   
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
        class_max = max(target);
        tree = [];
        thrsldeshold = [];
        gainin = [];
        index = 1;
        classification_acc = 0;
        
        attributes = zeros(1, size(train_data, 2)-1);
        
        for col = 1: size(train_data, 2)-1
            attributes(1, col) = col;
        end
        
        %attributes = [1, 2, 3, 4, 5 ,6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
    
        [tree,thrsldeshold,gainin] = make_tree(train_data,pruning_thrsld,option,attributes,class_max,tree,thrsldeshold,gainin,index);
        
        loop_end = size(tree,2);
        
        for i=1:loop_end
            if (tree(:,i)-1) ~= -1
                fprintf('tree=%2d, node=%3d, feature=%2d, thr=%6.2f, gain=%f\n',0,i,tree(:,i)-1,thrsldeshold(:,i),gainin(:,i)); 
            end
        end

        loop_end = size(test_data,1);
        for row=1:loop_end
            index=1;
            is_leaf=1;
            while is_leaf == 1
                attr=tree(index);
                thrsld=thrsldeshold(index);
                gain=gainin(index);
                if thrsld~=-1 && gain~=-1
                    if test_data(row,attr) < thrsld
                        index = (2*index);
                    else
                        index = (2*index)+1;
                    end
                else 
                    test_label = test_data(row,end);
                    if attr~=test_label
                        acc = 0;
                    else
                        acc = 1;
                    end
                    classification_acc=classification_acc+acc;
                    fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n', row, attr, test_label, acc);
                    is_leaf=0;
                
                end
            end
        end
        
        fprintf('classification accuracy=%6.4f\n',classification_acc/size(test_data,1));
        
    end
    
end

