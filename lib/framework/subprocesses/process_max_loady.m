classdef process_max_loady < handle & process
    methods (Static)
        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.get_drop(i);
                max_value(i, 1) = max((drop.signals('loady').data(drop.window_start:drop.window_end)));
            end
            collector.add_field(max_value, 'max_loady');
        end
    end
end
