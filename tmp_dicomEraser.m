%%
Files=dir('*.dcm');
filesList=cell(length(Files),1);

filesTime=zeros(length(Files),1);

for i=1:length(Files)
    if mod(i,50)==0
        disp(i)
    end
    filesList{i}=Files(i).name;
    %INFO=dicominfo(filesList{i});
    %filesTime(i)=str2double(INFO.AcquisitionTime);
end
%%
bla=zeros(length(Files),1);
for i=1:length(bla)
  bla(i)=str2double(filesList{i}(12:14));  
end

bla=unique(bla);
%%
A=zeros(size(bla));
for i=1:length(bla)
    if bla(i)<10
        A(i)=length(dir(['*_00' num2str(bla(i)) '*.dcm']));
    elseif bla(i)<100
        A(i)=length(dir(['*_0' num2str(bla(i)) '*.dcm']));
    else
        A(i)=length(dir(['*_' num2str(bla(i)) '*.dcm']));
    end
end

%%
Erase=zeros(length(B),1)
for k=1:length(B)
for d=1:length(filesList)
    if filesList(d)=='*44.dcm'
        Erase(k)=filesList(d)
    end
end
end

    


    
