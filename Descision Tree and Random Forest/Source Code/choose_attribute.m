function[best_attribute,best_threshold,max_gain]=choose_attribute(data,attributes,option)
    max_gain = -1;
    if isequal(option,'randomized')
        attribute = datasample(attributes,1,'Replace',true);
        L = min(data(:,attribute));
        M = max(data(:,attribute));
        for K=1:50
            threshold= L + K*(M - L)/51;        
            gain=get_info_gain(data, attribute, threshold);    
            if gain>max_gain           
                max_gain=gain;
                best_attribute=attribute;           
                best_threshold=threshold;           
            end
        end
        %disp(best_attribute)
        
    elseif isequal(option,'optimized')
        
        for attribute = 1:size(data, 2)-1
            L=min(data(:, attribute));
            M=max(data(:, attribute));
            for K = 1:50
                threshold = (L + K*(M-L))/(51);        
                [gain] = get_info_gain(data, attribute, threshold);    
                if gain > max_gain           
                    max_gain = gain;
                    best_attribute = attribute;           
                    best_threshold = threshold;   
                end
            end
        end
    
    end
    
end