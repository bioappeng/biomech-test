classdef (Abstract) process < handle
    properties
        to_run;
    end
    
    methods (Abstract, Static)
        run
    end
end
