%{
calculation_collector class

stores calculated values
%}
classdef calculation_collector < handle
    properties
        calculated;
    end

    methods
        %{
        add a calculated vector of the given value with the given name

        param: value -- the value of the vector
        param: field_name -- the name of the calculated vector
        %}
        function add_field(obj, value, field_name)
            obj.calculated.(field_name) = value;
        end
        
        %{
        gets the calculated vector with the given parameter_name
        %}
        function parameter = access_field(obj, parameter_name)
            if isfield(obj.calculated, parameter_name)
                parameter = obj.calculated.(parameter_name);
            else
                parameter = [];
            end
        end
    end
end
