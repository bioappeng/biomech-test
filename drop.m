classdef (Abstract) drop < handle
    properties (Abstract)
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
end
