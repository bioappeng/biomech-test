classdef processor < handle
    methods
        function obj = processor()
        end
        
        function apply_process(obj, dropSet, process)
            process(dropSet, obj);
        end
    end
end
