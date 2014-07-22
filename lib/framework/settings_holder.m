%{
settings_holder class

effectively a handle wrapper class. settings is currently implemented
with Map, which is not a handle object.
%}

classdef settings_holder < handle
    properties
        settings;
    end
    
    methods
        %{
        constructor for settings_holder

        param: settings -- a Map containing settings
        %}
        function obj = settings_holder(settings)
            obj.settings = settings;
        end
    end
end
