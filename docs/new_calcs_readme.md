# Documentation for Processes (calculations):

The various calculations to be run on the data are defined as "processes".
Each calculation has its own process, defined in "lib/framework/subprocesses".
This process is a class that defines the conditions under which the calculation
can be done, and the calculation itself.

## Writing a new process class

The below code is a simple process (process_max_accx) that finds the peak of
the x acceleration.

    classdef process_max_accx < handle
        properties
            to_run
        end

        methods
            function obj = process_max_accx(set)
                obj.to_run = process_max_accx.assess_to_run(set);
            end
        end

        methods (Static)
            function to_run = assess_to_run(Set)
                if Set.get_drop(1).signals('accx').data == false;
                    to_run = false;
                else
                to_run = true;
                end
            end

            function run(collector, Set)
                for i=1:Set.num_drops
                    drop = Set.get_drop(i);
                    max_acc(i, 1) = max((drop.signals('accx').data(drop.window_start:drop.window_end)));
                end
                collector.add_field(max_acc, 'max_accx');
            end
        end
    end

Each process class must follow the same basic structure as this example
process. A skeleton process is shown below.


    classdef {{process name}} < handle
        properties
            to_run
        end

        methods
            function obj = {{process name}}(set)
                obj.to_run = {{process name}}.assess_to_run(set);
            end
        end

        methods (Static)
            function to_run = assess_to_run(set)
                {{check if the data needed to run exists,
                returning true if they are met and false otherwise}}
            end

            function run(collector, set)
                {{iterate over the drops in the drop set, and for each
                    - do the required calculation on the signal
                    - if you want to obey the user's manual windowing
                    (which you usually do) only do the calculation on the
                    data(drop.window_start:drop.window_end)
                    - append the result of that calculation to a 1xn array
                }}
                collector.add_field({{calculated value array}}, {{name of calculation}});
            end
        end
    end

## Adding a new calculation to the GUI 

After having written a new process class, you want to add that calculation to
the GUI. This involves a few modifications to gui/process_data.m

First, you must add a new checkbox to the GUI. Define both the checkbox object
and it's callback.

Example checkbox object:

    {{calculation name}}_checkbox = uicontrol('Style', 'checkbox',...
                                    'Parent', uipanel_processes,...
                                    'String', {{calculation description}},...
                                    'Units', 'normalized',...
                                    'Value', 1,...
                                    'Position', [.05, .9, .6, .05],...
                                    'Callback', {@{{calculation name}}_callback});

Example checkbox callback:

    function {{calculation name}}_callback(source,eventdata)
        {{calculation name}}.to_run = get(source, 'Value');
    end

You must also create an object of that process class, and add it to the array
of calculations to run. (see comments in gui/process_data.m)
