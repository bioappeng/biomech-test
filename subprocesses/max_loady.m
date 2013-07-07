%find drop maxima of sensor data
function max_loady(Set, p)
    if Set.three_axis_load:
        field_number = p.add_field('max_loady');
        for i=1:Set.num_drops
            drop = Set.drops(i).Value;
            p.add_value(max(abs(drop.loady)), field_number)
        end
    else
        error('No three axis load cell data in dropSet');
end
