function basic_gui

    f = figure('Visible','off',...
              'Position',[360,500,450,300],...
              'MenuBar','none',...
              'Name','files selection');
          
    %ui elements
    filepath = uicontrol('Style', 'pushbutton',...
                         'String', 'path to datafiles',...
                        'Position', [25,260,100,25],...
                        'Callback',{@filepath_Callback});
    headerlines = uicontrol('Style', 'edit',...
                            'String', '# header lines',...
                            'Position', [25,230,80,20],...
                            'Callback',{@headerlines_Callback});
    filelist = uicontrol('Style', 'listbox',...
                        'Position', [25,45,400,160]);
    submit_button = uicontrol('Style', 'pushbutton', 'String', 'Done',...
                            'Position', [390,10,50,25],...
                            'Callback',{@submit_button_Callback});

    %ui element callbacks
    function filepath_Callback(source,eventdata)
        dropSet_filepath = [uigetdir(pwd), '\'];
    end

    function headerlines_Callback(source,eventdata)
        dropSet_headerlines = 0; %get(source, 'Value');
    end

    function submit_button_Callback(source,eventdata)
%         index_selected = get(filelist, 'Value');
%         filelist_all = get(filelist, 'String');
%         filelist_selected = filelist_all(index_selected); %this probably won't work
        test = dropSet(dropSet_filepath, dropSet_headerlines, true)
    end

    %initialize dropSet data (defaults)
    %these should be read from settings file in release versions
    dropSet_filepath = [pwd, '\'];
    dropSet_headerlines = 0;

    set(f, 'Visible', 'on');
end