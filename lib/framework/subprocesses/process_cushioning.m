classdef process_cushioning < handle
    properties
        to_run
    end

    methods
        function obj = process_cushioning(set)
            obj.to_run = process_cushioning.assess_to_run(set);
        end
    end

    methods (Static)
        function to_run = assess_to_run(set)
            if set.get_drop(1).signals('loadz').data == false;
                to_run = false;
            else
                to_run = true;
            end
        end

        function run(collector, set)
            for i=1:set.num_drops
                drop = set.get_drop(i);
                max_acc(i, 1) = max((drop.signals('loadz').data(drop.window_start:drop.window_end)));
            end
            collector.add_field(max_acc, 'cushioning')
        end
    end
end
