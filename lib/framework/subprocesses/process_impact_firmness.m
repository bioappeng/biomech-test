classdef process_impact_firmness < handle
    properties
        to_run
    end

    methods
        function obj = process_impact_firmness(set)
            obj.to_run = process_impact_firmness.assess_to_run(set);
        end
    end

    methods (Static)
        function to_run = assess_to_run(set)
            if set.get_drop(1).signals('accx').data == false;
                to_run = false;
            else
                to_run = true;
            end
        end

        function run(collector, set)
            for i=1:set.num_drops
                drop = set.get_drop(i);
                max_acc(i, 1) = max((drop.signals('accx').data(drop.window_start:drop.window_end)));
            end
            collector.add_field(max_acc, 'impact_firmness')
        end
    end
end
