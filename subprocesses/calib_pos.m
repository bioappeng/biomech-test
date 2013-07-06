function calib_pos(Set, p)
        pos_calib_value = 433.0; %needs a better variable name -- is a multiplier?
    for i=1:Set.num_drops
        Set.drops(i).Value.pos = Set.drops(i).Value.pos * Set.pos_calib_value;
        drop_min = min(Set.drops(i).Value.pos);
        Set.drops(i).Value.pos = Set.drops(i).Value.pos - drop_min;
    end 
end
