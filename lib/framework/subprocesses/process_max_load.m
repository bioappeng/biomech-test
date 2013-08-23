classdef process_max_load < handle & process
    methods (Static)
        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.get_drop(i);
                max_value(i, 1) = max((drop.signals('load').data));
            end
            collector.add_field(max_value, 'max_load');
        end
    end
end
