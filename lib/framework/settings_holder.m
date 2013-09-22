%object container for settings
classdef settings_holder < handle
    properties
        settings;
    end
    
    methods
        function obj = settings_holder(settings)
            obj.settings = settings;
        end
    end
end
