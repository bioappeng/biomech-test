%{
second 'user_pane'

most functionally complex user step.

allows the user to select and view each of the signals in each of the drops
in the set.

allow the user to flag and unflag drops that appear to be erroneous

allows the user to window the data manually.

%}

function validate_data(Set)
    f = figure('Visible','off',...
              'Position',[100,100,800,600],...
              'MenuBar','none',...
              'Name','files selection');

    uipanel_drops = uipanel('Title', 'Drops',...
                            'Units', 'normalized',...
                            'Position', [.025, .025, .2, .95]);
    uipanel_controls = uipanel('Title', 'Controls',...
                               'Units', 'normalized',...
                               'Position', [.25, .075, .725, .95]);
    uipanel_signal_controls = uipanel('Title', '',...
                                      'Parent', uipanel_controls,...
                                      'Units', 'normalized',...
                                      'Position', [.05, .75, .85, .15]);
    signal_plot = axes('Units', 'normalized',...
                       'Parent', uipanel_controls,...
                       'Position', [.1, .15, .85, .55]);
    drop_list = uicontrol('Style', 'listbox',...
                        'Parent', uipanel_drops,...
                        'Units', 'normalized',...
                        'Position', [.025, .01, .95, .98],...
                        'Callback', {@droplist_Callback},...
                        'Max', 1, 'Min', 1);
    signal_list = uicontrol('Style', 'popup',...
                            'Parent', uipanel_signal_controls,...
                            'Units', 'normalized',...
                            'String', 'string pot|linear/head pot|single axis load|x acceleration|y acceleration|z acceleration|x load|y load|z load',...
                            'Position', [.025, .575, .4, .25],...
                            'Callback', {@signal_list_callback});
    current_drop_description = uicontrol('Style', 'text',...
                               'Parent', uipanel_controls,...
                               'Units', 'normalized',...
                               'Position', [.025, .93, .23, .03],...
                               'String', 'Current Drop: ');
    current_drop_text = uicontrol('Style', 'text',...
                               'Parent', uipanel_controls,...
                               'Units', 'normalized',...
                               'Position', [.225, .93, .2, .03]);
    flag_current_drop_button = uicontrol('Style', 'pushbutton',...
                                         'Parent', uipanel_controls,...
                                         'String', 'Flag Drop',... 
                                         'Units', 'normalized',...
                                         'Position', [.45, .93, .15, .04],...
                                         'Callback', {@flag_current_drop_button_callback});
    drop_flag_text = uicontrol('Style', 'text',...
                                  'Parent', uipanel_controls,...
                                  'Units', 'normalized',...
                                  'Position', [.6, .93, .3, .03]);
    done_button = uicontrol('Style', 'pushbutton', 'String', 'Done',...
                            'Units', 'normalized',...
                            'Position', [.9, .015, .075, .05],...
                            'Callback',{@done_button_Callback});
    signal_view_next_button = uicontrol('Style', 'pushbutton',...
                            'String', 'Next Signal',...
                            'Parent', uipanel_signal_controls,...
                            'Units', 'normalized',...
                            'Position', [.75, .5, .2, .275],...
                            'Callback',{@signal_view_next_button_Callback});
    signal_view_previous_button = uicontrol('Style', 'pushbutton',...
                            'String', 'Prev Signal',...
                            'Parent', uipanel_signal_controls,...
                            'Units', 'normalized',...
                            'Position', [.5, .5, .2, .275],...
                            'Callback',{@signal_view_previous_button_Callback});
   %preprocess data 
    preproc = preprocessor();
    preproc.preprocess_signals(Set);

    %Configure and plot data for use in slider definition
    current_drop = Set.drops(1).Value;
    set_drop_flag_text();
    current_signal = current_drop.signals('pot');
    signal = current_signal.data;
    time = current_drop.signals('time').data;
    drop_ids = Set.drop_ids();
    set(drop_list, 'String', drop_ids(:), 'Value', 1);
    set(current_drop_text, 'String', current_drop.id);
    set(f, 'Visible', 'on');
    
    %Define slider values with respect to time-series data
    min_slider = uicontrol('Style', 'slider',...
                            'String', 'Window Minimum',...
                            'Parent', uipanel_controls,...
                            'Units', 'normalized',...
                            'Position', [0.05, 0.05, 0.9, 0.05],...
                            'Min', 0, 'Max', max(time), 'SliderStep', [0.001, 0.01],...
                            'Callback', {@min_slider_callback});
    max_slider = uicontrol('Style', 'slider',...
                            'String', 'Window Maximum',...
                            'Parent', uipanel_controls,...
                            'Units', 'normalized',...
                            'Position', [0.05, 0.0, 0.9, 0.05],...
                            'Min', 0, 'Max', max(time), 'SliderStep', [0.001, 0.01],...
                            'Value', max(time),...
                            'Callback', {@max_slider_callback});
                        
    function droplist_Callback(source, eventdata)
        set(current_drop_text, 'String', drop_ids(get(drop_list, 'Value')))
        current_drop = Set.drops(get(drop_list, 'Value')).Value;
        set_drop_flag_text()
        signal_list_callback(signal_list, eventdata);
    end

    function flag_current_drop_button_callback(source, eventdata)
        current_drop.change_flagged();
        set_drop_flag_text()
    end

    function set_drop_flag_text()
        if current_drop.flagged
            set(drop_flag_text, 'String', 'Flagged')
        else
            set(drop_flag_text, 'String', 'Not Flagged')
        end
    end


    function signal_list_callback(source, eventdata)
        selection = get(source, 'Value');
        if selection == 1;
            current_signal = current_drop.signals('pot');
        elseif selection == 2;
            current_signal = current_drop.signals('pot2');
        elseif selection == 3;
            current_signal = current_drop.signals('load');
        elseif selection == 4;
            current_signal = current_drop.signals('accx');
        elseif selection == 5;
            current_signal = current_drop.signals('accy');
        elseif selection == 6;
            current_signal = current_drop.signals('accz');
        elseif selection == 7;
            current_signal = current_drop.signals('loadx');
        elseif selection == 8
            current_signal = current_drop.signals('loady');
        elseif selection == 9;
            current_signal = current_drop.signals('loadz');
        end
        plot_data();
    end

    function signal_view_next_button_Callback(source, eventdata)
        current_value = get(signal_list, 'Value');
        if current_value < 9
            set(signal_list, 'Value', current_value + 1);
        end
        signal_list_callback(signal_list, 'nothing');
        plot_data();
    end

    function plot_data()
        signal = current_signal.data;
        if signal == false
            cla(signal_plot);
        else
            time = current_drop.signals('time').data;
            plot(signal_plot, time, signal);
            
            
            min_sv = get(min_slider, 'Value');
            max_sv = get(max_slider, 'Value');
            yLim = get(signal_plot, 'YLim');
            hold on;
            min_l = plot(signal_plot, [min_sv min_sv], yLim,...
                'Tag', 'min_l',...
                'LineWidth', 1,...
                'Color', 'g');
            max_l = plot(signal_plot, [max_sv max_sv], yLim,...
                'Tag', 'max_l',...
                'LineWidth', 1,...
                'Color', 'r');
            hold off
        end
    end

    function signal_view_previous_button_Callback(source, eventdata)
        current_value = get(signal_list, 'Value');
        if current_value > 1
            set(signal_list, 'Value', current_value - 1);
        end
        signal_list_callback(signal_list, 'nothing');
        plot_data();
    end

    function done_button_Callback(source, eventdata)
        time = current_drop.signals('time').data;
        min_window = get(min_slider, 'Value');
        max_window = get(max_slider, 'Value');
        [c min_i] = min(abs(time-min_window));
        [c max_i] = min(abs(time-max_window));
        
        if max_i < min_i
            tmp = max_i;
            max_i = min_i;
            min_i = tmp;
        end
        process_data(Set, min_i, max_i);
        delete(get(source, 'parent'));
    end

	function min_slider_callback(hObject, eventdata)
	
		value = get(hObject, 'Value');
		yLim = get(signal_plot, 'YLim');
		x_value = value;
		min_l = findobj(gcf, 'Tag', 'min_l');
		set(min_l, 'XData', [x_value x_value], 'YData', yLim);
		
	end
	
	function max_slider_callback(hObject, eventdata)

		value = get(hObject, 'Value');
		yLim = get(signal_plot, 'YLim');
		x_value = value;
		max_l = findobj(gcf, 'Tag', 'max_l');
		set(max_l, 'XData', [x_value x_value], 'YData', yLim);
    end
    
    %Draw first set of data
    plot_data();
end
