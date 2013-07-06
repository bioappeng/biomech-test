%find drop maxima of sensor data
function max_accx(Set, p)
    field_number = p.add_field('max_accx');
    for i=1:Set.num_drops
        drop = Set.drops(i).Value;
        p.add_value(max(abs(drop.accx)), field_number)
    end
end
