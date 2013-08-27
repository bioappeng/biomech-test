classdef drop_assembler < handle
    properties
        settings;
    end

    methods
        function obj = drop_assembler(settings)
            obj.settings = settings;
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
            fext = obj.settings.settings.text_file_extension;
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                [id, data] = obj.parse_ascii_file(filepath, num_headerlines);
                signals = obj.build_ascii_signals(data);
                drops(i).Value = drop(signals, id, obj.settings.settings.sample_rate);
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
                drops(i).Value = drop(signals, [], obj.settings.settings.sample_rate);
            end
        end

        function [id, data] = parse_ascii_file(obj, filepath, headerlines)
            [pathstr, id, ext] = fileparts(filepath);
            file = fopen(filepath);
            numfields = '%f%f%f%f%f%f%f%f';
            data = textscan(file, numfields, 'HeaderLines', headerlines);
            fclose(file);
        end

        function signals = build_ascii_signals(obj, data)
            import containers.Map;

            signals = Map();
            signals('pot') = signal('string pot', data{1,1}(:,1));
            signals('load') = signal('single axis load', data{1,2}(:,1));
            signals('loady') = signal('y load', data{1,3}(:,1));
            signals('loadx') = signal('x load', data{1,4}(:,1));
            signals('loadz') = signal('z load', data{1,5});
            signals('accy') = signal('y acceleration', data{1,6}(:,1));
            signals('accz') = signal('z acceleration', data{1,7}(:,1));
            signals('accx') = signal('x acceleration', data{1,8}(:,1));
            length = size(signals('pot').data);
            length = length(1,:);
            signals('time') = signal('time', (0: obj.settings.settings.sample_rate: ((length-1)*obj.settings.settings.sample_rate))');
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
            signals('time') = signal('time', (0:obj.settings.settings.sample_rate:((length-1) * obj.settings.settings.sample_rate))');
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
