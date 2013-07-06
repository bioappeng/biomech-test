% a class representing a single drop of the hoof tester
classdef drop < handle
    properties
        time
        pos
        load
        accx
        accy
        accz
        loadx
        loady
        loadz
    end
    
    methods (Static, Access = private)
        %helper function for constructor -- parse datafile
        function data = parse_file(filepath, three_axis_load, headerlines)
            if three_axis_load
                numfields = '%f%f%f%f%f%f%f%f';
            else
                numfields = '%f%f%f%f%f';
            end
            file = fopen(filepath);
            data = textscan(file, numfields, 'HeaderLines', headerlines);
            fclose(file);
        end
    end
    
    methods
        function obj = drop(filepath, headerlines,...
                            three_axis_load, sample_rate)
                        
            data = drop.parse_file(filepath, three_axis_load, headerlines);
            
            obj.pos = data{1,1}(:,1);
            obj.load = data{1,2}(:,1);
            obj.accx = data{1,3}(:,1);    
            obj.accy = data{1,4}(:,1);
            obj.accz = data{1,5}(:,1);
            if three_axis_load
                obj.loadx = data{1,6}(:,1);
                obj.loady = data{1,7}(:,1);
                obj.loadz = data{1,8}(:,1);
            end
            length = size(obj.pos);
            length = length(1,:);
            obj.time = (0: sample_rate: ((length-1)*sample_rate))';
        end
    end
end
