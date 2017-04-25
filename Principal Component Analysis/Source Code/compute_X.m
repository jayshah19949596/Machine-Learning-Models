function [data] = compute_X(data, U)

    for i  = 1:size(data, 1)
        %disp(size(U));
        %disp(size(data(i, 1:end)));
        term = transpose(U)* transpose(data(i, 1:end))* U;
        %disp(size(term))
        data(i, 1:end) = data(i, 1:end) - transpose(term);
    end
    
end