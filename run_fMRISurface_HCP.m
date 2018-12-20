function run_fMRISurface_HCP(subject, myPath, dcm_folder, bash_profile)

%this part makes sure the pipline can run even if some of the functional
%scans are missing

fMRI_Names = {'rfMRI_REST_AP', 'rfMRI_REST_PA', 'tfMRI_Piano_AP', 'tfMRI_TASK_Nbcak_AP'};
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

lowresmesh = '32';
fmrires = '2';
smoothingFWHM = '4'; % need to decide if this is optimal
grayordinatesres = '2';
regname = 'MSMSulc';

for fScan = 1:length(fMRI_Names)   
    fmriname = fMRI_Names{fScan};
    syscommand(['/Volumes/HCP/HCPpipelines-master/fMRISurface/GenericfMRISurfaceProcessingPipeline.sh --path=' myPath ' --subject=' num2str(subject)...
         ' --fmriname=' fmriname ' --lowresmesh=' lowresmesh ' --fmrires=' fmrires ' --smoothingFWHM=' smoothingFWHM ' --grayordinatesres=' grayordinatesres...
         ' --regname=' regname], bash_profile);      
end
end
    
    