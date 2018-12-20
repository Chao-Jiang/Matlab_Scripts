%%
setenv('FSLDIR','/usr/local/fsl');
myMask=read_avw('/usr/local/fsl/data/standard/tissuepriors/avg152T1_gray.img').*0.00392;
mask_idx = find(myMask>0.5);

parentDir='/Users/nivtik/Research/Piano/Pilot/Feat/NT_250218/Set_reductionB';
myDirs=fdir([parentDir '/*.feat']);
num_of_contrasts = 9; % need to be drawn from design?

dices=zeros(8,num_of_contrasts);
corrs=zeros(8,num_of_contrasts);
figure;
for cont=1:num_of_contrasts
    myContrast_thresh=['thresh_zstat' num2str(cont) '.nii.gz'];
    myContrast_no_thresh=['/stats/zstat' num2str(cont) '.nii.gz'];
    
    %ref=[parentDir '/' myDirs{end}];
    ref=[parentDir '/set08.feat'];
    ref_thresh=niftiread([ref '/' myContrast_thresh]);
    ref_no_thresh=niftiread([ref '/' myContrast_no_thresh]);
    
    ref_thresh=double(ref_thresh~=0);
    ref_no_thresh=double(ref_no_thresh);
    
    %dices=zeros(length(myDirs),1); % how not to over run this?
    %corrs=zeros(length(myDirs),1); % how not to over run this?
    
    %for i=1:length(myDirs)
    for i=1:8
        disp([num2str(i) ' out of ' num2str(length(myDirs))]);
        % calc dice for threshold stats
        fullPath_thresh = [parentDir '/' myDirs{i} '/' myContrast_thresh];
        mySet_thresh = niftiread(fullPath_thresh);
        mySet_thresh = double(mySet_thresh~=0);
        dices(i,cont)=dice(ref_thresh(:),mySet_thresh(:));
        
        % calc corr for non threshhold stats
        fullPath_no_thresh = [parentDir '/' myDirs{i} '/' myContrast_no_thresh];
        mySet_no_thresh = niftiread(fullPath_no_thresh);
        mySet_no_thresh = double(mySet_no_thresh);
        corrs(i,cont)=corr(ref_no_thresh(mask_idx),mySet_no_thresh(mask_idx));
    end
    snugplot(3,3,cont)
    plot(dices(:,cont),'b','LineWidth',3)
    title(num2str(cont))
    set(gcf, 'position', [800 500 1200 400]);
    set(gcf,'color','w');
    ylim([0 1])
    
    hold on
    plot(corrs(:,cont),'r','LineWidth',3);
    
    legend('Dice','Corr','Location','best');
end






