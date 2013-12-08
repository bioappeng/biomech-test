%represents a signal/datastream from a single channel
%of a sensor
classdef signal < handle
    properties
        data;
        name;
        flagged;
        window_start;
        window_end;
    end

    methods
        function obj = signal(name, data)
            obj.name = name;
            obj.data = data;
            obj.flagged = false;
        end
        
        function change_flagged(obj)
            obj.flagged = ~obj.flagged;
        end
    end
end
