%represents some set of drops
classdef drop_set < handle
    properties
        drops;
        num_drops;
        settings;
    end
    
    properties (Constant)
    end
    
    methods
        function set_settings(obj, settings);
            obj.settings = settings;
        end
        
        function obj = drop_set(drops)
            obj.drops = drops;
            num_drops = size(obj.drops);
            obj.num_drops = num_drops(2);
        end

        function ids = drop_ids(obj)
            ids = {};
            for i=1:length(obj.drops)
                ids{end + 1} = obj.get_drop(i).get_id();
            end
        end

        function drop = get_drop(obj, drop_num)
            drop = obj.drops(drop_num).Value;
        end
    end
end
