%all the calculations/math live here 


function [ load, xload, yload, zload, position, load_rate,...
           xload_rate, yload_rate, zload_rate, max_load,...
           max_vert_a, max_for_a, for_accel, vert_accel,...
           side_accel, max_xload, max_yload, max_zload ]...
= process_data_3axes(DropSet)

% Load (N), Displacement (m), accel in g
 
% where DropSet is an array of hoof tester data for a given data set (i.e. often
%                   representing a lap around the track)
% where folder1 = project folder containing subfolders, structure should
%                   follow 'folder1/', i.e. 'santa_anita/'
% where folder2 = subfolder to send results file, usually a date, i.e. '11_apr_15/'
% where foutput = file name for writing results, i.e.
%                   '11_apr_15_results.txt'


%folder1 = 'santa_anita/';
%folder2 = '11_apr_18/';
%foutput = 'junk';%'test_11_apr_20_results.txt';
%C = C18;

ifiles = size(DropSet,1);

for i = 1:ifiles

if isnan(DropSet{i,8}(:,1)) == 1
    DropSet{i,8}(:,1) = DropSet{i,7}(:,1);
    DropSet{i,7}(:,1) = DropSet{i,6}(:,1);
    DropSet{i,6}(:,1) = DropSet{i,5}(:,1);
    DropSet{i,5}(:,1) = DropSet{i,4}(:,1);
    DropSet{i,4}(:,1) = DropSet{i,3}(:,1);
    DropSet{i,3}(:,1) = DropSet{i,2}(:,1);
    DropSet{i,2}(:,1) = DropSet{i,1}(:,1);
    DropSet{i,1}(:,1) = NaN;
end
    
    %**********************************
    pos = DropSet{i,1}(:,1); % Read in the position data    
    tr_load = DropSet{i,2}(:,1); % Read in the load data
    xaccel = DropSet{i,8}(:,1); % Read in the accel x    
    yaccel = DropSet{i,6}(:,1); % Read in the accel y    
    zaccel = DropSet{i,7}(:,1); % Read in the accel z
    tr_xload = DropSet{i,4}(:,1); % Read in the load x    
    tr_yload = DropSet{i,3}(:,1); % Read in the load y    
    tr_zload = DropSet{i,5}(:,1); % Read in the load z

    %**********************************
    % Position data
    % Calibrate the position data, meters per volt (millimeters per millivolt)
    Cal_pos = 433.0; 
    pos_cal = Cal_pos * pos;
    % Define smallest element as zero
    posmin = min(pos_cal);
    pos_cal = pos_cal - posmin;
    % Check length of vectors
    s = size(pos);
    Length = s(:,1);

    %**********************************
    % Assign time Values
    Samp_rate = 1/2000;
    t = (0: Samp_rate: ((Length-1)*Samp_rate))';

    %**********************************
    % Single axis load data

    % Elliminate the zero drift on load cell
%    tr_load = remove_noise(tr_load,2000, [400], 0, 'low',1);
    % Calibrate the load data
    Amp = 1;
    Cal_load = (1000/0.2273); %1000 N (1 kN) = .2273 mV
    load_cal = tr_load * Amp * Cal_load;
    

    %[firstpeak,loc]=findpeaks(load_cal,'minpeakheight',.1*max_load(i,1),'npeaks',1);
    
    %**********************************
    % Triaxial load data
      tr_xload = remove_noise(tr_xload,2000, [400], 2, 'low',0);
      tr_yload = remove_noise(tr_yload,2000, [400], 2, 'low',0);
      tr_zload = remove_noise(tr_zload,2000, [400], 2, 'low',0);
        Cal_xload = 1;%.75; 
        Cal_yload = 1;%.75;
        Cal_zload = 1;%.75;
    xload_cal = tr_xload * Cal_xload;
    yload_cal = tr_yload * Cal_yload;
    zload_cal = tr_zload * Cal_zload;
    
    
    [max_xload(i,1),loc] = max (xload_cal);
    [max_yload(i,1),loc] = max (yload_cal);
    [max_zload(i,1),loc] = max (zload_cal);
    
%    [junk,loc] = min((xload_cal));
    
%    loc = 1000;
    
