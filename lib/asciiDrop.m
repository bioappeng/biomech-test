classdef asciiDrop < handle & drop
    properties
        id
        flagged

        time
        pot
        pot2
        load
        accx
        accy
        accz
        loadx
        loady
        loadz
    end
    
    methods (Static, Access = private)
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
        function obj = asciiDrop(filepath, headerlines,...
                            three_axis_load, sample_rate)
                        
            data = asciiDrop.parse_file(filepath, three_axis_load, headerlines);
            [pathstr, name, ext] = fileparts(filepath);
            obj.id = name;
            
            obj.pot = signal('string pot', data{1,1}(:,1));
            obj.load = signal('single axis load', data{1,2}(:,1));
            obj.accx = signal('x acceleration', data{1,3}(:,1));
            obj.accy = signal('y acceleration', data{1,4}(:,1));
            obj.accz = signal('z acceleration', data{1,5}(:,1));
            if three_axis_load
                obj.loadx = signal('x load', data{1,6}(:,1));
                obj.loady = signal('y load', data{1,7}(:,1));
                obj.loadz = signal('z load', data{1,8}(:,1));
            end
            length = size(obj.pot.data);
            length = length(1,:);
            obj.time = signal('time', (0: sample_rate: ((length-1)*sample_rate))');

            obj.flagged = false;
        end

        function flag(obj)
            obj.flagged = true;
        end

        function unflag(obj)
            obj.flagged = false;
        end
    end
end
