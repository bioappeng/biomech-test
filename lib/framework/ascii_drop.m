classdef ascii_drop < handle & flaggable
    properties
        id
        signals
        flagged
    end
    
    methods
        function obj = ascii_drop(signals, id)
            obj.signals = signals;
            obj.id = id;
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
