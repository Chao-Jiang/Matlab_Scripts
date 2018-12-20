clear all
m=dir('.');
len=length({m.name});
name=strings;
b=1;
for i=1:len
    if strfind(m(i).name,'.nii')>0
        name(b)=m(i).name;
        b=b+1;
    end
end

for c=1:length(name)
fullname=name(c);
splitname=strsplit(fullname,'_mean_DWIs.nii');
truEname=splitname(1);
truEname=truEname{1};
code='sh /Users/nivtik/Research/Inbar/toRun/do_temp2native.sh ';
command=[code,truEname];
system(command)
end