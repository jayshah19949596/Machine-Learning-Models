function [] = main(filename, non_terminal, gamma, iterations)
    %=================================
    %           Loading Data
    %=================================
    file_instance = fopen(filename, 'rt');
    lines = fgetl(file_instance);
    i = 1;
    while ischar(lines)
        split_values = split(lines,',');
        %disp(split_values);
        data(i, :) = split_values;
        lines = fgetl(file_instance);
        i = i + 1;
    end
    data(data == '.') = 0.0;
    data(data == 'X') = 2.0;
    data = double(data);
    utility_matrix = data;
    %=================================
    %          Beginning Iterations
    %=================================
    for i = 1:iterations
        dummy = zeros(size(utility_matrix, 1), size(utility_matrix, 2));
        for row = 1:size(utility_matrix,1)
            for col = 1:size(utility_matrix, 2)
               if (utility_matrix(row, col) == 1)||(utility_matrix(row, col) == -1)||(utility_matrix(row, col) == 2)
                   dummy(row, col) = utility_matrix(row, col);
                   continue 
               end
               g = gamma;
               s = utility_matrix(row, col);
               %=================================
               %         Can Go Down ??
               %=================================
               if (row - 1) == 0 || utility_matrix((row -1), col) == 2
                   d = utility_matrix(row, col);
                   %down = 1;
               elseif (row - 1) > 0
                   d = utility_matrix((row -1), col);
               end
               %=================================
               %         Can Go Up ??
               %=================================
               if (row + 1) > size(utility_matrix,1) || utility_matrix((row + 1), col) == 2
                   u = utility_matrix(row, col);
                   %up = 1;
               elseif (row + 1) <= size(utility_matrix,1)
                   u = utility_matrix((row + 1), col);
               end
               %=================================
               %         Can Go Left ??
               %=================================
               if (col - 1) == 0 || utility_matrix(row, (col - 1)) == 2
                   l = utility_matrix(row, col);
                   %left = 1;
               elseif (col - 1) > 0
                   l = utility_matrix(row, (col - 1));    
               end
               %=================================
               %         Can Go Right ??
               %=================================
               if (col + 1) > size(utility_matrix, 2) || utility_matrix(row, (col + 1)) == 2
                   r = utility_matrix(row, col);
                   %right = 1;
               elseif (col + 1) <= size(utility_matrix, 2)
                   r = utility_matrix(row, (col + 1));   
               end
               % right, left, up, down
               ut = [r, l, u, d];
               ut = ut';
               
               %=================================
               %  Calculating Utility Sequence 
               %=================================
               % right, left, up, down
               uti = zeros(4, 1);
               for x = 1:4
                  uti(x, 1) = non_terminal + g*ut(x, 1);                   
               end
               
               %=================================
               %  Calculating Expected Utility 
               %=================================
               % right, left, up, down
               util = zeros(4, 1);
               util(1, 1) = 0.8*uti(1, 1)+0.1*uti(3, 1)+0.1*uti(4, 1);  
               util(2, 1) = 0.8*uti(2, 1)+0.1*uti(3, 1)+0.1*uti(4, 1);  
               util(3, 1) = 0.8*uti(3, 1)+0.1*uti(1, 1)+0.1*uti(2, 1);  
               util(4, 1) = 0.8*uti(4, 1)+0.1*uti(1, 1)+0.1*uti(2, 1);  

               %=========================================
               %      Selecting the Best Uitility 
               %=========================================
               max_value = max(util);
               dummy(row, col) = max_value;
               
            end  
        end
        utility_matrix = dummy(:, :);
    end
    %=========================================
    %           Displaying Results 
    %=========================================
    result = utility_matrix(:, :);
    result(result == 2) = 0;
    for row = 1:size(result, 1)
       for col = 1:size(result, 2)
          if col == size(result, 2)
              fprintf('%6.3f ', result(row, col));
          else
              fprintf('%6.3f, ', result(row, col));
          end
       end
       fprintf('\n');
    end 
end

    
    
    
    
    
