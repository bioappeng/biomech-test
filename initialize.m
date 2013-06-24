%initialization script -- this should be replaced by setup in the GUI

clear;
addpath('processes');

%create function handles
calcs = {@max_load, @max_accx, @max_accy, @max_accz, @max_loadx, @max_loady, @max_loadz}
calibs = {@calib_load, @calib_load_triax, @calib_pos}

Set = dropSet('test\data\', 0, true)
proc = processor()