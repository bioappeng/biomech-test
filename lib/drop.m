classdef (Abstract) drop < handle & flaggable
    properties (Abstract)
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

    methods (Abstract)
        flag(obj)
        unflag(obj)
    end
end
