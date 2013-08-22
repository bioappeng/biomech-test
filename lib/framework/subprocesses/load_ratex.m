classdef load_ratex < process & handle
    methods (Static)
        function run(collector, set)
            for i=1:set.num_drops
                drop = set.get_drop(i);
                calibrated_load = load_ratex.calibrate(drop);
                [throwaway_value, peak_load_location] = max(load_rate.calibrate(drop));
                start = peak_load_location - 50;
                finish = peak_load_location + 145;
                load_rate(:, i) = diff(smooth(calibrated_load(start:finish+1)))./diff(drop.signals('time').data(start:finish+1));
            end
        end

        function calibrated_load = calibrate(drop)
            calibrated_load = drop.signals('loadx').data;
        end
    end
end
