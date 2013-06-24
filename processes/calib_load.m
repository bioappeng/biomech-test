%single-axis load calibration
function calib_load(Set)
    amp = 1; %don't know what this is or where it should be going. does it change?
    for i=1:Set.num_drops
        Set.drops(i).Value.load = Set.drops(i).Value.load * amp * Set.load_calib_value;
    end
end