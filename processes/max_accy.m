%find drop maxima of sensor data
function max_accy(Set, p)
    field_number = p.add_field('max_accy');
    for i=1:Set.num_drops
        drop = Set.drops(i).Value;
        p.add_value(max(abs(drop.accy)), field_number)
    end
end
