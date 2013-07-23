classdef process_basic_process < process & handle
    properties (Constant)
        field_name = 'test';
        value = 12341;
    end
    methods (Static)
        function run(collector, dropSet)
            collector.add_field(process_basic_process.value, process_basic_process.field_name);
        end
    end
end
