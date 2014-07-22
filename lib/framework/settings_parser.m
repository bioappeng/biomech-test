%{
settings_parser class

parses a yaml settings file
%}
classdef settings_parser < handle
    properties
        filename;
    end

    methods
        %{
        constructor for the settings_parser

        param: filename -- the path of the settings file
        %}
        function obj = settings_parser(filename)
            obj.filename = filename;
        end

        %{
        parses the settings file

        return: a settings_holder
        %}
        function settings = parse_settings(obj)
            settings = settings_holder(ReadYaml(obj.filename));
        end
    end
end
