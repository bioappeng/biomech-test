classdef matDrop < drop & handle
    properties
        time
        pot
        pot2
        load
        accx
        accy
        accz
        loadx
        loady
        loadz
    end

    methods
        function obj = matDrop(data, channels, three_axis_load, sample_rate)
            obj.pot = data(channels.pch);
            obj.load = data(channels.lch);
            obj.accx = data(channels.vch);
            obj.accy = data(channels.tch);
            obj.accz = data(channels.fach);
            obj.pot2 = data(channels.p2ch);
            obj.loady = data(channels.tlch);
            obj.loadx = data(channels.vlch);
            obj.loadz = data(channels.falch);
            length = size(obj.pot);
            length = length(1,:);
            obj.time = (0: sample_rate: ((length-1)*sample_rate))';
        end
    end
end
