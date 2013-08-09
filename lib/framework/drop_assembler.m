classdef drop_assembler < handle
    properties (Constant)
        sample_rate = 1/2000;
    end

    methods
        function drops = assemble(obj, path, num_headerlines, three_axis_load, isascii)
            drops = [];
            if isascii
                fext = '*.txt';
                flist = dir([path, fext]);
                numfiles = size(flist,1);
                for i=1:numfiles
                    filepath = [path, flist(i,1).name];
                    drops(i).Value = ascii_drop(filepath, num_headerlines,...
                                              three_axis_load, obj.sample_rate);
                end
            else
                file = path;
                database = load(path);
                for i=1:length(database.DHdb);
                    channels = obj.get_which_mat_channels(database, i);
                    signals = obj.make_mat_signals_from_channels(channels, database.DHdb(i).data, three_axis_load, obj.sample_rate);
                    drops(i).Value = mat_drop(signals);
                end
            end
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

        function signals = make_mat_signals_from_channels(obj, channels, data, three_axis_load, sample_rate)
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
    end
end
