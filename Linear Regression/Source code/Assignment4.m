classdef Assignment4 < handle
    properties
    filename;
    degree;
    lambda;
    data;
    phi;
    w;
    end    
    methods (Static)
        function [obj] = Assignment4(filename, degree, lambda)
            obj.filename = filename;
            obj. degree = degree;
            obj.lambda = lambda;
        end
        
        function [obj] = load_data(obj) 
            obj.data = load(obj.filename);
        end 
        
        function [obj] = calculate_phi(obj)
            number_of_rows = size(obj.data, 1);
            obj.phi = zeros(number_of_rows, (obj.degree)+1);   
            for row = 1: number_of_rows
                obj.phi(row, 1) = 1;
                for deg = 1: obj.degree
                    obj.phi(row, deg+1) = obj.data(row, 1)^deg;
                end
            end
        end
        
        function [obj] = calculate_w(obj)
            if obj.lambda == 0
                obj.w = (inv(transpose(obj.phi)* (obj.phi))) * (transpose(obj.phi)) * (obj.data(:,2));
            else 
                obj.w = (inv((obj.lambda * eye(obj.degree+1)) + transpose(obj.phi)* (obj.phi))) * (transpose(obj.phi)) * (obj.data(:,2)); 
            end         
        end      
    end
end