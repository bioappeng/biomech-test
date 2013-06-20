% a class representing a single drop of the hoof tester
classdef drop < handle
    properties
        three_axis_load %boolean whether or not 3ax load cell
        
        time
        
        % data from hooftester sensors
        pos
        load
        accx
        accy
        accz
        loadx
        loady
        loadz
        
        % calculated maxima
        max_load
        max_accx
        max_accy
        max_accz
        max_loadx
        max_loady
        max_loadz
    end
    
    methods
        %constructor
        %takes: a filepath (relative or absolute)
        %       number of headerlines in the ascii file
        %       boolean for whether file has 3ax load cell data
        %       sample rate for the drop
        function obj = drop(filepath, num_headerlines,...
                            three_axis_load, sample_rate)
                        
            if three_axis_load
                numfields = '%f%f%f%f%f%f%f%f';
            else
                numfields = '%f%f%f%f%f';
            end
            
            obj.three_axis_load = three_axis_load;
            
            file = fopen(filepath);
            data = textscan(file, numfields, 'HeaderLines', num_headerlines);
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
            
            obj.time = (0: sample_rate: ((length-1)*sample_rate))';
        end
        
        %find drop maxima of sensor data
        function calc_maxima(obj)
            obj.max_load = max(abs(obj.load));
            obj.max_accx = max(abs(obj.accx));
            obj.max_accy = max(abs(obj.accy));
            obj.max_accz = max(abs(obj.accz));
            
            if obj.three_axis_load
                obj.max_loadx = max(abs(obj.loadx));
                obj.max_loady = max(abs(obj.loady));
                obj.max_loadz = max(abs(obj.loadz));
            end
        end
            
    end
end
