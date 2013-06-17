classdef dropSet
    properties
        three_axis_load
        num_headerlines
        drops = [];
    end
    methods
        %constructor for dropSet class
        %takes a path (can be absolute or relative, but must be followed
        %with a trailing '\'), number of headerlines in the ascii files,
        %and a boolean for whether the data has 3 axis load data
        function obj = dropSet(path, num_headerlines, three_axis_load)
            fext = '*.txt';
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            
            obj.three_axis_load = three_axis_load;
            
            if three_axis_load == 0
                numfields = '%f%f%f%f%f'; %string pot, single ax load, triax accel
                num_cols = 5;
            elseif three_axis_load == 1
                numfields = '%f%f%f%f%f%f%f%f'; %If triaxial load cell included
                num_cols = 8;
            end
                        
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                obj.drops(i) = drop(filepath, num_headerlines, three_axis_load);
            end
        end
    end
end