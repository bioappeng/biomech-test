

% These are the process_data inputs

% Data organization example:
% C = {C_14_4h  C_14_6h  C_16_4h  C_16_6h  C_18_4h  C_18_6h  C_14_4s  C_14_6s  C_16_4s  C_16_6s  C_18_4s  C_18_6s};
% labels(:,1) = {'Harrow'; 'Harrow' ; 'Harrow' ; 'Harrow' ; 'Harrow' ; 'Harrow';  'Seal'  ;'Seal' ; 'Seal' ; 'Seal' ; 'Seal' ; 'Seal'};
% labels(:,2) = { '14%'; '14%' ; '16%';  '16%' ; '18%' ; '18%';  '14%' ; '14%' ; '16%' ; '16%' ; '18%' ; '18%'};
% labels(:,3) = {'10.16cm'; '15.24cm' ; '10.16cm' ; '15.24cm' ; '10.16cm' ; '15.24cm' ; '10.16cm'  ;'15.24cm' ; '10.16cm' ; '15.24cm' ; '10.16cm'  ;'15.24cm'};

% -----------------------------
folder1 = 'Matlab_horses/horse_work/';
folder2 = 'results/'; %This is not currently used.  It is set up for saving output files

% -----------------------------
% Preallocate

z = size(data,2);

for j = 1:z; % This loop sets up to find the max number of drops for each track (or experimental set)
   n_list(j) = size(data{1,j},1);
end
n = max(n_list); % Use the max number of drops for the largest set to preallocate

%n = size(data{1,1},1); %sample repetitions

load = cell(1,z);
xload = cell(1,z);
yload = cell(1,z);
zload = cell(1,z);
position = cell(1,z);

%max_load_rate = nan(n,z);
max_load = nan(n,z);
max_vert_a = nan(n,z);
max_for_a = nan(n,z);
max_xload = nan(n,z);
max_yload = nan(n,z);
max_zload = nan(n,z);


for i = 1:size(data,2) % representing a track or experimental set, i.e. harrow, 14%, 10.16cm (see labels)

    C = data{1,i};
    
    if isempty(C) == 1
        continue
    else
        

% ------------------------------

[load{1,i}, xload{1,i}, yload{1,i}, zload{1,i}, position{1,i},load_rate{1,i},...
    xload_rate{1,i},yload_rate{1,i},zload_rate{1,i},max_load(1:size(C,1),i),max_vert_a(1:size(C,1),i), max_for_a(1:size(C,1),i), for_accel{1,i},vert_accel{1,i},side_accel{1,i}...
    max_xload(1:size(C,1),i), max_yload(1:size(C,1),i), max_zload(1:size(C,1),i)]...
    = process_data_3axes_20130613(C, folder1, folder2);
 
 
clear C
    end
end

clear folder1 folder2 depth i j z n n_list