classdef load_rate < process & handle
    methods (Static)
        function run(collector, set)
            for i=1:set.num_drops
                drop = set.get_drop(i);
                calibrated_load = load_rate.calibrate(drop);
                [throwaway_value, peak_load_location] = max(calibrated_load);
                start = peak_load_location - 50;
                finish = peak_load_location + 145;
                load_rate = diff(smooth(calibrated_load(start:finish+1)))./diff(drop.signals('time').data(start:finish+1));
                max_load_rate(i) = max(load_rate);
                collector.add_field(max_load_rate, 'max_single_axis_load_rate');
            end
        end

        function calibrated_load = calibrate(drop)
            calibrated_load = drop.signals('load').data * 1 * (1000/0.2273);
        end
    end
end
