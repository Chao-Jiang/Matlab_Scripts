function run_fMRIVolume_HCP(subject, myPath, dcm_folder, bash_profile)


%this part makes sure the pipline can run even if some of the functional
%scans are missing. feel free to add task names to the list, but remember
%to add a condition for it later. if unclear, contact shachar

fMRI_Names = {'rfMRI_REST_AP', 'rfMRI_REST_PA', 'tfMRI_Piano_AP', 'tfMRI_TASK_Nbcak_AP'}; % note to self - get daniel to change the name for the nback files to be without "TASK"
raw_dir = fdir([dcm_folder '/subject' num2str(subject)]);
fmri_name_mask = zeros(1,3);
if any(contains(raw_dir,'rfMRI_REST_AP'))
    fmri_name_mask(1) = 1;
end
if any(contains(raw_dir,'rfMRI_REST_PA'))
    fmri_name_mask(2) = 1;
end
if any(contains(raw_dir,'tfMRI_Piano_AP'))
    fmri_name_mask(3) = 1;
end
if any(contains(raw_dir,'tfMRI_TASK_Nbcak_AP'))
    fmri_name_mask(4) = 1;
end
fMRI_Names = fMRI_Names(logical(fmri_name_mask));

% matts' example says to set these to NONE if we used TOPUP
fmapmag = 'NONE'; 
fmapphase = 'NONE';
echodiff= 'NONE';
gdcoeffs = 'NONE';

fmapgeneralelectric = 'NONE'; % we dont do gradient echo Distortion Correction

echospacing = '0.000564992';

fmrires = '2';

dcmethod = 'TOPUP'; 

topupconfig = '${HCPPIPEDIR_Config}/b02b0.cnf';
    
    biascorrection = 'SEBASED'; % make sure with niv
for fScan = 1:length(fMRI_Names)
    fmriname = fMRI_Names{fScan};
    
    scanDir = fdir([myPath '/' num2str(subject) '/unprocessed/3T/' fmriname]); 
    ref = contains(lower(scanDir), 'ref');
    fmriimgloc = ~ref & contains(scanDir, 'nii') & contains(lower(scanDir), 'fmri');
    fmritcs = [myPath '/' num2str(subject) '/unprocessed/3T/' fmriname '/' scanDir{fmriimgloc}];
    
    refimgloc = ref & contains(scanDir, 'nii');
    fmriscout = [myPath '/' num2str(subject) '/unprocessed/3T/' fmriname '/' scanDir{refimgloc}];
    
    direction = fmriname(end-1:end);
    if strcmp(direction, 'AP')
        unwarpdir = 'y-';
    elseif strcmp(direction, 'PA')
        unwarpdir = 'y';
    end
    
    SEPhaseNeg = [myPath '/' num2str(subject) '/unprocessed/3T/' fmriname '/' scanDir{contains(scanDir, 'SpinEchoFieldMap_AP') & contains(scanDir, 'nii')}];
    SEPhasePos = [myPath '/' num2str(subject) '/unprocessed/3T/' fmriname '/' scanDir{contains(scanDir, 'SpinEchoFieldMap_PA') & contains(scanDir, 'nii')}];
    
    
    
    syscommand(['/Volumes/HCP/HCPpipelines-master/fMRIVolume/GenericfMRIVolumeProcessingPipeline.sh --path=' myPath ' --subject=' num2str(subject)...
        ' --fmriname=' fmriname ' --fmritcs=' fmritcs ' --fmriscout=' fmriscout ' --SEPhaseNeg=' SEPhaseNeg ' --SEPhasePos=' SEPhasePos ' --fmapmag=' fmapmag...
        ' --fmapphase=' fmapphase ' --fmapgeneralelectric=' fmapgeneralelectric ' --echospacing=' echospacing...
        ' --echodiff=' echodiff ' --unwarpdir=' unwarpdir ' --fmrires=' fmrires ' --dcmethod=' dcmethod ' --biascorrection=' biascorrection...
        ' --gdcoeffs=' gdcoeffs ' --topupconfig=' topupconfig], bash_profile);

end
end
    
    