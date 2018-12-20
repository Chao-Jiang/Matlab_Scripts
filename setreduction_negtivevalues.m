
myMask=read_avw('/usr/local/fsl/data/standard/tissuepriors/avg152T1_gray.img').*0.00392;
mask_idx = find(myMask>0.5);

standardImg='/usr/local/fsl/data/standard/MNI152lin_T1_2mm_brain.nii.gz';
parentDir=uigetdir('/Users/nivtik/Research/Piano/Pilot/Feat','Select directory');
myDirs=fdir([parentDir '/*.feat']); % folder names need to be as such: 01, 02.
num_of_contrasts = 9; % need to be drawn from design?
ref_dir = uigetdir('/Users/nivtik/Research/Piano/Pilot/Feat','Select directory');

myThresh=input('Set threshold: ');

dices=zeros(length(myDirs),num_of_contrasts);
corrs_unthresh=zeros(length(myDirs),num_of_contrasts);
corrs_thresh=zeros(length(myDirs),num_of_contrasts);
figure;
for cont=1:num_of_contrasts
    %myContrast_thresh=['thresh_zstat' num2str(cont) '.nii.gz'];
    %myContras_no_thresh=['/stats/zstat' num2str(cont) '.nii.gz'];
    disp(cont)
    
    myContrast=['/stats/zstat' num2str(cont) '.nii.gz'];
    ref_path = [ref_dir '/' myContrast];
    warped_ref_path = [ref_path(1:(end-7)) '_warped.nii.gz'];
    ref_warp_mat = [parentDir '/' myDirs{length(myDirs)} '/' 'reg/example_func2standard_warp.nii.gz'];
    command_ref=['applywarp -i ' ref_path ' -o ', warped_ref_path ' -r ' standardImg ' -w ' ref_warp_mat]; % applywarp command for usage in terminal
    system(command_ref);
    ref=niftiread(warped_ref_path);
    

    ref_thresh=double(ref<=myThresh);
    ref_no_thresh=double(ref);
    
    ref_thresh_notbin = ref_no_thresh;
    ref_thresh_notbin(~logical(ref_thresh)) = 0;
    
    %dices=zeros(length(myDirs),1); % how not to over run this?
    %corrs_unthresh=zeros(length(myDirs),1); % how not to over run this?
    for i=1:length(myDirs)
        disp([num2str(i) ' out of ' num2str(length(myDirs))]);
        
        
        fullpath = [parentDir '/' myDirs{i} '/' myContrast]; % zstat of current contrast
        warp_mat_path = [parentDir '/' myDirs{i} '/' 'reg/example_func2standard_warp.nii.gz']; % warping matrix for current zstat
        warped_file_path = [fullpath(1:(end-7)) '_warped.nii.gz']; % output path for applywarp
        command=['applywarp -i ' fullpath  ' -o ', warped_file_path ' -r ' standardImg ' -w ' warp_mat_path]; % applywarp command for usage in terminal
        %system(command); % comment back when need to warp
        
        mySet = niftiread(warped_file_path);

        % calc dice for threshold stats
        mySet_thresh = double(mySet<=myThresh);
        dices(i,cont)=dice(ref_thresh(:),mySet_thresh(:));
        
        % calc corr for non threshhold and threshholded stats
        mySet_no_thresh = double(mySet);
        mySet_thresh_notbin = mySet_no_thresh;
        mySet_thresh_notbin(~logical(mySet_thresh)) = 0; %sets all values under thresh to 0
        corrs_unthresh(i,cont)=corr(ref_no_thresh(mask_idx),mySet_no_thresh(mask_idx));
        corrs_thresh(i,cont)=corr(ref_thresh_notbin(mask_idx),mySet_thresh_notbin(mask_idx));
    end
    
    cont_Name={'Fur_Elise>Quiet','Prelude>Quiet','Wnoise>Quiet','Prelude>Wnoise','Prelude>Fur_Elise','Wnoise>Fur_Elise','Music>Not_Music','Sound>Quiet','Music>Quiet'};
    snugplot(3,3,cont)
    plot(dices(:,cont),'b','LineWidth',3)
    title(cont_Name{cont})
    set(gcf, 'position', [800 500 1200 400]);
    set(gcf,'color','w');
    hold on
    plot(corrs_unthresh(:,cont),'r','LineWidth',3);
    hold on
    plot(corrs_thresh(:,cont), 'g', 'LineWidth',3);
    ylim([0 1])
    legend('Dice','Untresh Corr', 'Thresh Corr', 'Location','best');
end






