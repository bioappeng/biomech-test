%{
drop_assembler class

drop factory that creates drops from input data based on given settings
%}
classdef drop_assembler < handle
    properties
        settings;
        data; %this is really bad this shouldn't be here
    end

    methods
        %{
        constructor for drop_assembler

        param: settings -- a settings_holder containing settings for the
        drop creation
        %}
        function obj = drop_assembler(settings)
            obj.settings = settings.settings;
        end

        %{
        assembles an array of drops

        param: path -- the path to the directory containing the data to be
        parsed into drops.

        return: an array of drops
        %}
        function drops = assemble(obj, path)
            drops = obj.build_drops(path);
        end

        %{
        helper method for assemble
    
        does all the work for creating an array of drops from the data
        at the given filepath
        %}
        function drops = build_drops(obj, path)
            fext = obj.settings.text_file_extension;
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                [id, obj.data] = obj.parse_file(filepath, obj.settings.headerlines);
                signals = obj.build_signals();
                drops(i).Value = drop(signals, id, obj.settings.sample_rate);
            end
        end

        %{
        parses text data out of the file at the given filepath. ignores
        the given number of header lines.

        param: filepath -- the path of the file to be parsed
        param: headerlines -- the number of headerlines to ignore in the file
        %}
        function [id, data] = parse_file(obj, filepath, headerlines)
            [pathstr, id, ext] = fileparts(filepath);
            file = fopen(filepath);
            numfields = repmat('%f',1,43);
            data = textscan(file, numfields, 'HeaderLines', headerlines);
            fclose(file);
        end

        %{
        does the grunt work for assembling the signals struct

        returns a Map of signals
        %}
        function signals = build_signals(obj)
            import containers.Map;

            signals = Map();
            signals('pot') = signal('string pot', obj.get_data(obj.settings.string_pot));
            signals('pot2') = signal('head pot', obj.get_data(obj.settings.head_pot));
            signals('load') = signal('single axis load', obj.get_data(obj.settings.single_axis_load));
            signals('loady') = signal('y load', obj.get_data(obj.settings.loady));
            signals('loadx') = signal('x load', obj.get_data(obj.settings.loadx));
            signals('loadz') = signal('z load', obj.get_data(obj.settings.loadz));
            signals('accy') = signal('y acceleration', obj.get_data(obj.settings.accy));
            signals('accz') = signal('z acceleration', obj.get_data(obj.settings.accz));
            signals('accx') = signal('x acceleration', obj.get_data(obj.settings.accx));
            length = size(signals('pot').data);
            length = length(1,:);
            signals('time') = signal('time', (0: obj.settings.sample_rate: ((length-1)*obj.settings.sample_rate))');
        end

        function data = get_data(obj, setting)
            if setting == 'none'
                data = false;
            else
                data = obj.data{1, setting}(:,1);
            end
        end
    end
end
