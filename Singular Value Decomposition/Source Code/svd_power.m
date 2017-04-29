function [U] = svd_power(A, iterations)
    D = size(A, 1);
    B = zeros(1, D);
    B = B + 1;
    B = transpose(B);
    for i = 1:iterations
        B = (A*B)/norm(A*B);
    end
    U = B;
end