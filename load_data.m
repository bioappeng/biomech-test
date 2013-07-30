function load_data
    addpath('lib/framework/');
    
    f = figure('Visible','off',...
              'Position',[100,200,700,500],...
              'MenuBar','none',...
              'Name','files selection');
          
    %ui elements
    uipanel_settings = uipanel('Title', 'Basic Settings',...
                               'Units', 'normalized',...
                               'Position', [.05, .80, .90, .15]);
    uipanel_files = uipanel('Units', 'normalized',...
                               'Position', [.05, .1, .90, .65]);
    filetype_text = uicontrol('Style', 'text',...
                              'Parent', uipanel_settings,...
                                  'Units', 'normalized',...
                                  'Position', [.1, .5, .1, .3],...
                                  'String', 'File Type');
    filetype = uicontrol('Style', 'popup',...
                            'Parent', uipanel_settings,...
                            'Units', 'normalized',...
                            'String', 'text|mat',...
                            'Position', [.225, .55, .1, .3],...
                            'Callback',{@filetype_Callback});
    header_lines_text = uicontrol('Style', 'text',...
                            'Parent', uipanel_settings,...
                                  'Units', 'normalized',...
                                  'Position', [.375, .5, .15, .3],...
                                  'String', 'Header Lines');
    headerlines_edit_box = uicontrol('Style', 'edit',...
                            'Parent', uipanel_settings,...
                            'Units', 'normalized',...
                            'String', '0',...
                            'Position', [.53, .5, .03, .3],...
                            'Callback',{@headerlines_Callback});
    triax_load_check = uicontrol('Style', 'checkbox',...
                                  'Units', 'normalized',...
                                  'String', '  Triaxial Load',...
                                  'Parent', uipanel_settings,...
                                  'Position', [.64, .5, .2, .3],...
                                  'Max', 1,...
                                  'Min', 0,...
                                  'Value', 1,...
                                  'Callback', {@triax_load_check_Callback});
    filepath_button = uicontrol('Style', 'pushbutton',...
                        'Parent', uipanel_files,...
                        'Units', 'normalized',...
                         'String', 'data location',...
                        'Position', [.025, .875, .15, .075],...
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
        set(filelist, 'String', sorted_names(:), 'Value', 1);
    end

    function headerlines_Callback(source, eventdata)
        drop_set_headerlines = str2num(get(source, 'String'));
    end

    function filelist_Callback(source, eventdata)
    end

    function triax_load_check_Callback(source, eventdata)
        drop_set_istriaxload = get(source, 'Value');
    end

    function filetype_Callback(source, eventdata)
        if get(source, 'Value') == 1
            drop_set_isascii = true;
        else
            drop_set_isascii = false;
        end
    end

    function done_button_Callback(source, eventdata)
        Set = drop_set(drop_set_filepath, drop_set_headerlines, drop_set_istriaxload, drop_set_isascii);
        validate_data(Set);
        delete(get(source, 'parent'));
    end

    %initialize drop_set data (defaults)
    %these should be read from settings file in release versions
    drop_set_filepath = [pwd, '/'];
    drop_set_headerlines = 0;
    drop_set_isascii = true;
    drop_set_istriaxload = true;

    set(f, 'Visible', 'on');
end
