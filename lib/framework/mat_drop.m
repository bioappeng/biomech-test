classdef mat_drop < handle & flaggable
    properties
        id
        signals
        flagged
    end

    methods
        function obj = mat_drop(signals)
            obj.signals = signals;
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
