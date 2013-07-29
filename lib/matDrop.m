classdef matDrop < drop & handle & flaggable
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
            obj.pot = signal('string pot', data(channels.pch));
            obj.load = signal('single axis load', data(channels.lch));
            obj.accx = signal('x acceleration', data(channels.vch));
            obj.accy = signal('y acceleration', data(channels.tch));
            obj.accz = signal('z acceleration', data(channels.fach));
            obj.pot2 = signal('linear/head pot', data(channels.p2ch));
            obj.loady = signal('y load', data(channels.tlch));
            obj.loadx = signal('x load', data(channels.vlch));
            obj.loadz = signal('z load', data(channels.falch));
            length = size(obj.pot.data);
            length = length(1,:);
            obj.time = signal('time', (0: sample_rate: ((length-1)*sample_rate))');

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
