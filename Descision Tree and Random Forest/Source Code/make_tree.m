function[tree,threshold,gain] = make_tree(data,pruning_threshold,option,attributes,class_max,tree,threshold,gain,index)
    target=(data(:,end));
    if size(data,1) <= pruning_threshold
        distribution=zeros(class_max,1);
        target = data(1:end,end); 
        
        for j=1:size(distribution,1)
            column = find(target==j);
            probclass=size(column,1)/size(target,1);
            distribution(j,1)=probclass;
        end
        
        [m,i]=max(distribution);
        
        tree(index)=i;
        
        threshold(index)=-1;
        
        gain(index)=-1;
        
    elseif size(unique(target),1)==1
        
        tree(index)=target(1, 1);
        threshold(index)=-1;
        gain(index)=-1;
        
    else
        [best_attri,best_thresh,best_gain]= choose_attribute(data, attributes,option);

        tree(index)=best_attri;
        
        threshold(index)=best_thresh;
        
        gain(index)=best_gain;
        
        ryt=1;
        
        left=1;
        
        for i=1:size(data,1)
           if data(i,best_attri) >= best_thresh
                rightdata(ryt,:)=data(i,1:end);            
                ryt = ryt + 1;
           else            
                leftdata(left,:) = data(i,1:end);
                left = left + 1;
            end 
        end
        
        if exist('leftdata')
           [tree,threshold,gain]= make_tree(leftdata,pruning_threshold,option,attributes,class_max,tree,threshold,gain,2*index);    

        else
            tree(2*index)=1;
            threshold(2*index)=-1;
            gain(2*index)=-1;
        end
        
        if exist('rightdata')
            [tree,threshold,gain] = make_tree(rightdata,pruning_threshold,option,attributes,class_max,tree,threshold,gain,(2*index)+1);
        else
            tree((2*index)+1)=1;
            threshold((2*index)+1)=-1;
            gain((2*index)+1)=-1;
        end
    end
end