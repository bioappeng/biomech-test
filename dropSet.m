%dropSet -- represents a set of drops (drops are implemented
%       by the drop class) of the biomechanical hoof tester
%           
%           ex. - a lap around a track with n drops
%               - a grid of drops around an arena
%               - etc.
%

classdef dropSet < handle
    properties
        drops
        num_drops
        three_axis_load
    end
    
    properties (Constant)
        sample_rate = 1/2000;
    end
    
    methods
        function obj = dropSet(path, num_headerlines, three_axis_load)
            fext = '*.txt';
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            
            obj.three_axis_load = three_axis_load;

            for i=1:numfiles
                %read in data
                filepath = [path, flist(i,1).name];
                obj.drops(i).Value = drop(filepath, num_headerlines,...
                                          three_axis_load, obj.sample_rate);
            end
            
            num_drops = size(obj.drops);
            obj.num_drops = num_drops(2);
        end
    end
end
