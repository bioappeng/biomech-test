classdef data_dumper < handle
    properties
        data;
    end
    methods
        function grab_data(obj, collector)
            obj.data = collector.calculated;
        end
    end
end
