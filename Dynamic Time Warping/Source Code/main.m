function [] = main(train_file, test_file)
    [train_class, train_ob_id, train_data_col1, train_data_col2, train_lenght] = read_file(train_file);
    [test_class, test_ob_id, test_data_col1, test_data_col2, test_lenght] = read_file(test_file);
    classification_accuracy = 0;
    for i = 1:test_lenght
        x = test_data_col1(i, :);
        x = transpose(x);
        y = test_data_col2(i, :);
        y = transpose(y);
        test_cord = [x, y];
        test_cord(all(test_cord == 0, 2), :)=[];
        n = size(test_cord, 1);
        for j = 1:train_lenght
            x = train_data_col1(j, :);
            x = transpose(x);
            y = train_data_col2(j, :);
            y = transpose(y);
            train_cord = [x, y];
            train_cord(all(train_cord == 0, 2), :)=[];
            m = size(train_cord, 1);
            c = zeros(m, n);
            c(1, 1) = dist(train_cord(1, 1), test_cord(1, 1), train_cord(1, 2), test_cord(1, 2));
            for k = 2:m
                c(k, 1) = c(k-1, 1) + dist(train_cord(k, 1), test_cord(1, 1), train_cord(k, 2), test_cord(1, 2));
            end

            for l = 2:n
                c(1, l) = c(1, l-1) + dist(train_cord(1, 1), test_cord(l, 1), train_cord(1, 2), test_cord(l, 2));
            end
            for p = 2:m
               for q = 2:n
                   c(p, q)= min([c(p-1, q) c(p, q-1) c(p-1, q-1)]) + dist(train_cord(p, 1), test_cord(q, 1), train_cord(p, 2), test_cord(q, 2));
               end
            end
            cost(j, 1) = c(m, n);
            cost(j, 2) = train_class(j);
        end
        value = sortrows(cost, 1);
        distance = value(1, 1);
        predicted = value(1, 2);
        true = test_class(i);
        acc = 0;
        if true == predicted
            acc = 1;
        end
        fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f, distance = %.2f classification =%.4f  \n', i, predicted, true, acc, distance, classification_accuracy/test_lenght);
        classification_accuracy = classification_accuracy + acc;
    end
    fprintf('classification accuracy=%6.4f\n', classification_accuracy/test_lenght);
end
