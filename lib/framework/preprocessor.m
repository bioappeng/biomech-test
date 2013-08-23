classdef preprocessor < handle
    properties
        position_const = 433.0;
        single_axis_load_const = (1000/0.2273);
        triaxial_load_const = 1;
        acceleration_const = (1/0.010);
        window_start;
        window_end;
    end

    methods
        function remove_dc_offset(obj, signal)
            yfft = fft(signal.data);
            [a,i] = max(abs(yfft));
            yfft(i,1) = 0;
            signal.data = real(ifft(yfft));
        end

        function calculate_window(obj, x_load, position)
            [throwaway_value, min_index] = min(x_load.data);
            while position.data(min_index) < 0
                min_index = min_index - 1;
            end
            obj.window_start = min_index - 50;
            obj.window_end = obj.window_start + 145;
        end

        function preprocess_signals(obj, set)
            import containers.Map;

            for i = 1:set.num_drops;
                drop = set.get_drop(i);
                pot = drop.signals('pot');
                load = drop.signals('load');
                accx = drop.signals('accx');
                accy = drop.signals('accy');
                accz = drop.signals('accz');
                loady = drop.signals('loady');
                loadz = drop.signals('loadz');
                loadx = drop.signals('loadx');

                obj.calibrate_position(pot);
                obj.calibrate_single_axis_load(load);
                obj.calibrate_acceleration(accx);
                obj.calibrate_acceleration(accy);
                obj.calibrate_acceleration(accz);
                obj.calibrate_triaxial_load(loadx);
                obj.calibrate_triaxial_load(loady);
                obj.calibrate_triaxial_load(loadz);

                obj.calculate_window(loadx, pot);
                obj.set_signal_windows(drop.signals);
            end
        end

        function set_signal_windows(obj, signals)
        end

        function calibrate_position(obj, pot)
            position = pot.data * obj.position_const;
            pos_min = min(position);
            pot.data = position - pos_min;
        end

        function calibrate_single_axis_load(obj, load)
            load.data = load.data * obj.single_axis_load_const;
        end

        function calibrate_acceleration(obj, acc)
            acc.data = acc.data * obj.acceleration_const;
        end

        function calibrate_triaxial_load(obj, load)
            load.data * obj.triaxial_load_const;
            obj.remove_dc_offset(load);
        end
    end
end
