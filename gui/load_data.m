%{
first 'user pane'

requires the user to select a settings file.

the user selects the location of the folder containing the ascii drop data.
once selected, the contents of this location is shown in the file-list pane.

clicking the 'done' button closes this pane and opens the 'validate_data' pane
%}

function load_data
    f = figure('Visible','off',...
              'Position',[100,200,700,500],...
              'MenuBar','none',...
              'Name','files selection');
          
    %ui elements
    uipanel_files = uipanel('Units', 'normalized',...
                            'Title', 'Read In Data',...
                               'Position', [.05, .1, .90, .85]);
    settings_path_button = uicontrol('Style','pushbutton',...
                        'Parent', uipanel_files,...
                        'Units', 'normalized',...
                        'String', 'Settings File',...
                        'Position', [0.825,0.9,0.15,0.055],...
                        'Callback', {@settings_path_callback});
    filepath_button = uicontrol('Style', 'pushbutton',...
                        'Parent', uipanel_files,...
                        'Units', 'normalized',...
                         'String', 'Data Location',...
                        'Position', [.025, .9, .16, .055],...
                        'Callback',{@filepath_Callback});
    filelist = uicontrol('Style', 'listbox',...
                        'Parent', uipanel_files,...
                        'Units', 'normalized',...
                        'Position', [.025, .05, .95, .8],...
                        'Callback', {@filelist_Callback},...
                        'Max', 10, 'Min', 1);
    done_button = uicontrol('Style', 'pushbutton', 'String', 'Done',...
                            'Units', 'normalized',...
                            'Position', [.9, .025, .075, .05],...
                            'Callback',{@done_button_Callback});

    %ui element callbacks
    function filepath_Callback(source, eventdata)
        drop_set_filepath = [uigetdir(pwd), '/'];
        dir_struct = dir(drop_set_filepath);
        [sorted_names, sorted_index] = sortrows({dir_struct.name}');
        set(filelist, 'String', sorted_names(3:end), 'Value', 1);
    end

    function filelist_Callback(source, eventdata)
    end

    function done_button_Callback(source, eventdata)
        if have_settings
            drops = assembler.assemble(drop_set_filepath);
            Set = drop_set(drops);
            Set.set_settings(settings);
            validate_data(Set);
        else
                warndlg('No YAML settings file was specified', 'No Setting File');
        end

    end

    function settings_path_callback(source, eventdata)
        [file_name, path_name] = uigetfile('*.*', 'Choose settings file');
        setting_parser = settings_parser(fullfile(path_name, file_name));
        settings = setting_parser.parse_settings();
        assembler = drop_assembler(settings);
        have_settings = true;
    end
    %initialize drop_set data (defaults)
    %these should be read from settings file in release versions
    drop_set_filepath = [pwd, '/'];
    have_settings = false;
    assembler = NaN;
    settings = NaN;
    set(f, 'Visible', 'on');
end
