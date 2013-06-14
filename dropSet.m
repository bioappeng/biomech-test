classdef dropSet
    properties
        pos
        load
        accx
        accy
        accz
        loadx
        loady
        loadz
    end
    methods
        function obj = dropSet(pos, load, accx, accy, accz)
            obj.pos = pos;
            obj.load = load;
            obj.accx = accx;
            obj.accy = accy;
            obj.accz = accz;
        end
        function obj = dropSet_3axLoad(pos, accx, accy, accz, loadx, loady, loadz)
            obj.pos = pos;
            obj.load = load;
            obj.accx = accx;
            obj.accy = accy;
            obj.accz = accz;
            obj.loadx = loadx;
            obj.loady = loady;
            obj.loadz = loadz;
        end
    end
end