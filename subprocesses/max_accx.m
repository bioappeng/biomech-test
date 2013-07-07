%find drop maxima of sensor data
function max_accx(collector, Set)
    max_acc = zeros(Set.num_drops, 1);
    for i=1:Set.num_drops
        drop = Set.drops(i).Value;
        max_acc(i, 1) = max(abs(drop.accx));
    end
    collector.add_data(max_acc, 'max_accx');
end
