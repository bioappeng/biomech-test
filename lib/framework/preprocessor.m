%does preprocessing/calibration to prepare raw data for processing
classdef preprocessor < handle
    properties
        window_start;
        window_end;
        set;
    end

    methods (Static)
        function set_window(set, window_start, window_end)
            for i = 1:set.num_drops;
                drop = set.drops(i).Value;
                %Window is calculated manually for now
                drop.window_start = window_start;
                drop.window_end = window_end;
            end
        end
    end

    methods
        function preprocess_signals(obj, set)
            import containers.Map;
            obj.set = set;
            %Hard-coded, this needs looking after

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
                obj.calibrate_acc_x(accx);
                obj.calibrate_acc_y(accy);
                obj.calibrate_acc_z(accz);
                obj.calibrate_load_x(loadx);
                obj.calibrate_load_y(loady);
                obj.calibrate_load_z(loadz);
            end
        end

        function remove_dc_offset(obj, signal)
            total = 0;
            for i=1:length(signal.data)
                total = total + signal.data(i);
            end
            offset = total / length(signal.data);
            signal.data = signal.data - offset;
        end

        function calibrate_position(obj, pot)
            pot.data = pot.data * obj.set.settings.settings.string_pot_calibration;
            pot_min = min(pot.data);
            pot.data = pot.data - pot_min;
        end

        function calibrate_single_axis_load(obj, load)
            obj.remove_dc_offset(load)
            load.data = load.data * obj.set.settings.settings.uni_load_calibration;
        end

        function calibrate_acc_x(obj, acc)
            obj.remove_dc_offset(acc)
            acc.data = acc.data * obj.set.settings.settings.acc_x_calibration;
        end

        
        function calibrate_acc_y(obj, acc)
            obj.remove_dc_offset(acc)
            acc.data = acc.data * obj.set.settings.settings.acc_y_calibration;
        end
        
        function calibrate_acc_z(obj, acc)
            obj.remove_dc_offset(acc)
            acc.data = acc.data * obj.set.settings.settings.acc_z_calibration;
        end
        

        function calibrate_load_x(obj, load)
            obj.remove_dc_offset(load)
            load.data = load.data * obj.set.settings.settings.load_x_calibration;
        end
        
        function calibrate_load_y(obj, load)
            obj.remove_dc_offset(load)
            load.data = load.data * obj.set.settings.settings.load_y_calibration;
        end
        
        function calibrate_load_z(obj, load)
            obj.remove_dc_offset(load)
            load.data = load.data * obj.set.settings.settings.load_z_calibration;
        end
    end
end
