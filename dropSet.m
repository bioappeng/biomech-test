classdef dropSet
    properties
        drops
        
        three_axis_load
        num_headerlines
    end
    properties (Constant)
        pos_calib_value = 433.0; %needs a better variable name -- is a multiplier?
        sample_rate = 1/2000;
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
            obj.num_headerlines = num_headerlines;
            
            if three_axis_load == 0
                numfields = '%f%f%f%f%f'; %string pot, single ax load, triax accel
                num_cols = 5;
            elseif three_axis_load == 1
                numfields = '%f%f%f%f%f%f%f%f'; %If triaxial load cell included
                num_cols = 8;
            end
                        
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                obj.drops(i).Value = drop(filepath, num_headerlines, three_axis_load);
            end
        end
        
        %position calibration. not clear if posmin needs to be the minimum
        %of each drop (and calibration specific to the drop) or the minimum
        %of all drops in the dropset.
        function calib_pos(obj)
        end
    end
end