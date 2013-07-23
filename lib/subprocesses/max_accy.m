classdef max_accy < handle & process
    methods (Static)
        function run(collector, Set)
            max_acc = zeros(Set.num_drops, 1);
            for i=1:Set.num_drops
                drop = Set.drops(i).Value;
                max_acc(i, 1) = max(abs(drop.accy.data));
            end
            collector.add_field(max_acc, 'max_accy');
        end
    end
end
