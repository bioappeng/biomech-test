classdef processor < handle
    methods
        function obj = processor()
        end
        
        function output = apply_process(obj, collector, dropSet, process)
            output = process(collector, dropSet);
        end
    end
end
