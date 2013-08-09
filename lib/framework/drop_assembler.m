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
                    channels.pch = database.DHdb(i).ChInfo.pch;
                    channels.lch = database.DHdb(i).ChInfo.lch;
                    channels.vch = database.DHdb(i).ChInfo.vch;
                    channels.tch = database.DHdb(i).ChInfo.tch;
                    channels.fach = database.DHdb(i).ChInfo.fach;
                    channels.p2ch = database.DHdb(i).ChInfo.p2ch;
                    channels.tlch = database.DHdb(i).ChInfo.tlch;
                    channels.vlch = database.DHdb(i).ChInfo.vlch;
                    channels.falch = database.DHdb(i).ChInfo.falch;
                    drops(i).Value = mat_drop(database.DHdb(i).data,...
                                                 channels, three_axis_load,...
                                                 obj.sample_rate);
                end
            end
        end
    end
end
