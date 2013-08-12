classdef drop_assembler < handle
    properties (Constant)
        sample_rate = 1/2000;
    end

    methods
        function drops = assemble(obj, path, num_headerlines, three_axis_load, isascii)
            if isascii
                drops = obj.build_ascii_drops(path, num_headerlines, three_axis_load);
            else
                drops = obj.build_mat_drops(path);
            end
        end

        function drops = build_ascii_drops(obj, path, num_headerlines, three_axis_load)
            fext = '*.txt';
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                [pathstr, name, ext] = fileparts(filepath);
                id = name;
                data = obj.parse_ascii_file(filepath, three_axis_load, num_headerlines);
                signals = obj.build_ascii_signals(data, obj.sample_rate);
                drops(i).Value = ascii_drop(signals, name);
            end
        end

        function drops = build_mat_drops(obj, path)
            file = path;
            database = load(path);
            for i=1:length(database.DHdb);
                channels = obj.get_which_mat_channels(database, i);
                signals = obj.build_mat_signals(channels, database.DHdb(i).data, obj.sample_rate);
                drops(i).Value = mat_drop(signals);
            end
        end

        function data = parse_ascii_file(obj, filepath, three_axis_load, headerlines)
            if three_axis_load
                numfields = '%f%f%f%f%f%f%f%f';
            else
                numfields = '%f%f%f%f%f';
            end
            file = fopen(filepath);
            data = textscan(file, numfields, 'HeaderLines', headerlines);
            fclose(file);
        end

        function signals = build_ascii_signals(obj, data, sample_rate)
            import containers.Map;

            signals = Map();
            signals('pot') = signal('string pot', data{1,1}(:,1));
            signals('load') = signal('single axis load', data{1,2}(:,1));
            signals('accx') = signal('x acceleration', data{1,3}(:,1));
            signals('accy') = signal('y acceleration', data{1,4}(:,1));
            signals('accz') = signal('z acceleration', data{1,5}(:,1));
            signals('loadx') = signal('x load', data{1,6}(:,1));
            signals('loady') = signal('y load', data{1,7}(:,1));
            signals('loadz') = signal('z load', data{1,8}(:,1));
            length = size(signals('pot').data);
            length = length(1,:);
            signals('time') = signal('time', (0: sample_rate: ((length-1)*sample_rate))');
        end

        function signals = build_mat_signals(obj, channels, data, sample_rate)
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
            signals('time') = signal('time', (0: sample_rate: ((length-1)*sample_rate))');
        end

        function channels = get_which_mat_channels(obj, database, index)
            channels.pch = database.DHdb(index).ChInfo.pch;
            channels.lch = database.DHdb(index).ChInfo.lch;
            channels.vch = database.DHdb(index).ChInfo.vch;
            channels.tch = database.DHdb(index).ChInfo.tch;
            channels.fach = database.DHdb(index).ChInfo.fach;
            channels.p2ch = database.DHdb(index).ChInfo.p2ch;
            channels.tlch = database.DHdb(index).ChInfo.tlch;
            channels.vlch = database.DHdb(index).ChInfo.vlch;
            channels.falch = database.DHdb(index).ChInfo.falch;
        end
    end
end
