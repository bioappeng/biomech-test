%assembles drops from their respective data formats
%using settings provided in settings_holder object
classdef drop_assembler < handle
    properties
        settings;
        ascii_data;
    end

    methods
        function obj = drop_assembler(settings)
            obj.settings = settings.settings;
        end

        function drops = assemble(obj, path, num_headerlines, isascii)
            if isascii
                drops = obj.build_ascii_drops(path, num_headerlines);
            else
                database = obj.get_mat_database(path);
                drops = obj.build_mat_drops_from_database(database);
            end
        end

        function drops = build_ascii_drops(obj, path, num_headerlines)
            fext = obj.settings.text_file_extension;
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                [id, obj.ascii_data] = obj.parse_ascii_file(filepath, num_headerlines);
                signals = obj.build_ascii_signals();
                drops(i).Value = drop(signals, id, obj.settings.sample_rate);
            end
        end

        function database = get_mat_database(obj, path)
            file = path;
            database = load(path);
            database = database.DHdb;
        end

        function drops = build_mat_drops_from_database(obj, database)
            for i=1:length(database);
                channels = obj.get_which_mat_channels(database, i);
                signals = obj.build_mat_signals(channels, database(i).data);
                drops(i).Value = drop(signals, [], obj.settings.sample_rate);
            end
        end

        function [id, data] = parse_ascii_file(obj, filepath, headerlines)
            [pathstr, id, ext] = fileparts(filepath);
            file = fopen(filepath);
            numfields = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
            data = textscan(file, numfields, 'HeaderLines', headerlines);
            fclose(file);
        end

        function signals = build_ascii_signals(obj)
            import containers.Map;

            signals = Map();
            signals('pot') = signal('string pot', obj.get_ascii_data(obj.settings.string_pot));
            signals('pot2') = signal('head pot', obj.get_ascii_data(obj.settings.head_pot));
            signals('load') = signal('single axis load', obj.get_ascii_data(obj.settings.single_axis_load));
            signals('loady') = signal('y load', obj.get_ascii_data(obj.settings.loady));
            signals('loadx') = signal('x load', obj.get_ascii_data(obj.settings.loadx));
            signals('loadz') = signal('z load', obj.get_ascii_data(obj.settings.loadz));
            signals('accy') = signal('y acceleration', obj.get_ascii_data(obj.settings.accy));
            signals('accz') = signal('z acceleration', obj.get_ascii_data(obj.settings.accz));
            signals('accx') = signal('x acceleration', obj.get_ascii_data(obj.settings.accx));
            length = size(signals('pot').data);
            length = length(1,:);
            signals('time') = signal('time', (0: obj.settings.sample_rate: ((length-1)*obj.settings.sample_rate))');
        end

        function data = get_ascii_data(obj, setting)
            if setting == 'none'
                data = false;
            else
                data = obj.ascii_data{1, setting}(:,1);
            end
        end

        function signals = build_mat_signals(obj, channels, data)
            import containers.Map;

            signals = Map();
            signals('pot') = signal('string pot', data(channels.pch));
            signals('load') = signal('single axis load', data(channels.lch));
            signals('accx') = signal('x acceleration', data(channels.vch));
            signals('accy') = signal('y acceleration', data(channels.tch));
            signals('accz') = signal('z acceleration', data(channels.fach));
            signals('pot2') = signal('linear/head pot', data(channels.p2ch));
            signals('loady') = signal('y load', data(channels.tlch));
            signals('loadx') = signal('x load', data(channels.vlch));
            signals('loadz') = signal('z load', data(channels.falch));
            length = size(signals('pot').data);
            length = length(1,:);
            signals('time') = signal('time', (0:obj.settings.sample_rate:((length-1) * obj.settings.sample_rate))');
        end

        function channels = get_which_mat_channels(obj, database, index)
            channels.pch = database(index).ChInfo.pch;
            channels.lch = database(index).ChInfo.lch;
            channels.vch = database(index).ChInfo.vch;
            channels.tch = database(index).ChInfo.tch;
            channels.fach = database(index).ChInfo.fach;
            channels.p2ch = database(index).ChInfo.p2ch;
            channels.tlch = database(index).ChInfo.tlch;
            channels.vlch = database(index).ChInfo.vlch;
            channels.falch = database(index).ChInfo.falch;
        end
    end
end
