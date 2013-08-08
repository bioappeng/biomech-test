classdef process_max_accx < handle & process
    methods (Static)
        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.drops(i).Value;
                max_acc(i, 1) = max(abs(drop.accx.data));
            end
            collector.add_field(max_acc, 'max_accx');
        end
    end
end
