function files = fdir (filter,dtype)
if nargin==2
    if strcmp(dtype,'dir')
        files = fdir_dir(filter);
        return
    end
end
files = dir(filter);
files = struct2cell(files);
files = files(1,:)';
end

function files = fdir_dir(filter)
    files = dir(filter);
    files = struct2cell(files);
    isdirs = files(4,:)';
    aredirs = find(cell2mat(isdirs)==1);
    files = files(1,:)';
    files = files(aredirs); %leave in only directories
    files = files(3:end); %remove '.' and '..'
end