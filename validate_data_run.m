function validate_data_run
    Set = drop_set('test/data/small_data/ascii/', 0, true, true);
    validate_data(Set);
end
