%{
drop_assembler class

drop factory that creates drops from input data based on given settings
%}
classdef drop_assembler < handle
    properties
        settings;
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
                [id, ascii_data] = obj.parse_file(filepath, obj.settings.headerlines, obj.settings.leftlabelcolumns);
                signals = obj.build_signals(ascii_data);
                drops(i).Value = drop(signals, id, obj.settings.sample_rate);
            end
        end

        %{
        parses text data out of the file at the given filepath. ignores
        the given number of header lines.

        param: filepath -- the path of the file to be parsed
        param: headerlines -- the number of headerlines to ignore in the file
        param: leftlabelcols -- the number of columns on the left to ignore
        (eg: date/time information)
        %}
        function [id, data] = parse_file(obj, filepath, headerlines, leftlabelcols)
            [pathstr, id, ext] = fileparts(filepath)
            %file = fopen(filepath);
            %numfields = repmat('%f',1,43);
            %data = textscan(file, numfields, 'HeaderLines', headerlines);
            data = csvread(filepath, headerlines, leftlabelcols);
        end

        %{
        does the grunt work for assembling the signals struct

        param: ascii_data -- the cell array from which to pull signals
        returns a Map of signals
        %}
        function signals = build_signals(obj, ascii_data)
            import containers.Map;

            signals = Map();
            signals('pot') = signal('string pot', obj.get_data(ascii_data, obj.settings.string_pot));
            signals('pot2') = signal('head pot', obj.get_data(ascii_data, obj.settings.head_pot));
            signals('load') = signal('single axis load', obj.get_data(ascii_data, obj.settings.single_axis_load));
            signals('loady') = signal('y load', obj.get_data(ascii_data, obj.settings.loady));
            signals('loadx') = signal('x load', obj.get_data(ascii_data, obj.settings.loadx));
            signals('loadz') = signal('z load', obj.get_data(ascii_data, obj.settings.loadz));
            signals('accy') = signal('y acceleration', obj.get_data(ascii_data, obj.settings.accy));
            signals('accz') = signal('z acceleration', obj.get_data(ascii_data, obj.settings.accz));
            signals('accx') = signal('x acceleration', obj.get_data(ascii_data, obj.settings.accx));
            length = size(signals('pot').data);
            length = length(1,:);
            signals('time') = signal('time', (0: obj.settings.sample_rate: ((length-1)*obj.settings.sample_rate))');
        end

        %{
        cleanly gets data from the given cell array

        param: ascii_data -- the data from which to get the signal vector
        param: setting -- the settings defining the column number of the
            signal vector

        return: false if the settings do not specify a column,
                the signal vector if the settings do specify a column
        %}
        function data = get_data(obj, ascii_data, setting)
            if setting == 'none'
                data = false;
            else
                data = ascii_data(:, setting);
            end
        end
    end
end
