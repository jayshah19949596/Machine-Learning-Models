function [] = dtw(train_data_col1, train_data_col2, train_class, train_lenght, test_data_col1, test_data_col2, test_class, test_lenght)
    classification_accuracy = 0;
    %===============================================
    %              For every test object
    %===============================================
    for i = 1:test_lenght
        x = test_data_col1(i, :);
        x = transpose(x);
        y = test_data_col2(i, :);
        y = transpose(y);
        test_cord = [x, y];
        test_cord(all(test_cord == 0, 2), :)=[];
        n = size(test_cord, 1);
        %===============================================
        %              For every train object
        %===============================================
        for j = 1:train_lenght
            x = train_data_col1(j, :);
            x = transpose(x);
            y = train_data_col2(j, :);
            y = transpose(y);
            train_cord = [x, y];
            train_cord(all(train_cord == 0, 2), :)=[];
            m = size(train_cord, 1);
            c = zeros(m, n);
            x1 = train_cord(1, 1);
            x2 = test_cord(1, 1);
            y1 = train_cord(1, 2);
            y2 = test_cord(1, 2);
            c(1, 1) = dist(x1, x2, y1, y2);
            %===============================================
            %       Filling the first column
            %===============================================
            for k = 2:m
                x1 = train_cord(k, 1);
                x2 = test_cord(1, 1);
                y1 = train_cord(k, 2);
                y2 = test_cord(1, 2);
                c(k, 1) = c(k-1, 1) + dist(x1, x2, y1, y2);
            end
      
            %===============================================
            %       Filling the first row
            %===============================================
            for l = 2:n
                x1 = train_cord(1, 1);
                x2 = test_cord(l, 1);
                y1 = train_cord(1, 2);
                y2 = test_cord(l, 2);
                c(1, l) = c(1, l-1) + dist(x1, x2, y1, y2);
            end
            
            %===============================================
            %       Filling the rest of the matrix
            %===============================================
            for p = 2:m
               for q = 2:n
                   x1 = train_cord(p, 1);
                   x2 = test_cord(q, 1);
                   y1 = train_cord(p, 2);
                   y2 = test_cord(q, 2);
                   c(p, q)= min([c(p-1, q) c(p, q-1) c(p-1, q-1)]) + dist(x1, x2, y1, y2);
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
        fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f, distance = %.2f \n', i, predicted, true, acc, distance);
        classification_accuracy = classification_accuracy + acc;
    end
    fprintf('classification accuracy=%6.4f\n', classification_accuracy/test_lenght);
end
