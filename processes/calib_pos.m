function calib_pos(Set)
    for i=1:Set.num_drops
        Set.drops(i).Value.pos = Set.drops(i).Value.pos * Set.pos_calib_value;
        drop_min = min(Set.drops(i).Value.pos);
        Set.drops(i).Value.pos = Set.drops(i).Value.pos - drop_min;
    end 
end