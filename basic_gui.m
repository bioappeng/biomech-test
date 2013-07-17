function basic_gui

    f = figure('Visible','off',...
              'Position',[360,500,450,300],...
              'MenuBar','none',...
              'Name','files selection');
          
    %ui elements
    filepath = uicontrol('Style', 'pushbutton',...
                         'String', 'Path to datafiles',...
                        'Position', [25,260,100,25],...
                        'Callback',{@filepath_Callback});
    headerlines = uicontrol('Style', 'popup',...
                            'String', '0|1|2|3|4',...
                            'Position', [120,230,80,20],...
                            'Callback',{@headerlines_Callback});
    header_lines_text = uicontrol('Style', 'text',...
                                  'Position', [25,230,80,17],...
                                  'String', 'Header Lines');
    filelist = uicontrol('Style', 'listbox',...
                        'Position', [25,45,400,160],...
                        'Callback', {@filelist_Callback},...
                        'Max', 10, 'Min', 1);
    submit_button = uicontrol('Style', 'pushbutton', 'String', 'Done',...
                            'Position', [390,10,50,25],...
                            'Callback',{@submit_button_Callback});

    %ui element callbacks
    function filepath_Callback(source,eventdata)
        dropSet_filepath = [uigetdir(pwd), '/'];
        dir_struct = dir(dropSet_filepath);
        [sorted_names, sorted_index] = sortrows({dir_struct.name}');
        set(filelist, 'String', sorted_names(3:end), 'Value', 1);
    end

    function headerlines_Callback(source,eventdata)
        dropSet_headerlines = get(source, 'Value') - 1;
    end

    function submit_button_Callback(source,eventdata)
        test = dropSet(dropSet_filepath, dropSet_headerlines, true, true)
        test.drops(:).Value % for debugging
    end

    function filelist_Callback(source, eventdata)

    end

    %initialize dropSet data (defaults)
    %these should be read from settings file in release versions
    dropSet_filepath = [pwd, '/'];
    dropSet_headerlines = 0;

    set(f, 'Visible', 'on');
end
