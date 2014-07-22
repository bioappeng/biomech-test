%{
signal class

represents a signal/datastream from a single channel
of a sensor.
%}
classdef signal < handle
    properties
        data;
        name;
        flagged;
    end

    methods
        %{
        constructor for signal

        param: name -- the name of the signal
        param: data -- an array with values
        %}
        function obj = signal(name, data)
            obj.name = name;
            obj.data = data;
            obj.flagged = false;
        end
        
        %{
        changes the 'flagged' status of the signal
        %}
        function change_flagged(obj)
            obj.flagged = ~obj.flagged;
        end

        %{
        checks whether the object has data

        return: true if the object has data, false otherwise
        %}
        function whether_exists = exists(obj)
            if obj.data
                whether_exists = true;
            else
                whether_exists = false;
            end
        end
    end
end
