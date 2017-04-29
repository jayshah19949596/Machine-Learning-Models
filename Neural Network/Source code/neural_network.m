classdef neural_network < handle
    properties
    train_file;
    test_file;
    rounds;
    train_data;
    test_data;
    target;
    test_target;
    first_wghts;
    op_wghts;
    op_acivation;
    phi;
    test_phi;
    attr_no;
    no_of_samples;
    no_of_units;
    unique_class;
    op_units;
    no_of_layers;
    act;
    net;
    hidden_wghts;
    net_1;
    act_1;
    op_act;
    delta;
    step;
    del;
    delta_op;
    tot_acc;
    act_res;
    acc_res;
    pred_res;
    end    
    methods (Static)
        function [obj] = neural_network(training_file, test_file, layers, units_per_layer, rounds)
            obj.train_file = training_file;
            obj.test_file = test_file;
            obj.rounds = rounds;
            obj.train_data = load(obj.train_file);
            obj.test_data = load(obj.test_file);
            obj.attr_no = size(obj.train_data, 2);
            obj.no_of_samples = size(obj.train_data, 1);
            obj.no_of_units = units_per_layer;
            obj.target = obj.train_data(1: end, end);
            obj.test_target = obj.test_data(1: end, end);
            obj.unique_class = unique(obj.target);
            obj.unique_class = sort(obj.unique_class);
            obj.op_units = size(obj.unique_class, 1);
            obj.no_of_layers = layers;
            obj.step = 0.98;
            obj.tot_acc = 0;
            obj.del = zeros(obj.no_of_units, obj.no_of_layers-2);
        end    
        
        function [obj] = initialise(obj)
            ones = zeros(obj.no_of_samples, 1);
            ones(ones == 0) = 1;
            
            obj.phi = obj.train_data(1: end, 1: end-1);
            maximum = max(obj.phi(:));
            obj.phi = (obj.phi)/(maximum);
            obj.phi = [obj.phi ones];
            
            ones = zeros(size(obj.test_data, 1), 1);
            ones(ones == 0) = 1;
            obj.test_phi = obj.test_data(1: end, 1: end-1);
            maximum = max(obj.test_phi(:));
            obj.test_phi = (obj.test_phi)/(maximum);
            obj.test_phi = [obj.test_phi ones];
            
            obj.act_res = zeros(size(obj.test_data, 1), 1);
            obj.acc_res = zeros(size(obj.test_data, 1), 1);
            obj.pred_res = zeros(size(obj.test_data, 1), 1);
            
            obj.first_wghts = -0.05 + (0.05- (-0.05)).*rand(size(obj.phi, 2), obj.no_of_units);

            
            obj.act = zeros(obj.no_of_units+1, obj.no_of_layers-2);
            obj.net = zeros(obj.no_of_units, obj.no_of_layers-2);
            
            if obj.no_of_layers > 2
                obj.op_wghts = -0.05 + (0.05- (-0.05)).*rand(obj.no_of_units+1, obj.op_units);

            else
                obj.op_wghts = -0.05 + (0.05- (-0.05)).*rand(size(obj.phi, 2), obj.op_units);

            end
            
            obj.hidden_wghts = -0.05 + (0.05- (-0.05)).*rand(obj.no_of_units+1, obj.no_of_units, obj.no_of_layers-3);
            obj.delta_op = zeros(obj.op_units, 1);
        end
        
        function [obj] = feed_forward(obj, round)
            for row = 1:size(obj.phi, 1)
                for layer = 1:obj.no_of_layers-1

                    if layer == obj.no_of_layers-1 && obj.no_of_layers > 2

                        obj.net_1 =  transpose(obj.op_wghts(1:end, 1:end)) * (obj.act(1:end, layer-1));
                        obj.op_act = logsig(obj.net_1);


                    elseif layer == obj.no_of_layers-1 && obj.no_of_layers == 2

                        obj.net_1  = transpose(obj.op_wghts(1:end, 1:end)) * transpose(obj.phi(row, 1:end)); 
                        obj.op_act = logsig(obj.net_1);

                    elseif layer == 1 

                        obj.net(1:end, layer) = transpose(obj.first_wghts) * transpose(obj.phi(row, 1:end)); 
                        obj.act(1:end-1, layer) = logsig(obj.net(1:end, layer));
                        obj.act(end, layer) = 1;

                    elseif layer > 1 && layer < obj.no_of_layers-1

                        obj.net(1:end, layer) = transpose(obj.hidden_wghts(1:end, 1:end, layer-1)) * (obj.act(1:end, layer-1)); 
                        obj.act(1:end-1, layer) = logsig(obj.net(1:end, layer));
                        obj.act(end, layer) = 1;

                        
                    end 
                end
                obj = obj.back_prop(obj, round, row);
            end
        end
        
        function [obj] = back_prop(obj, round, row)
            tg = obj.target(row, 1);   
          
            pos = find(obj.unique_class == tg);
            
            rate = power(obj.step,round);
            
            for layer = obj.no_of_layers-1: -1: 1
                if layer == obj.no_of_layers-1 && obj.no_of_layers > 2
                    for unit = 1:obj.op_units
                        if unit == pos
                             t = 1;
                        else
                             t = 0;
                        end
                        o = obj.op_act(unit, 1);
                        delta = (o-t)*o*(1-o);
                        obj.delta_op(unit, 1) = delta;
                        for wght = 1:obj.no_of_units+1
                            obj.op_wghts(wght, unit) = obj.op_wghts(wght, unit) - (rate*delta*obj.act(wght, end));
                            
                        end
                    end
                
                elseif layer == obj.no_of_layers-1 && obj.no_of_layers == 2
                    for unit = 1:obj.op_units
                        if unit == pos
                             t = 1;
                        else
                             t = 0;
                        end
                        o = obj.op_act(unit, 1);
                        delta = (o-t)*o*(1-o);
                        obj.delta_op(unit, 1) = delta;
                        for wght = 1:size(obj.phi, 2)
                            obj.op_wghts(wght, unit) = obj.op_wghts(wght, unit) - (rate*delta*obj.phi(row, wght));
                            %fprintf('unit=%d,wght=%d, delta=%6.4f, obj.act(wght, end)=%6.4f \n', unit, wght, delta, obj.act(wght, end))
                        end
                    end
                    
                    
                elseif layer == obj.no_of_layers-2 && layer > 1 && obj.no_of_layers >3
                    
                    for unit = 1:obj.no_of_units
                        obj.del(unit, layer) = transpose(obj.delta_op)*transpose(obj.op_wghts(unit, 1:end));
                        o = obj.act(unit, end);
                        obj.del(unit, layer) = obj.del(unit, layer)*o*(1-o);
                        obj.delta = obj.del(unit, layer);
                        
                        for wght = 1:obj.no_of_units+1
                            obj.hidden_wghts(wght, unit, end) = obj.hidden_wghts(wght, unit, end)-rate*obj.delta*obj.act(wght, end-1);
                        end
                    end 
                    
                elseif layer < obj.no_of_layers-2 && layer > 1 && obj.no_of_layers >3
                    
                    for unit = 1:obj.no_of_units
                        
                        obj.del(unit, layer) = transpose(obj.del(1:end, layer+1))*transpose(obj.hidden_wghts(unit, 1:end, layer));
                        o = obj.act(unit, layer);
                        obj.del(unit, layer) = obj.del(unit, layer)*o*(1-o);
                        obj.delta = obj.del(unit, layer);
                        
                        for wght = 1:obj.no_of_units+1
                            obj.hidden_wghts(wght, unit, layer-1) = obj.hidden_wghts(wght, unit, layer-1)-rate*obj.delta*obj.act(wght, layer-1);
                        end
                    end   
                    %disp(obj.hidden_wghts(:, :, layer-1))
                    
                elseif layer == 1 && obj.no_of_layers == 3
                    
                    for unit = 1:obj.no_of_units
                        obj.del(unit, layer) = transpose(obj.delta_op)*transpose(obj.op_wghts(unit, 1:end));
                        o = obj.act(unit, 1);
                        obj.del(unit, layer) = obj.del(unit, layer)*o*(1-o);
                        obj.delta = obj.del(unit, layer);
                        for wght = 1:size(obj.phi, 2)
                            obj.first_wghts(wght, unit) = obj.first_wghts(wght, unit)-(rate*obj.delta*obj.phi(row, wght));
       
                        end
                    end    
                    
                    
                elseif layer == 1 && obj.no_of_layers > 3 
                    
                    for unit = 1:obj.no_of_units
                        
                        obj.del(unit, layer) = transpose(obj.del(1:end, layer+1))*transpose(obj.hidden_wghts(unit, 1:end, 1));
                        o = obj.act(unit, 1);
                        obj.del(unit, layer) = obj.del(unit, layer)*o*(1-o);
                        obj.delta = obj.del(unit, layer);
                        for wght = 1:size(obj.phi, 2)
                            obj.first_wghts(wght, unit) = obj.first_wghts(wght, unit)-rate*obj.delta*obj.phi(row, wght);
                        end
                    end    
                     
                    
                end
                
            end          
        end
        function [obj] = testing(obj)
            for row = 1:size(obj.test_phi, 1)
                for layer = 1:obj.no_of_layers-1

                    if layer == obj.no_of_layers-1 && obj.no_of_layers > 2

                        obj.net_1 =  transpose(obj.op_wghts(1:end, 1:end)) * (obj.act(1:end, layer-1));
                        obj.op_act = logsig(obj.net_1);


                    elseif layer == obj.no_of_layers-1 && obj.no_of_layers == 2

                        obj.net_1  = transpose(obj.op_wghts(1:end, 1:end)) * transpose(obj.test_phi(row, 1:end)); 
                        obj.op_act = logsig(obj.net_1);

                    elseif layer == 1

                        obj.net(1:end, layer) = transpose(obj.first_wghts) * transpose(obj.test_phi(row, 1:end)); 
                        obj.act(1:end-1, layer) = logsig(obj.net(1:end, layer));
                        obj.act(end, layer) = 1;

                    elseif layer > 1 && layer < obj.no_of_layers-1

                        obj.net(1:end, layer) = transpose(obj.hidden_wghts(1:end, 1:end, layer-1)) * (obj.act(1:end, layer-1)); 
                        obj.act(1:end-1, layer) = logsig(obj.net(1:end, layer));
                        obj.act(end, layer) = 1;
    
                    end 
                end
                max_act = max(obj.op_act(:));
                pos = find(obj.op_act ==  max_act); 
                predicted = obj.unique_class(pos);
                test_t = obj.test_target(row, 1);
                
                acc= 0;
                if predicted == test_t
                    acc = 1;
                end
                
                obj.act_res(row, 1) = max_act;
                obj.acc_res(row, 1) = acc;
                obj.pred_res(row, 1) = predicted;
                
                obj.tot_acc = obj.tot_acc+acc;
                fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f \n', row-1, predicted, test_t, acc);
               
                
                
            end
            fprintf('classification accuracy=%6.4f  ', (sum(obj.acc_res)/size(obj.test_phi, 1)));
        end
        
    end
end
