%{
drop class

Represents one drop of the OBST hoof. Has an id, contains a Map of signals,
and can be flagged as bad (good by default).

%}

classdef drop < handle
    properties
        id
        signals
        flagged
        sample_rate
        window_start
        window_end
    end

    methods

        %{
        Constructor for drop

        Constructs a drop with the given signals , id, and sample_rate

        param: signals -- a Map of the signal data associated with the drop
        param: id -- the string id of the drop
        param: sample_rate -- the sample rate of the signals
        %}
        function obj = drop(signals, id, sample_rate)
            obj.sample_rate = sample_rate;
            obj.signals = signals;
            obj.id = id;
            obj.flagged = false;
        end

        %{
        Changes the flagged status of the drop. 
        %}
        function change_flagged(obj)
            obj.flagged = ~obj.flagged;
        end
        
        function id = get_id(obj)
            id = obj.id;
        end
    end
end
