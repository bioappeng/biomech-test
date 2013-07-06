classdef parameter_collector < handle
    properties
        calculated;
    end

    methods
        function obj = parameter_collector()
        end
        
        function add_data(obj, value, field_name)
            obj.calculated.(field_name) = value;
        end
    end
end
