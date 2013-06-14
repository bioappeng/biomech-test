function [DropSet] = load_data(num_headerlines, varin)

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

% this bit should be replaced by something in the ui
%----------------
if varin == 5
    numfields = '%f%f%f%f%f'; %string pot, single ax load, triax accel
end

if varin == 8
    numfields = '%f%f%f%f%f%f%f%f'; %If triaxial load cell included
end
%----------------

fext = '*.txt';
path = [uigetdir(pwd, 'select data location'), '\'];
flist = dir([path, fext]);
numfiles = size(flist,1)

DropSet = cell(numfiles,varin);

%load datafiles
for i=1:numfiles
    filepath = [path, flist(i,1).name];
    file = fopen(filepath);
    DropSet(i,:) = textscan(file, numfields, 'HeaderLines', num_headerlines);
    fclose(file);
end