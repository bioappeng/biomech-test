classdef process_max_loadz < handle
    properties
        to_run
    end

    methods
        function obj = process_max_loadz(set)
            obj.to_run = process_max_loadz.assess_to_run(set);
        end
    end

    methods (Static)
        function to_run = assess_to_run(Set)
            if Set.get_drop(1).signals('loadz').data == false;
                to_run = false;
            else
                to_run = true;
            end
        end

        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.get_drop(i);
                max_value(i, 1) = max((drop.signals('loadz').data));
            end
            collector.add_field(max_value, 'max_loadz');
        end
    end
end
