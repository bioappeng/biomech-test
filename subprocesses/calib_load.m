%single-axis load calibration
function calib_load(Set, p)
        load_calib_value = (1000/0.2273); %1000 N (1 kN) = .2273 mV
    amp = 1;
    for i=1:Set.num_drops
        Set.drops(i).Value.load = Set.drops(i).Value.load * amp * Set.load_calib_value;
    end
end
