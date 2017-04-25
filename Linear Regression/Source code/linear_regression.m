function [] = linear_regression(filename, degree, lambda)
    %filename = 'sample_data1.txt';
    %degree = 1;
    %lambda = 0;
    object = Assignment4(filename, degree, lambda);
    object.load_data(object);
    object.calculate_phi(object);
    object.calculate_w(object);
    for i = 1: size(object.w, 1)
        fprintf(' W%d = %.4f\n', i-1, object.w(i, 1));
    end
    if degree == 1
        fprintf(' W2 = 0\n');
    end
end