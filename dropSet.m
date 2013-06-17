classdef dropSet
    properties
        isThreeAxLoad
        
        pos
        load
        accx
        accy
        accz
        loadx
        loady
        loadz
        
    end
    methods
        %constructor for dropSet class
        %takes a path (can be absolute or relative, but must be followed
        %with a trailing '\'), number of headerlines in the ascii files,
        %and a boolean for whether the data has 3 axis load data
        function obj = dropSet(path, num_headerlines, three_axis_load)
            fext = '*.txt';
            flist = dir([path, fext]);
            numfiles = size(flist,1);
            
            obj.isThreeAxLoad = three_axis_load;
            
            if three_axis_load == 0
                numfields = '%f%f%f%f%f'; %string pot, single ax load, triax accel
                num_cols = 5;
            elseif three_axis_load == 1
                numfields = '%f%f%f%f%f%f%f%f'; %If triaxial load cell included
                num_cols = 8;
            end
            
            data = cell(numfiles, num_cols);
            
            for i=1:numfiles
                filepath = [path, flist(i,1).name];
                file = fopen(filepath);
                data(i,:) = textscan(file, numfields, 'HeaderLines', num_headerlines);
                fclose(file);
            end
            
            for i=1:numfiles
                obj.pos(:,i) = data{i,1}(:,1);    
                obj.load(:,i) = data{i,2}(:,1);
                obj.accx(:,i) = data{i,8}(:,1);    
                obj.accy(:,i) = data{i,6}(:,1);    
                obj.accz(:,i) = data{i,7}(:,1);

                if obj.isThreeAxLoad == 1;
                    obj.loadx(:,i) = data{i,4}(:,1);
                    obj.loady(:,i) = data{i,3}(:,1);
                    obj.loadz(:,i) = data{i,5}(:,1);
                end
            end
        end 
    end
end