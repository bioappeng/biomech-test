classdef process_max_accz < handle & process
    methods (Static)
        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.get_drop(i);
                max_acc(i, 1) = max((drop.signals('accz').data(drop.window_start:drop.window_end)));
            end
            collector.add_field(max_acc, 'max_accz');
        end
    end
end
