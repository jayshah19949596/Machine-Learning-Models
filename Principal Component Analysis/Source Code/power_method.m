function [U] = power_method(covariance, iterations, D)
    A = covariance;
    %disp(A)
    %B =  [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0 0.1 0.2 0.3 0.5 0.6]; %randi([0 1], 1,D);
    %B = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ,1, 1];
    B = rand(1, D);
    B = transpose(B);
    for iteration = 1:iterations 
        matrix = A*B;
        magnitude = norm(matrix);
        B = matrix/magnitude ;
        
    end
    U = B;
end