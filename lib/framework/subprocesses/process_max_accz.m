classdef process_max_accz < process & handle
    methods (Static)
        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.drops(i).Value;
                max_acc(i, 1) = max(abs(drop.accz.data));
            end
            collector.add_field(max_acc, 'max_accz');
        end
    end
end
