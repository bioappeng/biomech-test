classdef drop
    properties
        three_axis_load
        
        pos
        load
        accx
        accy
        accz
        loadx
        loady
        loadz
    end
    
    methods
        %constructor
        %takes: a filepath (relative or absolute)
        %       number of headerlines in the ascii file
        %       boolean for whether file has 3ax load cell data
        function obj = drop(filepath, num_headerlines, three_axis_load)
            if three_axis_load
                numfields = '%f%f%f%f%f%f%f%f';
            else
                numfields = '%f%f%f%f%f';
            end
            
            obj.three_axis_load = three_axis_load;
            
            file = fopen(filepath);
            data = textscan(file, numfields, 'HeaderLines', num_headerlines)
            fclose(file);
            
            obj.pos = data{1,1}(:,1);
            obj.load = data{1,2}(:,1);
            obj.accx = data{1,3}(:,1);    
            obj.accy = data{1,4}(:,1);
            obj.accz = data{1,5}(:,1);

            if obj.three_axis_load
                obj.loadx = data{1,6}(:,1);
                obj.loady = data{1,7}(:,1);
                obj.loadz = data{1,8}(:,1);
            end
        end
    end
end