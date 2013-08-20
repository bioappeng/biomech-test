classdef process_max_accy < handle & process
    methods (Static)
        function run(collector, Set)
            for i=1:Set.num_drops
                drop = Set.get_drop(i);
                max_acc(i, 1) = max(abs(drop.signals('accy').data));
            end
            collector.add_field(max_acc, 'max_accy');
        end
    end
end
