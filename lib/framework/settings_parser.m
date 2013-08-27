classdef settings_parser < handle
    properties
        filename;
    end
    methods
        function obj = settings_parser(filename)
            obj.filename = filename;
        end

        function settings = parse_settings(obj)
            settings = settings_holder(ReadYaml(obj.filename));
        end
    end
end