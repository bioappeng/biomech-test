%find drop maxima of sensor data
function max_accz(collector, Set)
    max_acc = zeros(Set.num_drops, 1);
    for i=1:Set.num_drops
        drop = Set.drops(i).Value;
        max_acc(i, 1) = max(abs(drop.accz.data));
    end
    collector.add_field(max_acc, 'max_accz');
end
