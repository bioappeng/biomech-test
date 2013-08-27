classdef process_max_load < handle
    properties
        to_run
    end

    methods
        function obj = process_max_load(set)
            obj.to_run = process_max_load.assess_to_run(set);
        end
    end

    methods (Static)
        function to_run = assess_to_run(Set)
            if Set.get_drop(1).signals('load').data == false;
                to_run = false;
            else
                to_run = true;
            end
        end

        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.get_drop(i);
                max_value(i, 1) = max((drop.signals('load').data(drop.window_start:drop.window_end)));
            end
            collector.add_field(max_value, 'max_load');
        end
    end
end
