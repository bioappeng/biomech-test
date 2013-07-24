classdef dropSet < handle
    properties
        drops
        num_drops
        three_axis_load
    end
    
    properties (Constant)
        sample_rate = 1/2000;
    end

    methods (Static)
        function drops = assemble_mat_drops(path, three_axis_load, sample_rate)
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
                drops(i).Value = matDrop(database.DHdb(i).data,...
                                             channels, three_axis_load,...
                                             sample_rate);
            end
        end

        function drops = assemble_ascii_drops(path, three_axis_load, num_headerlines, sample_rate)
            fext = '*.txt';
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                drops(i).Value = asciiDrop(filepath, num_headerlines,...
                                          three_axis_load, sample_rate);
            end
        end
    end
    
    methods
        function obj = dropSet(path, num_headerlines, three_axis_load, isascii)
            obj.three_axis_load = three_axis_load;
            if isascii
                obj.drops = dropSet.assemble_ascii_drops(path, three_axis_load,...
                                                         num_headerlines,...
                                                         obj.sample_rate);
            else
                obj.drops = dropSet.assemble_mat_drops(path, three_axis_load,...
                                                       obj.sample_rate);
            end
            
            num_drops = size(obj.drops);
            obj.num_drops = num_drops(2);
        end

        function ids = drop_ids(obj)
            ids = {};
            for i=1:length(obj.drops)
                ids{end + 1} = obj.drops(i).Value.id;
            end
        end
    end
end
