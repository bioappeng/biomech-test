classdef matDrop < drop & handle
    properties
        id

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

        flagged
    end

    methods
        function obj = matDrop(data, channels, three_axis_load, sample_rate)
            obj.pot = signal(data(channels.pch));
            obj.load = signal(data(channels.lch));
            obj.accx = signal(data(channels.vch));
            obj.accy = signal(data(channels.tch));
            obj.accz = signal(data(channels.fach));
            obj.pot2 = signal(data(channels.p2ch));
            obj.loady = signal(data(channels.tlch));
            obj.loadx = signal(data(channels.vlch));
            obj.loadz = signal(data(channels.falch));
            length = size(obj.pot.data);
            length = length(1,:);
            obj.time = signal((0: sample_rate: ((length-1)*sample_rate))');

            obj.flagged = false;
        end

        function flag(obj)
            obj.flagged = true;
        end
        
        function unflag(obj)
            obj.flagged = false;
        end
    end
end
