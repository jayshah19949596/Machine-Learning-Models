function [column_1, column_2, labels, lenght] = load_data(file)
    is_last_line = 0;
    start=1;
    labels = [];
    k = 0;
    file_instance=fopen(file,'rt');
    line = fopen(file_instance);
    while ischar(line)
        line = fgetl(file_instance);
        if ~isempty(strfind(line,'object'))
            k = k+1;        
            index = k;
        end    
        if ~isempty(strfind(line,'class'))
                split_values = split(line,' ');
                class = split_values(3);
                labels(index) = class;
        end    
        if ~isempty(strfind(line,'----------------'))
           is_last_line=0;
        end
        if is_last_line == 1
            if line ~= -1
                start = start+1;
                split_values = strsplit(string(line));
                column_1(index,start) = double(split_values(1, 2));
                column_2(index,start) = double(split_values(1, 3));
            end
        end
        if ~isempty(strfind(line,'dominant hand trajectory:'))
           is_last_line = 1;
           start = 1;
        end
    end
    fclose(file_instance);
    lenght = index;
end