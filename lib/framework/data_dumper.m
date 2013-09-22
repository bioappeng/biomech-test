%dumps values from a calculation_collector into a csv file
classdef data_dumper < handle
    properties
        data;
    end
    methods
        function grab_data(obj, collector)
            obj.data = collector.calculated;
        end

        function dump(obj, file_path)
            FID = fopen(file_path, 'w+');
            struct2csv(obj.data, FID);
            fclose(FID);
        end
    end
end
