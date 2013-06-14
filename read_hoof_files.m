function [DropSet] = read_hoof_files(folder_path, files, num_headerlines, varin)

% where files = indicators for which files to include, i.e. '11*.txt'
    %NOTE: importance of 'files' is the inclusion of '.' and '..' by the
    %dir() Matlab function

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
    numfields = '%f%f%f%f%f'; %string pot, single ax load, triax accel
end

if varin == 8
    numfields = '%f%f%f%f%f%f%f%f'; %If triaxial load cell included
end

path = folder_path
filelist = dir([path, files]);

numfiles = size(filelist,1)

DropSet = cell(numfiles,varin);

for i=1:numfiles
    % Open the data file, read in the data
    filepath = [path, filelist(i,1).name]
    file = fopen(filepath);
    DropSet(i,:) = textscan(file, numfields,'HeaderLines',num_headerlines);
    fclose(file);
end
   
