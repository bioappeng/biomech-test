function save_data_run
    Set = drop_set('test/data/small_data/ascii/', 0, true, true);
    save_data(Set, calculation_collector());
end
