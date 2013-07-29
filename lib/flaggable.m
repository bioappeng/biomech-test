classdef (Abstract) flaggable < handle
    properties (Abstract)
        flagged;
    end

    methods (Abstract)
        flag(obj);
        unflag(obj);
    end 
end
