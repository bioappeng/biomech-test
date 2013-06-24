%find drop maxima of sensor data
function max_accz(Set, p)
    field_number = p.add_field('max_accz');
    for i=1:Set.num_drops
        drop = Set.drops(i).Value;
        p.add_value(max(abs(drop.accz)), field_number)
    end
end
