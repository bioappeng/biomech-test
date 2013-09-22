%represents a signal/datastream from a single channel
%of a sensor
classdef signal < handle & flaggable
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
        
        function flag(obj)
            obj.flagged = true;
        end

        function unflag(obj)
            obj.flagged = false;
        end
    end
end
