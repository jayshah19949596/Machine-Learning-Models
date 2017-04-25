function [gain] = get_info_gain(data, attribute, threshold)
    target = data(:,end);
    distribution = histc(target,unique(target));
    distribution = distribution / size(target,1);
    class_gain = 0;
    
    for i = 1:size(distribution, 1)
        if distribution(i) > 0
            class_gain = class_gain + distribution(i) * log2(distribution(i));
        end
    end
    
    class_gain = (-1)*class_gain;
    
    info_gain_1 = zeros(size(unique(target)));
    info_gain_2 = zeros(size(unique(target)));

    find_1 = data(1:end, attribute) < threshold;
    find_2 = data(1:end, attribute) >= threshold;

    left_data = data(find_1, :);    
    right_data = data(find_2, :);
    
    left_class = histc(left_data(:, end), unique(target));
    right_class = histc(right_data(:, end), unique(target));

    if isrow(left_class)
        left_class = transpose(left_class);
    end

    if isrow(right_class)
        right_class = transpose(right_class);
    end

    left_probab = left_class / sum(left_class);
    left_probab(isnan(left_probab)) = 0;

    right_probab = right_class / sum(right_class);
    right_probab(isnan(right_probab)) = 0;

    for class = 1: size(unique(target))
        info_gain_1(class, 1) = left_probab(class, 1)*(log2(left_probab(class, 1)));
    end

    info_gain_1(isnan(info_gain_1)) = 0;
    info_gain_1 = (-1)*info_gain_1;
    ig_1 = sum(info_gain_1);

    for class = 1: size(unique(target))
         info_gain_2(class, 1) = right_probab(class, 1)*(log2(right_probab(class, 1)));
    end
                    
    info_gain_2(isnan(info_gain_2)) = 0;
    info_gain_2 = (-1)*info_gain_2;
    ig_2 = sum(info_gain_2);

    entropy = (sum(left_class)/size(data, 1))*ig_1 + (sum(right_class)/size(data, 1))*ig_2;

    gain = class_gain - entropy;
   
    
end
