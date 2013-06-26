classdef processor < handle
    properties
       calculated = {}; 
    end
    
    methods
        function obj = processor()
        end
        
        function apply_process(obj, dropSet, process)
            process(dropSet, obj);
        end
        
        function col_index = next_open_col(obj)
            array_size = size(obj.calculated);
            col_index = array_size(2) + 1;
        end
        
        function row_index = next_open_row(obj)
            array_size = size(obj.calculated);
            row_index = array_size(1) + 1;
        end
        
        function field_number = add_field(obj, name)
            field_number = obj.next_open_col;
            obj.calculated(1,field_number) = {name};
        end
        
        function value_index = add_value(obj, value, field_number)
            value_index = obj.next_open_row();
            obj.calculated(value_index, field_number) = {value};
        end
    end
end