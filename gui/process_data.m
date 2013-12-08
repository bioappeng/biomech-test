function process_data(Set, window_start, window_end);
    f = figure('Visible','off',...
              'Position',[100,200,350,500],...
              'MenuBar','none',...
              'Name','data processing');

    %ui elements
    uipanel_filters = uipanel('Title', 'Filters',...
                              'Units', 'normalized',...
                              'Position', [.05, .80, .90, .15]);
    uipanel_processes = uipanel('Title', 'Processes',...
                              'Units', 'normalized',...
                              'Position', [.05, .1, .90, .65]);
    done_button = uicontrol('Style', 'pushbutton', 'String', 'Done',...
                            'Units', 'normalized',...
                            'Position', [.8, .025, .15, .05],...
                            'Callback',{@done_button_Callback});
    max_acc_x_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max acceleration x',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .9, .6, .05],...
                                   'Callback', {@max_accx_Callback});
    max_acc_y_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max acceleration y',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .8, .6, .05],...
                                   'Callback', {@max_accy_Callback});
    max_acc_z_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max acceleration z',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .7, .6, .05],...
                                   'Callback', {@max_accz_Callback});
    max_load_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max single-axis load',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .6, .6, .05],...
                                   'Callback', {@max_load_Callback});
    max_loadx_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max load x',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .5, .6, .05],...
                                   'Callback', {@max_loadx_Callback});
    max_loady_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max load y',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .4, .6, .05],...
                                   'Callback', {@max_loady_Callback});
    max_loadz_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max load z',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .3, .6, .05],...
                                   'Callback', {@max_loadz_Callback});


    function max_accx_Callback(source,eventdata)
        max_accx.to_run = get(source, 'Value');
    end

    function max_accy_Callback(source,eventdata)
        max_accy.to_run = get(source, 'Value');
    end

    function max_accz_Callback(source,eventdata)
        max_accz.to_run = get(source, 'Value');
    end

    function max_load_Callback(source,eventdata)
        max_load.to_run = get(source, 'Value');
    end

    function max_loadx_Callback(source,eventdata)
        max_loadx.to_run = get(source, 'Value');
    end

    function max_loady_Callback(source,eventdata)
        max_loady.to_run = get(source, 'Value');
    end

    function max_loadz_Callback(source,eventdata)
        max_loadz.to_run = get(source, 'Value');
    end

    function done_button_Callback(source, eventdata)
        
        %Pull the drop id's and add them to dump file
        id_list = cell(Set.num_drops, 1);
        for i = 1:Set.num_drops
            drop = Set.get_drop(i);
            id_list{i, 1} = drop.get_id();
        end
        collector.add_field(id_list, 'Name');
        
        %Run processes on all signals
        preproc.preprocess_signals(Set, window_start, window_end);
        for i=1:length(processes)
            process = processes{i};
            if process.to_run
                proc.apply_process(collector, Set, process)
            end
        end
        
        %Push the processed data from collector to the dump file object
        %Output to file specified
        %TODO: Error check for open file
        [file, path] = uiputfile('*.txt');
        
        if isequal(file, 0) || isequal(path, 0)
            %User pressed cancel
        else
            filepath = fullfile(path, file);
            dumper = data_dumper();
            dumper.grab_data(collector)
            if dumper.dump(filepath);
                delete(get(source, 'parent'));
            else
                %File was open or problem exist
                errordlg('The file specified could not be opened, check if the file is open in another application and try again', 'File could not be opened');
            end
        end
    end

    %Specify processes to run on the drop set
    %TODO:  Clean up and set dynamically
    max_accx = process_max_accx(Set);
    max_accy = process_max_accy(Set);
    max_accz = process_max_accz(Set);
    max_load = process_max_load(Set);
    max_loadx = process_max_loadx(Set);
    max_loady = process_max_loady(Set);
    max_loadz = process_max_loadz(Set);
    velocity_validation = process_velocity_validation(Set);
    processes = {max_accx, max_accy, max_accz, max_loadx, max_loady, max_loadz, max_load, velocity_validation};
    collector = calculation_collector();
    proc = processor();
    preproc = preprocessor();

    filepath = [];

    set(f, 'Visible', 'on');
end