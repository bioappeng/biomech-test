%represents a single drop of the testing rig
classdef drop < handle & flaggable
    properties
        id
        signals
        flagged
        sample_rate
        window_start
        window_end
    end

    methods
        function obj = drop(signals, id, sample_rate)
            obj.sample_rate = sample_rate;
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
