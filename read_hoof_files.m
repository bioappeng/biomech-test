 function [C] = read_hoof_files(folder_path, files, num_headerlines, varin)

% where folder1 = project folder containing subfolders, structure should
%                   follow 'folder1/', i.e. 'santa_anita/'
% where folder2 = subfolder containing the .txt files for given experiment
%                   parameters, usually a date, i.e. '11_apr_15/'
% where files = indicators for which files to include, i.e. '11*.txt' or
%                   'TT*.txt'
% where num_headerlines = number of headerlines to remove
% where varin = numbers of input variables (5 or 8 see below)

% where C is an nx5 array
% C{n,1} is position data for drop n
% C{n,2} is load data for drop n
% C{n,3} is accel x data for drop n
% C{n,4} is accel y data for drop n
% C{n,5} is accel z data for drop n

% or where C is an nx8 array
% C{n,1} is position data for drop n
% C{n,2} is single axis load data for drop n
% C{n,3} is accel x data for drop n
% C{n,4} is accel y data for drop n
% C{n,5} is accel z data for drop n
% C{n,6} is triax load x data for drop n
% C{n,7} is triax load y data for drop n
% C{n,8} is triax load z data for drop n

if varin == 5
    f = '%f%f%f%f%f'; %string pot, single ax load, triax accel
end

if varin == 8
    f = '%f%f%f%f%f%f%f%f'; %If triaxial load cell included
end


path = ['/',folder_path,files];

filelist = dir(path)

% Check number of Files and variables
ifiles = size(filelist,1)

C = cell(ifiles,varin);

for i=1:ifiles
   
    % Open the data file, read in the data
    fileid = fopen(filelist(i,1).name);
    C(i,:) = textscan(fileid,f,'HeaderLines',num_headerlines);
    fclose(fileid);
    
end
   
