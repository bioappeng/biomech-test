%{
processor class

Applys a process to a drop_set, and calculation_collector
%}
classdef processor < handle
    methods
        function obj = processor()
        end
        
        %{
        applies a process to a calculation_collector and a dropset.

        param: collector -- the calculation_collector in which to
        store the data
        param: dropSet -- the drop_set to apply the process to
        param: process -- the process to apply to the dropset
        %}
        function apply_process(obj, collector, dropSet, process)
            process.run(collector, dropSet);
        end
    end
end
