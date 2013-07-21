classdef signal < handle
    properties
        data;
        processes_run;
        flagged;
        window_start;
        window_end;
    end

    methods
        function obj = signal(data)
            obj.data = data;
            obj.processes_run = [];
            obj.flagged = false;
        end
    end
end
