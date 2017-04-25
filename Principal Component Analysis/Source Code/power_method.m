function [U] = power_method(covariance, iterations, D)
    A = covariance;
    B = rand(1, D);
    B = transpose(B);
    for iteration = 1:iterations 
        matrix = A*B;
        magnitude = norm(matrix);
        B = matrix/magnitude ;
        
    end
    U = B;
end
