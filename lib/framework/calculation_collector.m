%collects/stores calculated values
classdef calculation_collector < handle
    properties
        calculated;
    end

    methods
        function add_field(obj, value, field_name)
            try
                obj.calculated.(field_name) = value;
            catch err
            end
        end
        
        function parameter = access_field(obj, parameter_name)
            if isfield(obj.calculated, parameter_name)
                parameter = obj.calculated.(parameter_name);
            else
                parameter = [];
            end
        end
    end
end
