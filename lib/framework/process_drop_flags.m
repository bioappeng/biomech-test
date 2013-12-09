classdef process_drop_flags < handle
    methods
        function flag(obj, collector, Set)
            for i = 1:Set.num_drops
                drop = Set.get_drop(i);
                flags(i, 1) = drop.flagged;
            end
            collector.add_field(flags, 'flagged');
        end
    end
end
