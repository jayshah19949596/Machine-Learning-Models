function [data] = normalise(data, std, mean)
    %disp(data);
    for i = 1: (size(data, 2))
        data(:, i) = data(:, i) - mean(1, i);

        data(:, i) = data(:, i) / std(1, i) ;
    end
    %disp(data);
end