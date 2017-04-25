function [] = knn(train_data, test_data, train_target, test_target, k)
    classification_accuracy = 0;
    for i = 1:size(test_data, 1)
        %============================================
        %         Calculating Euclidean Distance
        %============================================
        D = test_data(i, :) - train_data(: , :);
        D = D.^2;
        dist_mat = sum(D, 2);
        dist_mat = sqrt(dist_mat);
        dist = [dist_mat train_target];
        %============================================
        %  Sorting Row according to minimum distance
        %============================================
        dist = sortrows(dist, 1);
        %============================================
        %       If K value is 1 Print Results
        %============================================
        if k == 1
            k_neighbours = dist(k, :);
            predicted = k_neighbours(1, 2);
            true = test_target(i, 1);
            if true == predicted
                accuracy = 1;
                classification_accuracy = classification_accuracy + accuracy;
            else
                accuracy = 0;
            end
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f \n', i, predicted, true, accuracy)
        %===============================================
        % Else K value is greater then 1 Print Results
        %===============================================
        else
            k_neighbours = dist(1:k, :);            
            if size(unique(k_neighbours(:, 2))) == 1
                predicted = unique(k_neighbours(:, 2));
            elseif size(unique(k_neighbours(:, 2))) == k
                predicted = k_neighbours(1, 2);
            else
                predicted = mode(k_neighbours(:, 2))
            end
            true = test_target(i, 1);
            if true == predicted
                accuracy = 1;
                classification_accuracy = classification_accuracy + accuracy;
            else
                accuracy = 0;
            end
            fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f \n', i, predicted, true, accuracy)
        end
    end
    fprintf('classification_accuracy=%6.4f \n', classification_accuracy/size(test_target, 1))
end
