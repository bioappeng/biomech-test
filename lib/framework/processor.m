%an object that applys a process to a drop_set, and calculation_collector
classdef processor < handle
    methods
        function obj = processor()
        end
        
        function apply_process(obj, collector, dropSet, process)
            process.run(collector, dropSet);
        end
    end
end
