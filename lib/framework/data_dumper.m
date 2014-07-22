%dumps values from a calculation_collector into a csv file
classdef data_dumper < handle
    properties
        data;
    end

    methods
        function grab_data(obj, collector)
            obj.data = collector.calculated;
        end

        function err = dump(obj, file_path)
            err = 1;
            FID = fopen(file_path, 'w+');
            if FID == -1
                %File already open
                err = 0;
            else
                struct2csv(obj.data, FID);
                fclose(FID);
            end
        end
    end
end
