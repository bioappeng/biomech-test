classdef processor < handle
    methods
        function obj = processor()
        end
        
        function apply_process(obj, collector, dropSet, process)
            process(collector, dropSet);
        end
    end
end