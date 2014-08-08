classdef process_grip < handle
    properties
        to_run
    end

    methods
        function obj = process_grip(set)
            obj.to_run = process_impact_firmness.assess_to_run(set);
        end
    end

    methods (Static)
        function to_run = assess_to_run(set)
            first_drop_signals = set.get_drop(1)
            if first_drop_signals('loadz').data == true...
                and first_drop_signals('loady').data == true...
                and first_drop_signals('pot').data == true;
                to_run = true;
            else
                to_run = false;
            end
        end

        function run(collector, set)
            for i=1:set.num_drops
                drop = set.get_drop(i);
        end
    end
end
