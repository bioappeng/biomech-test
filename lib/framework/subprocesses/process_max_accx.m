classdef process_max_accx < handle & process
    methods (Static)
        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.get_drop(i);
                acc = drop.signals('accx').data * (1.0/0.010);
                max_acc(i, 1) = max(abs(acc));
            end
            collector.add_field(max_acc, 'max_accx');
        end
    end
end
