function validate_data(Set)
    f = figure('Visible','off',...
              'Position',[100,100,800,600],...
              'MenuBar','none',...
              'Name','files selection');

    uipanel_drops = uipanel('Title', 'Drops',...
                            'Units', 'normalized',...
                            'Position', [.025, .025, .3, .95]);
    uipanel_controls = uipanel('Title', 'Controls',...
                               'Units', 'normalized',...
                               'Position', [.35, .075, .625, .9]);
    uipanel_signal_controls = uipanel('Title', '',...
                                      'Parent', uipanel_controls,...
                                      'Units', 'normalized',...
                                      'Position', [.05, .75, .9, .15]);
    drop_list = uicontrol('Style', 'listbox',...
                        'Parent', uipanel_drops,...
                        'Units', 'normalized',...
                        'Position', [.025, .01, .95, .98],...
                        'Callback', {@droplist_Callback},...
                        'Max', 1, 'Min', 1);
    signal_list = uicontrol('Style', 'popup',...
                            'Parent', uipanel_signal_controls,...
                            'Units', 'normalized',...
                            'String', 'string pot|linear/head pot|single axis load|x acceleration|y acceleration|z acceleration|y load|x load|z load',...
                            'Position', [.025, .575, .4, .25]);
                            'Callback', {@signal_list_callback}
    current_drop_description = uicontrol('Style', 'text',...
                               'Parent', uipanel_controls,...
                               'Units', 'normalized',...
                               'Position', [.025, .95, .23, .03],...
                               'String', 'Current Drop: ');
    current_drop_text = uicontrol('Style', 'text',...
                               'Parent', uipanel_controls,...
                               'Units', 'normalized',...
                               'Position', [.25, .95, .3, .03]);
    done_button = uicontrol('Style', 'pushbutton', 'String', 'Done',...
                            'Units', 'normalized',...
                            'Position', [.9, .015, .075, .05],...
                            'Callback',{@done_button_Callback});
     signal_flag_button = uicontrol('Style', 'pushbutton', 'String', 'Flag Current Signal',...
                            'Parent', uipanel_signal_controls,...
                            'Units', 'normalized',...
                            'Position', [.65, .05, .3, .35]);

    function droplist_Callback(source, eventdata)
        set(current_drop_text, 'String', drop_ids(get(drop_list, 'Value')))
        current_drop = Set.drops(get(drop_list, 'Value'))
    end

    function signal_list_callback(source, eventdata)
        selection = get(source, 'Value');
        if selection == 1;
            current_signal = current_drop.pot
        elseif selection == 2;
            current_signal = current_drop.pot2
        elseif selection == 3;
            current_signal = current_drop.load
        elseif selection == 4;
            current_signal = current_drop.accx
        elseif selection == 5;
            current_signal = current_drop.accy
        elseif selection == 6;
            current_signal = current_drop.accz
        elseif selection == 7;
            current_signal = current_drop.accz
        elseif selection == 8;
            current_signal = current_drop.loadx
        elseif selection == 9
            current_signal = current_drop.loady
        elseif selection == 10;
            current_signal = current_drop.loadz
        end
    end

    function signal_flag_button_Callback(source, eventdata)
        current_signal.flag();
    end

    drop_ids = Set.drop_ids();
    set(drop_list, 'String', drop_ids(:), 'Value', 1);
    set(f, 'Visible', 'on');
end
