classdef signal < handle
    properties
        data;
        name;
        processes_run;
        flagged;
        window_start;
        window_end;
    end

    methods
        function obj = signal(name, data)
            obj.name = name;
            obj.data = data;
            obj.processes_run = [];
            obj.flagged = false;
        end
    end
end
