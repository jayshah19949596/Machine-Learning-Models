function [class,ob_id,data_col1,data_col2,lenght] = read_file(file)
    d=fopen(file,'rt');
    tline = fgetl(d);
    cl=[];
    obj=[];
    k=0;
    class=0;
    flag=0;
    j=1;
    while ischar(tline)
        tline = fgetl(d);
        if ~isempty(strfind(tline,'object'))
            k=k+1;        
            index=k;
            p=split(tline,' ');
            obj(index)=p(3);
        end    
        if ~isempty(strfind(tline,'class'))
                pc=split(tline,' ');
                class=pc(3);
                cl(index)=class;
        end    
        if ~isempty(strfind(tline,'----------------'))
           flag=0;
        end
        if flag==1
            if tline ~= -1
                pd=strsplit(string(tline));
                col1(index,j)=double(pd(2));
                col2(index,j)=double(pd(3));
    
                j=j+1;
            end
        end
        if ~isempty(strfind(tline,'dominant hand trajectory:'))
           flag=1;
           j=1;
        end
    end
    fclose(d);
    class=cl;
    ob_id=obj;
    data_col1=col1;
    data_col2=col2;
    lenght=index;
end
