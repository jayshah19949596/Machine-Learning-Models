function [] = logistic_regression(train_file, degree, test_file)

   %============================================
   %             Initialising Values 
   %============================================
    data = double(load(train_file));
    target = data(1: end, end);
    data = data(:,1:end-1);
    target(target > 1) = 0;
    prev_error=0;
    rows = size(data,1);
    cols = size(data,2);
    phi = zeros(rows,1);
    
   %============================================
   %      Calculating Training Phi Matrix 
   %============================================
    for row = 1: rows
        phi(row, 1) = 1;
        x = 2;
        for col = 1: cols
            for deg = 1:degree
                        phi(row, x) = data(row, col)^deg;
                        x = x+1;
            end
        end           
    end
    
   %============================================
   %      Training starts from this point
   %============================================
    condition = true;
    wght = zeros(cols*degree+1,1);    
    phi_trans = transpose(phi);
    m = 1; 
    
    while condition
        wghtT = transpose(wght);

        for i = 1:rows
            output(i,1) = wghtT * phi_trans(1:end,i);
            output(i,1) = 1 / (1 + exp(output(i,1)*(-1)));
        end
    
       %============================================
       %     Calculating Error Matrix 
       %============================================
        E = phi_trans * (output - target);
        
       %============================================
       %     Calculating New Error 
       %============================================
        new_error = sum(E,1);
        
                
       %============================================
       %     Calculating Error Difference 
       %============================================
        error_diff = abs(new_error - prev_error);
        
       %============================================
       %     Calculating R Diagonal Matrix 
       %============================================
        R = zeros(rows,rows);
        for i = 1:rows
            R(i,i) = output(i,1) * (1 - output(i,1));
        end

       %============================================
       %     Calculating New Weights  
       %============================================
        new_wght = wght - pinv(phi_trans * R * phi) * E ;
        
        condition = abs(sum(new_wght) - sum(wght)) >= 0.001 && error_diff>= 0.001;
        if condition
            wght = new_wght;
            prev_error = new_error;
        end
        m = m + 1;
    end
    
    %============================================
    %     Testing Initialisation
    %============================================
    test_data = double(load(test_file));
    target = test_data(1: end, end);
    test_data = test_data(:,1:end-1);
    rows = size(test_data,1);
    cols = size(test_data,2);
    phi = zeros(rows,1);
        
   %============================================
   %      Calculating Testing Phi Matrix 
   %============================================
    for row = 1: rows
        phi(row, 1) = 1;
        x = 2;
        for col = 1: cols
            for deg = 1:degree
                        phi(row, x) = test_data(row, col)^deg;
                        x = x+1;
            end
        end           
    end
    
   %============================================
   %      Calculating Testing Output Matrix 
   %============================================
    phi_trans = transpose(phi);
    for i = 1:rows
            output(i,1) = transpose(new_wght) * phi_trans(1:end,i);
            output(i,1) = 1 / (1 + exp(output(i,1)*(-1)));            
    end
    
    target(target > 1) = 0;
    predicted = zeros(size(output, 1), 1);
    accuracy = zeros(rows, 1);
    
   %============================================
   %            Printing the Weights
   %============================================
    for i = 1:size(new_wght, 1)
        fprintf(' W%d = %.4f\n', i-1, new_wght(i, 1));
    end
       
   %============================================
   %            Prediction
   %============================================
    for i = 1:rows
        first = transpose(new_wght) * transpose(phi(i, 1:end));
        second = output(i, 1) ;
        if (first > 0) && (second > 0.5)
            predicted(i, 1) = 1;
            if predicted(i, 1)  == target(i, 1)
                accuracy(i, 1) = 1;
            end
        elseif (first < 0) && (1 - second > 0.5)
            predicted(i, 1) = 0;
            output(i, 1) = (1 - second);
            if predicted(i, 1) == target(i, 1)
                accuracy(i, 1) = 1;
            end
        else
            predicted(i, 1) = 1;
            accuracy(i, 1) = 0.5;
        end
        fprintf(' objectID=%5d, predicted=%3d, probability = %.4f, true=%3d, accuracy=%4.2f \n', i-1, predicted(i, 1), output(i, 1), target(i, 1), accuracy(i, 1));
    end
        
    num = sum(accuracy);
    den = size(accuracy, 1);
    final_acc = num/den;
 
    fprintf('classification accuracy=%6.4f \n', final_acc) 
    
    
    
end
