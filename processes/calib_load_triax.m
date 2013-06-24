%find drop maxima of sensor data
function calc_maxima(Set, p)
    for i=1:Set.num_drops
        Set.drops(i).Value.max_load = max(abs(Set.load));
        Set.drops(i).Value.max_accx = max(abs(Set.accx));
        Set.drops(i).Value.max_accy = max(abs(Set.accy));
        Set.drops(i).Value.max_accz = max(abs(Set.accz));

        if Set.three_axis_load
            Set.drops(i).Value.max_loadx = max(abs(Set.loadx));
            Set.drops(i).Value.max_loady = max(abs(Set.loady));
            Set.drops(i).Value.max_loadz = max(abs(Set.loadz));
        end
    end
end