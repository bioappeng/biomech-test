classdef process_responsiveness < handle
    properties
        to_run
    end

    methods
        function obj = process_responsiveness(set)
            obj.to_run = process_responsiveness.assess_to_run(set);
        end
    end

    methods (Static)
        function to_run = assess_to_run(set)
            to_run = true
        end

        function run(collector, set)
            for i=1:set.num_drops
                drop = set.get_drop(i);
                max_value(i, 1) = max((drop.signals('loadz').data(drop.window_start:drop.window_end)));
            end
            collector.add_field(max_value, 'max_loadz');
        end
    end
end
