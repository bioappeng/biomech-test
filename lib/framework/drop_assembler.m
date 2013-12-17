%assembles drops from their respective data formats
%using settings provided in settings_holder object
classdef drop_assembler < handle
    properties
        settings;
        data;
    end

    methods
        function obj = drop_assembler(settings)
            obj.settings = settings.settings;
        end

        function drops = assemble(obj, path)
            drops = obj.build_drops(path);
        end

        function drops = build_drops(obj, path)
            fext = obj.settings.text_file_extension;
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                [id, obj.data] = obj.parse_file(filepath, obj.settings.headerlines);
                signals = obj.build_signals();
                drops(i).Value = drop(signals, id, obj.settings.sample_rate);
            end
        end

        function [id, data] = parse_file(obj, filepath, headerlines)
            [pathstr, id, ext] = fileparts(filepath);
            file = fopen(filepath);
            numfields = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
            data = textscan(file, numfields, 'HeaderLines', headerlines);
            fclose(file);
        end

        function signals = build_signals(obj)
            import containers.Map;

            signals = Map();
            signals('pot') = signal('string pot', obj.get_data(obj.settings.string_pot));
            signals('pot2') = signal('head pot', obj.get_data(obj.settings.head_pot));
            signals('load') = signal('single axis load', obj.get_data(obj.settings.single_axis_load));
            signals('loady') = signal('y load', obj.get_data(obj.settings.loady));
            signals('loadx') = signal('x load', obj.get_data(obj.settings.loadx));
            signals('loadz') = signal('z load', obj.get_data(obj.settings.loadz));
            signals('accy') = signal('y acceleration', obj.get_data(obj.settings.accy));
            signals('accz') = signal('z acceleration', obj.get_data(obj.settings.accz));
            signals('accx') = signal('x acceleration', obj.get_data(obj.settings.accx));
            length = size(signals('pot').data);
            length = length(1,:);
            signals('time') = signal('time', (0: obj.settings.sample_rate: ((length-1)*obj.settings.sample_rate))');
        end

        function data = get_data(obj, setting)
            if setting == 'none'
                data = false;
            else
                data = obj.data{1, setting}(:,1);
            end
        end
    end
end
