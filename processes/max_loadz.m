%find drop maxima of sensor data
function max_loadz(Set, p)
    if Set.three_axis_load:
        field_number = p.add_field('max_loadz');
        for i=1:Set.num_drops
            drop = Set.drops(i).Value;
            p.add_value(max(abs(drop.loadz)), field_number)
        end
    else
        error('No three axis load cell data in dropSet');
end
