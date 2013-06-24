%find drop maxima of sensor data
function max_load(Set, p)
    field_number = p.add_field('max_load');
    for i=1:Set.num_drops
        drop = Set.drops(i).Value;
        p.add_value(max(abs(drop.load)), field_number);
    end
end
