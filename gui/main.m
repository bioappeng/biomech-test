%{
entry point for the program.

sorts out the required paths for runtime and calls the first 'user pane'
%}

addpath('../lib/framework/');
addpath('../lib/resources/');
addpath('../lib/resources/yamlmatlab/');
addpath('../lib/framework/subprocesses');

load_data()
