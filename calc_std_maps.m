%% load all data
parentDir = '/Volumes/home/Research/Schizo/PreProc/Nback';
cd(parentDir);
subjects=fdir(parentDir);
allData=zeros(91,109,91,length(subjects));
for s=1:length(subjects)
    disp(s);
    subj=subjects{s};
    img=niftiread([parentDir '/' subj '/' subj '2_MD_standard.nii.gz']);
    allData(:,:,:,s)=img;
end

%% Calculate STD maps

STD = std(allData,0,4);
figure; imagesc(STD(:,:,40));axis image;axis off;colormap jet
numSubj=size(allData,4);
Result=zeros(numSubj,1);
for i=1:numSubj
    disp([num2str(i) ' out of ' num2str(numSubj)]);
    idx=setdiff(1:numSubj,i);
    tmpSTD = std(allData(:,:,:,idx),0,4);
    Result(i)=sum(tmpSTD(:));
end

figure;plot(Results)



