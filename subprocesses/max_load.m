%find drop maxima of sensor data
function max_load(collector, Set, p)
    field_number = collector.add_field('max_load');
    for i=1:Set.num_drops
        drop = Set.drops(i).Value;
        collector.add_value(max(abs(drop.load)), field_number);
    end
end
