%does preprocessing/calibration to prepare raw data for processing
classdef preprocessor < handle
    properties
        window_start;
        window_end;
        set;
    end

    methods

        function preprocess_signals(obj, set, window_start, window_end)
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
                
                %Window is calculated manually for now
                drop.window_start = window_start;
                drop.window_end = window_end;
            end
        end

        function calibrate_position(obj, pot)
            pot.data = pot.data * obj.set.settings.settings.string_pot_calibration;
%            pos_min = min(position);
%            pot.data = position - pos_min;
        end

        function calibrate_single_axis_load(obj, load)
            load.data = load.data * obj.set.settings.settings.uni_load_calibration;
        end

        function calibrate_acc_x(obj, acc)
            acc.data = acc.data * obj.set.settings.settings.acc_x_calibration;
        end

        
        function calibrate_acc_y(obj, acc)
            acc.data = acc.data * obj.set.settings.settings.acc_y_calibration;
        end
        
        function calibrate_acc_z(obj, acc)
            acc.data = acc.data * obj.set.settings.settings.acc_z_calibration;
        end
        

        function calibrate_load_x(obj, load)
            load.data = load.data * obj.set.settings.settings.load_x_calibration;
        end
        
        function calibrate_load_y(obj, load)
            load.data = load.data * obj.set.settings.settings.load_y_calibration;
        end
        
        function calibrate_load_z(obj, load)
            load.data = load.data * obj.set.settings.settings.load_z_calibration;
        end
    end
end
