function process_data(Set);
    f = figure('Visible','off',...
              'Position',[100,200,700,500],...
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
                            'Position', [.9, .025, .075, .05],...
                            'Callback',{@done_button_Callback});
    acc_max_x_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max acceleration x',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .9, .3, .05],...
                                   'Callback', {@max_accx_Callback});
    acc_max_y_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max acceleration y',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .8, .3, .05],...
                                   'Callback', {@max_accy_Callback});
    acc_max_z_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max acceleration z',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .7, .3, .05],...
                                   'Callback', {@max_accz_Callback});
    acc_load_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max single-axis load',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .6, .3, .05],...
                                   'Callback', {@max_load_Callback});
    acc_loadx_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max load x',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .5, .3, .05],...
                                   'Callback', {@max_loadx_Callback});
    acc_loady_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max load y',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .4, .3, .05],...
                                   'Callback', {@max_loady_Callback});
    acc_loadz_checkbox = uicontrol('Style', 'checkbox',...
                                   'Parent', uipanel_processes,...
                                   'String', 'max load z',...
                                   'Units', 'normalized',...
                                   'Value', 1,...
                                   'Position', [.05, .3, .3, .05],...
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
        preproc.preprocess_signals(Set);
        for i=1:length(processes)
            process = processes{i};
            if process.to_run
                proc.apply_process(collector, Set, process)
            end
        end

        [file, path] = uiputfile('*.txt')
        filepath = fullfile(path,file);
        dumper = data_dumper();
        dumper.grab_data(collector)
        dumper.dump(filepath);
        delete(get(source, 'parent'));
    end

    max_accx = process_max_accx(Set);
    max_accy = process_max_accy(Set);
    max_accz = process_max_accz(Set);
    max_load = process_max_load(Set);
    max_loadx = process_max_loadx(Set);
    max_loady = process_max_loady(Set);
    max_loadz = process_max_loadz(Set);
    velocity_validation = process_velocity_validation(Set);
    max_accx.to_run = true;
    max_accy.to_run = true;
    max_accz.to_run = true;
    max_loadx.to_run = true;
    max_loady.to_run = true;
    max_loadz.to_run = true;
    max_load.to_run = true;
    velocity_validation.to_run = true;
    processes = {max_accx, max_accy, max_accz, max_loadx, max_loady, max_loadz, max_load, velocity_validation};
    collector = calculation_collector();
    proc = processor();
    preproc = preprocessor();

    filepath = [];

    set(f, 'Visible', 'on');
end
