%abstract class that designates an object as
%flaggable. suggested use: for users to designate
%items as potentially 'bad' -- potentially ignore
%when doing analysis
classdef flaggable < handle
    properties (Abstract)
        flagged;
    end

    methods (Abstract)
        flag(obj);
        unflag(obj);
    end 
end
