%{
drop class

represents some set of drops with common settings.
%}

classdef drop_set < handle
    properties
        drops;
        num_drops;
        settings;
    end
    
    methods
        function set_settings(obj, settings);
            obj.settings = settings;
        end
        
        %{
        constructor for drop_set

        param: an array of drops
        %}
        function obj = drop_set(drops)
            obj.drops = drops;
            num_drops = size(obj.drops);
            obj.num_drops = num_drops(2);
        end

        %{
        gets an array of the ids of the drops in order
        
        return: array of the ids of the drops in order
        %}
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
