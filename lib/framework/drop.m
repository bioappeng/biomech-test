classdef drop < handle & flaggable
    properties
        id
        signals
        flagged
        window_start
        window_end
    end

    methods
        function obj = drop(signals, id)
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

        function id = get_id(obj)
            id = obj.id;
        end
    end
end