%    loc_p = loc-150; % location of the load peak.  This is the point from which to determine the time of impact.
    [max_load(i,1),loc1] = max(load_cal);
    
    while pos_cal(loc) < 0; %zload_cal(loc) > 50 %load_cal(loc_p)*0.25 || load_rate(loc) > 0
        loc = loc - 1;
    end
    
    loc_start = loc-50;
    loc_end = loc_start + 145;
    
    ld_rate = diff(smooth(load_cal(loc_start:loc_end+1)))./diff(t(loc_start:loc_end+1));
    max_load_rate(i,1) = max (ld_rate);
        
    x_ld_rate = diff(smooth(xload_cal(loc_start:loc_end+1)))./diff(t(loc_start:loc_end+1));
    x_max_load_rate(i,1) = max (x_ld_rate);
    
    y_ld_rate = diff(smooth(yload_cal(loc_start:loc_end+1)))./diff(t(loc_start:loc_end+1));
    y_max_load_rate(i,1) = max (y_ld_rate);
    
    z_ld_rate = diff(smooth(zload_cal(loc_start:loc_end+1)))./diff(t(loc_start:loc_end+1));
    z_max_load_rate(i,1) = max (z_ld_rate);
   
    
    %**********************************
    % Acceleration data %in g
    % Remove EM noise
    
    % Calibrate
    xaccel = -xaccel*(1/0.010);
%    xaccel = remove_noise(xaccel, 2000, [25], 10, 'high',0);
    
    yaccel = yaccel*(1/0.010);
%    yaccel = remove_noise(yaccel, 2000, [25], 10, 'high',0);

    zaccel = zaccel*(1/0.010);
%    zaccel = remove_noise(zaccel, 2000, [25], 10, 'high',0);


    
    %**********************************
    % Preallocate
    
    load(i,1:1000) = NaN;
    xload(i,1:1000) = NaN;
    yload(i,1:1000) = NaN;
    zload(i,1:1000) = NaN;
    load_rate(i,1:1000) = NaN;
    xload_rate(i,1:1000) = NaN;
    yload_rate(i,1:1000) = NaN;
    zload_rate(i,1:1000) = NaN;
    for_accel(i,1:1000) = NaN;
    vert_accel(i,1:1000) = NaN;
    side_accel(i,1:1000) = NaN;
    a = loc_end - loc_start +1; % column length for windowed data, window based off peak on load curve

    
    load(i,1:a) = load_cal(loc_start:loc_end,1)';
        xload(i,1:a) = xload_cal(loc_start:loc_end,1)';
            yload(i,1:a) = yload_cal(loc_start:loc_end,1)';
                zload(i,1:a) = zload_cal(loc_start:loc_end,1)';
    load_rate(i,1:a) = ld_rate';
    xload_rate(i,1:a) = x_ld_rate';
    yload_rate(i,1:a) = y_ld_rate';
    zload_rate(i,1:a) = z_ld_rate';
    for_accel(i,1:a) = zaccel(loc_start:loc_end,1)';
    max_for_a(i,:) = max (for_accel(i,1:a));
    
    vert_accel(i,1:a) = xaccel(loc_start:loc_end,1)';
    max_vert_a(i,:) = max (vert_accel(i,1:a));
    
    side_accel(i,1:a) = yaccel(loc_start:loc_end,1)';
    
    
     %  [junk,junk_loc] = max(load(i,1:a));
     
    %**********************************
    position(i,1:1000) = NaN;
    position(i,1:a) = pos_cal(loc_start:loc_end)-pos_cal(loc_start);
    
clear loc_end loc_start loc a
    %**********************************

    
end

% fout = [path, foutput];
% fid = fopen(fout,'w');
% fprintf('\nMax Load N    ,  Max Vert. Accel Gs, Max Forward Accel Gs');
% fprintf(fid,'\r\nMax Load N    ,  Max Vert. Accel Gs, Max Forward Accel Gs');
% for i=1:ifiles
%     fprintf('\n%f    %f        %f   %f  ',max_load(i),max_vert_a(i), max_for_a(i) );
%     fprintf(fid,'\r\n%f,    %f,        %f,   ',max_load(i),max_vert_a(i), max_for_a(i) );
% end
% fclose(fid)
