%dropSet -- represents a set of drops (drops are implemented
%       by the drop class) of the biomechanical hoof tester
%           
%           ex. - a lap around a track with n drops
%               - a grid of drops around an arena
%               - etc.
%
%contains methods for processing of data

classdef dropSet < handle
    properties
        drops
        num_drops
        
        three_axis_load
        num_headerlines
    end
    properties (Constant)
        pos_calib_value = 433.0; %needs a better variable name -- is a multiplier?
        load_calib_value = (1000/0.2273); %same as above -- original comment
                                          %from Christie: 1000 N (1 kN) = .2273 mV
        loadxyz_calib_value = 1; %see above. again.
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

            for i=1:numfiles
                %read in data
                filepath = [path, flist(i,1).name];
                obj.drops(i).Value = drop(filepath, num_headerlines,...
                                          three_axis_load, obj.sample_rate);
            end
            
            num_drops = size(obj.drops);
            obj.num_drops = num_drops(2);
        end
        
        %position calibration.
        function calib_pos(obj)
            for i=1:obj.num_drops
                obj.drops(i).Value.pos = obj.drops(i).Value.pos * obj.pos_calib_value;
                drop_min = min(obj.drops(i).Value.pos);
                obj.drops(i).Value.pos = obj.drops(i).Value.pos - drop_min;
            end 
        end
        
        %single-axis load calibration
        function calib_load(obj)
            amp = 1; %don't know what this is or where it should be going. does it change?
            for i=1:obj.num_drops
                obj.drops(i).Value.load = obj.drops(i).Value.load * amp * obj.load_calib_value;
            end
        end
        
        %triaxial load calibration
        function calib_load_triax(obj)
            for i=1:obj.num_drops
                
                %MISSING remove_noise() functionality
                
                obj.drops(i).Value.loadx = obj.drops(i).Value.loadx * obj.loadxyz_calib_value;
                obj.drops(i).Value.loady = obj.drops(i).Value.loady * obj.loadxyz_calib_value;
                obj.drops(i).Value.loadz = obj.drops(i).Value.loadz * obj.loadxyz_calib_value;
            end
        end
    end
end